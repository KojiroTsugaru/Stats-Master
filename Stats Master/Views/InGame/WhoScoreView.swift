//
//  WhoScoreView.swift
//  Stats Master
//
//  Created by KJ on 5/10/23.
//

import SwiftUI

struct WhoScoreView: View {
    
    // get reference to the game played
    let game: Game
    
    @Environment(\.presentationMode) var presentationMode
    
    // get reference to view context
    @Environment(\.managedObjectContext) private var viewContext
    
    // for updating stat data
    let statTapped: String
    
    // isMissShot from InGameView
    let isMissShot: Bool
    
    // For score log
    @Binding var scoreLog:Array<(String, Player)>
    
    // cell for each player
    fileprivate func playerCellView(player: Player) -> ZStack<some View> {
//        let backgroundColor = Color(.systemGreen)
        return ZStack{
            Button {
                // Function to update player's stats
                updataStat(player: player, statToUpdate: statTapped)
                
                // Insert the new score log
                withAnimation {
                    scoreLog.insert((statTapped.replacingOccurrences(of: "\n", with: ""), player), at: 0)
                }
                
                // hide WhoScoreView
                self.presentationMode.wrappedValue.dismiss()
                
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(colors: [Color("Color1"), Color(.systemCyan)], startPoint: .bottomLeading, endPoint: .topTrailing))
                    .frame(width: 200, height: 160)
                    .shadow(radius: 2)
                    .overlay {
                        ZStack(){
                            // get image for each player
                            let image = UIImage(data: player.image ?? Data()) ?? UIImage()
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 120) // Set your desired circle size
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2)) // Optional: Add a white stroke to the circle
                                .padding(.horizontal)
                                .offset(x: -45)
                            VStack{
                                Text("#\(player.number)")
                                    .italic()
                                    .fontWeight(.bold)
                                    .font(.system(size: 20))
                                VStack(alignment: .leading) {
                                    Text("\(player.firstname)")
                                    Text("\(player.lastname)")
                                }.font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .offset(x: 15)
                            }.foregroundColor(.black)
                                .offset(x: 40, y: -10)
                        }
                    }
                }
            }
        }
    
    var body: some View {
        VStack{
            // filter players by isStarting property
            let players = game.my_players?.allObjects as! [Player]
            let players_on_court = players.filter { $0.on_court == true }
            
            // displaying player cells
            VStack(alignment: .leading) {
                // First row
                HStack {
                    ForEach(0..<(players_on_court.count/2 + 1), id: \.self) { index in
                        
                        // create player
                        let p = players_on_court[index]
                        playerCellView(player: p)
                    }
                }
                // Second row
                HStack {
                    ForEach((players_on_court.count/2 + 1)..<(players_on_court.count), id: \.self) { index in
                        // create player
                        let p = players_on_court[index]
                        playerCellView(player: p)
                    }
                }
            }
        }
    }
    
    // Function to update stat seleceted
    private func updataStat(player: Player, statToUpdate: String) {
        
        switch(statToUpdate) {
        case "1pt":
            
            // update fg attempt and made
            player.ft_attempt += 1
            
            if !isMissShot {
                // update point
                player.point += 1
                player.ft_made += 1
            }
            
            // update ft percentage
            var cur_ft_made = Float(player.ft_made)
            var cur_ft_attempt = Float(player.ft_attempt)
            let new_ft_percent = (cur_ft_made/cur_ft_attempt)*100
            player.ft_percent = new_ft_percent
            
            // update score
            if player.team == game.team {
                game.myteam_score += 1
            }
            else {
                game.opp_score += 1
            }
            
            break
        case "2pt":
            
            // update fg attempt and made
            player.fg_attempt += 1
            
            if !isMissShot {
                // update point
                player.point += 2
                player.fg_made += 1
            }
            
            // update fg percentage
            let cur_fg_made = Float(player.fg_made)
            let cur_fg_attempt = Float(player.fg_attempt)
            let new_fg_percent = (cur_fg_made/cur_fg_attempt)*100
            player.fg_percent = new_fg_percent
            
            // update score
            if player.team == game.team {
                game.myteam_score += 2
            }
            else {
                game.opp_score += 2
            }
            
            break
        case "3pt":
            
            // update fg attempt and made
            player.fg_attempt += 1
            player.threepoint_attempt += 1
            
            if !isMissShot {
                // update point
                player.point += 3
                
                player.fg_made += 1
                player.threepoint_made += 1
            }
            
            // update fg percentage
            let cur_fg_made = Float(player.fg_made)
            let cur_fg_attempt = Float(player.fg_attempt)
            let new_fg_percent = (cur_fg_made/cur_fg_attempt)*100
            player.fg_percent = new_fg_percent
            
            // update threepoint fg percentage
            let cur_three_made = Float(player.threepoint_made)
            let cur_three_attempt = Float(player.threepoint_attempt)
            let new_three_percent = (cur_three_made/cur_three_attempt)*100
            player.threepoint_percent = new_three_percent
            
            // update score
            if player.team == game.team {
                game.myteam_score += 3
            }
            else {
                game.opp_score += 3
            }
            
            break
        case "Def\n reb":
            player.def_reb += 1
            break
        case "Off\n reb":
            player.off_reb += 1
            break
        case "asst":
            player.assist += 1
            break
        case "To":
            player.turnover += 1
            break
        case "stl":
            player.steal += 1
            break
        case "blk":
            player.block += 1
        case "foul":
            player.foul += 1
        default:
            break
        }
        
        // Save the changes to Core Data
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
}
//struct WhoScoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        WhoScoreView(game: <#T##Game#>, statTapped: "1pt")
//            .previewInterfaceOrientation(.landscapeRight)
//    }
//}
