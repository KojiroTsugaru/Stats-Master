//
//  SelectStarterView.swift
//  Stats Master
//
//  Created by KJ on 5/22/23.
//

import SwiftUI

struct SelectStarterView: View {
    
    let team: Team
    @Binding var opp_name: String
    @Binding var gamename: String
    @Binding var logo: UIImage?
    
    // the color for the players selected
    @State private var starters: Set<Player> = []
    
    // Alert
    @State private var showAlert = false

    // get reference to view context
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationView {
            List {
                ForEach(team.players?.allObjects as! [Player]) { p in
                    Button {
                        if !starters.contains(p) && starters.count < 5 {
                            p.isStarting.toggle()
                            p.on_court.toggle()
                            starters.insert(p)
                        }
                        else if starters.count > 5 {
                            
                        }
                        else {
                            p.isStarting.toggle()
                            p.on_court.toggle()
                            starters.remove(p)
                        }
                        
                    } label: {
                        HStack{
                            // get image for each player
                            let image = UIImage(data: p.image ?? Data()) ?? UIImage()
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40) // Set your desired circle size
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2)) // Optional: Add a white stroke to the circle
                            
                            Text("#\(p.number)")
                            Text("\(p.firstname)")
                            Text("\(p.lastname)")
                        }.foregroundColor(starters.contains(p) ? .red : .black)
                    }
                }
            }
        }.toolbar(){
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 10) {
                    if isStartersFilled() {
                        NavigationLink {
                            let gameToPlay = createNewGame()
                            InGameView(game: gameToPlay)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Text("Start")
                        }
                    }
                    else {
                        Button {
                            showAlert = true
                        } label: {
                            Text("Start")
                        }

                    }
                }
            }
        }
        .navigationTitle("Select Starters")
        .navigationBarTitleDisplayMode(.large)
        
        // for save
        .onDisappear(){
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Select five players"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    func isStartersFilled() -> Bool {
        if self.starters.count < 5 {
            return false
        }
        return true
    }
    
    // Function to create a new game
    private func createNewGame() -> Game {
    
        let newGame = Game(context: viewContext)
        newGame.id = UUID()
        newGame.opp_name = self.opp_name
        newGame.name = self.gamename
        newGame.myteam_score = 0
        newGame.opp_score = 0
        newGame.myteam_name = self.team.name
        
        // create my_players for temporary use in game only.
        newGame.my_players = self.team.players
        
        // Initialize all the stats for players
        for p in newGame.my_players?.allObjects as! [Player] {
            p.point = 0
            p.assist  = 0
            p.block = 0
            p.def_reb = 0
            p.foul = 0
            p.off_reb = 0
            p.steal = 0
            p.turnover = 0
            p.isStarting = false
            p.on_court = false
            p.fg_made = 0
            p.fg_attempt = 0
            p.fg_percent = 0.0
            p.ft_made = 0
            p.ft_attempt = 0
            p.ft_percent = 0.0
            p.threepoint_made = 0
            p.threepoint_attempt = 0
            p.threepoint_percent = 0.0
            
            // set as starter
            if self.starters.contains(p) {
                p.on_court = true
                p.isStarting = true
            }
        }
        
        // opponent players, make something that user can select if
        // they want to record opponent info or not.
        self.team.addToGames(newGame)
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return newGame
    }
    
}

//struct SelectStarterView_Previews: PreviewProvider {
//
//    // get reference to view context
//    @Environment(\.managedObjectContext) private var viewContext
//
//    // get teams data from core data
//    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) private var teams: FetchedResults<Team>
//
//    lazy var sample_team = teams.first
//
//    static var previews: some View {
//        SelectStarterView(gameToPlay: <#Game#>)
//            .previewInterfaceOrientation(.landscapeRight)
//    }
//}
