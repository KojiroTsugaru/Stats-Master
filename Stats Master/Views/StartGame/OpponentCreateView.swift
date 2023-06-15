//
//  OpponentSelectView.swift
//  Stats Master
//
//  Created by KJ on 5/10/23.
//

import SwiftUI

struct OpponentCreateView: View {
    // for text fields
    @State var opp_name: String = ""
    @State var gamename: String = ""
    @State var logo: UIImage?
    
    @State private var showAlert = false
    
    // for team selected
    let teamSelected: Team
    
    // Player Image
    @State private var teamImage = UIImage(named: "logo2")
    // Placeholder for Player image
    @State private var placeholderTeamImage = Image("logo2")
    // Image picker
    @State private var isShowingImagePicker = false
    
    // get reference to view context
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            HStack{
                Form {
                    Section(header: Text("Team Info").font(.headline).foregroundColor(.black)) {
                        TextField("Team Name", text: $opp_name)
                    }
                    Section(header: Text("Game Info").font(.headline).foregroundColor(.black)) {
                        TextField("Game Name", text: $gamename)
                    }
                }.frame(width: 450, alignment: .leading)
                Spacer()
                VStack {
                    placeholderTeamImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200) // Set your desired circle size
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 2)) // Optional: Add a white stroke to the circle
                        .shadow(radius: 1) // Optional: Add a shadow to the circle
                    Button {
                        isShowingImagePicker = true
                    } label: {
                        RoundedRectangle(cornerRadius: 90)
                            .shadow(radius: 1, x: 1, y: 1)
                            .frame(width: 120, height: 40)
                            .foregroundColor(.white)
                            .overlay(
                                Text("Change")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .bold()
                                    .padding()
                            )
                            .padding(.top, 10)
                    }
                }
                Spacer()
            }
            .background(Color(.systemGray6))
            .scrollContentBackground(.hidden)
            // Alert
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Fill out opponent's name"),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationTitle("Create Opponent")
            .navigationBarBackButtonHidden(true)
            // Navigation Link to next view
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .bold()
                            Text("Team Select")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if isOppnameEmpty() {
                        Button {
                            showAlert = true
                        } label: {
                            Text("Next")
                        }

                    } else {
                        NavigationLink {
                            SelectStarterView(team: teamSelected, opp_name: $opp_name, gamename: $gamename, logo: $logo)
                        } label: {
                            Text("Next")
                        }
                    }
                }
            }
        }
    }
    
    // Check if team info is filled
    private func isOppnameEmpty() -> Bool {
        if self.opp_name == "" {
            return true
        }
        return false
    }
    
    // Function to create a new game
    private func createNewGame(opp_name: String, gamename: String) -> Game {
    
        let newGame = Game(context: viewContext)
        newGame.id = UUID()
        newGame.opp_name = opp_name
        newGame.name = gamename
        newGame.myteam_score = 0
        newGame.opp_score = 0
        newGame.myteam_name = teamSelected.name
        
        // create my_players for temporary use in game only.
        newGame.my_players = teamSelected.players
        
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
        }
        
        
        // opponent players, make something that user can select if
        // they want to record opponent info or not.
        teamSelected.addToGames(newGame)
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return newGame
    }
}

//struct OpponentSelectView_Previews: PreviewProvider {
//    static var previews: some View {
//        OpponentSelectView(isShowNewGame: Binding.constant(true), inGameView: Binding.constant(false), teamSelected: test_team)
//    }
//}
