//
//  inGameView.swift
//  Stats Master
//
//  Created by KJ on 5/10/23.
//

import SwiftUI

struct InGameView: View {
    // for stats buttons
    fileprivate func statButton(name: String, isMissShot: Bool) -> some View {
        return NavigationLink(destination: WhoScoreView(game: game, statTapped: name, isMissShot: isMissShot, scoreLog: $scoreLog)) {
            Text(name)
                .font(.system(size: 25))
                .foregroundColor(.black)
                .frame(width: 80, height: 80)
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 95)
                        .stroke(isMissShot ? Color(.systemRed) : Color("Color1"), lineWidth: 1.5)
                        .shadow(radius: 1, x: 1, y: 1)
                )
                .padding(5)
        }
    }
    
    // for the game to play
    let game: Game
    
    // for InGameScore view presentation
    @State private var isShowInGameScore = false
    
    // Substitution View Presentation
    @State private var isShowSub = false
    
    // Alert when quarters end.
    @State private var showAlert = false
    
    // score log in the middle
    @State var scoreLog:Array<(String, Player)> = []
    
    // Quarters
    let quarters = ["1st Quarter", "2nd Quarter", "3rd Quarter", "4th Quarter"]
    @State private var quarter_index = 0
    
    // navigate to HomeView
    @State private var navigateToHomeView = false
    
    // get reference to view context
    @Environment(\.managedObjectContext) private var viewContext
    
    // Players' stats before the game starts.
    let playersBeforeGame: [Player]
    init(game: Game) {
        self.game = game
        self.playersBeforeGame = game.my_players?.allObjects as! [Player]
    }
    
    var body: some View {
        NavigationView {
            HStack{
                // stats view 1
                VStack{
                    HStack{
                        Spacer()
                        VStack{
                            statButton(name: "3pt", isMissShot: false)
                            statButton(name: "2pt", isMissShot: false)
                            statButton(name: "1pt", isMissShot: false)
                        }
                        .padding(.horizontal)
                        VStack{
                            statButton(name: "3pt", isMissShot: true)
                            statButton(name: "2pt", isMissShot: true)
                            statButton(name: "1pt", isMissShot: true)
                        }
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        
                        Button {
                            isShowInGameScore.toggle()
                        } label: {
                            Image(systemName: "line.horizontal.3")
                                .font(.system(size: 30))
                                .foregroundColor(Color("Color1"))
                                .padding(.horizontal, 65)
                                .padding(.top)
                                .offset(x: 31)
                        }
                        Button {
                            // remove the newest scorelog.
                            if !scoreLog.isEmpty {
                                scoreLog.remove(at: 0)
                            }
                        } label: {
                            Image(systemName: "arrow.uturn.backward")
                                .font(.system(size: 25))
                                .foregroundColor(Color("Color1"))
                                .padding(.horizontal, 65)
                                .padding(.top)
                                .offset(x: -22)
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                Spacer()
                // timer など
                VStack{
                    ZStack{
                        Rectangle()
                            .foregroundColor(.white)
                            .shadow(color: .gray.opacity(0.2), radius: 10, x: 1, y: 1)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .frame(width: 230)
                            .ignoresSafeArea(.all)
                        VStack(){
                            
                            // Vstack for score
                            VStack(alignment: .leading) {
                                HStack{
                                    Text(game.myteam_name)
                                    Spacer()
                                    Text("\(game.myteam_score)")
                                }
                                .padding(.bottom, 2)
                                .padding(.horizontal)
                                HStack{
                                    Text(game.opp_name)
                                    Spacer()
                                    Text("\(game.opp_score)")
                                }
                                .padding(.horizontal)
                            }
                            .font(.system(size: 20))
                            .bold()
                            .padding(.top, 5)
                            
                            // Scroll view for scoring log
                            ScrollView(.vertical, showsIndicators: false) {
                                    VStack(alignment: .center){
                                        ForEach(scoreLog.indices, id: \.self) { index in
                                            let (stat, player) = scoreLog[index]
                                            
                                            // Access the string value and player object here
                                            VStack {
                                                Text(stat)
                                                    .foregroundColor(Color(.systemGreen))
                                                Text("#\(player.number) \(player.lastname)")
                                                    .padding(.bottom)
                                            }.transition(.move(edge: .top))
                                        }
                                    }.animation(.easeInOut(duration: 0.3))
                                    .offset(y: scoreLog.isEmpty ? 0 : CGFloat(scoreLog.count - 1) * .leastNonzeroMagnitude)
                            }
                            
                            Spacer()
                            
                            // Quarter
                            Text(quarters[quarter_index])
                                .padding(.leastNonzeroMagnitude)
                                .bold()
                            
                            Button {
                                // Add action when quarters end
                                showAlert = true
                            } label: {
                                RoundedRectangle(cornerRadius: 90)
                                    .shadow(radius: 2)
                                    .frame(width: 180, height: 45)
                                    .foregroundColor(.white)
                                    .overlay(
                                        Text("End Qtr")
                                            .font(.system(size: 20))
                                            .foregroundColor(.black)
                                            .bold()
                                    )
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 90)
                                            .stroke(Color("Color1"), lineWidth: 2)
                                    }
                            }
                        }
                    }.offset(x: -30)
                }
                Spacer()
                //stats view 2
                VStack{
                    HStack{
                        Spacer()
                        VStack{
                            statButton(name: "Def\n reb", isMissShot: false)
                            statButton(name: "To", isMissShot: false)
                            statButton(name: "asst", isMissShot: false)
                        }
                        .padding(.horizontal)
                        VStack{
                            statButton(name: "Off\n reb", isMissShot: false)
                            statButton(name: "stl", isMissShot: false)
                            statButton(name: "blk", isMissShot: false)
                        }
                        Spacer()
                    }
                    HStack{
                        Button {
                            // show SubstitutionView
                            isShowSub = true
                        } label: {
                            Text("subs")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                                .frame(width: 75, height: 40)
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 90)
                                        .stroke(Color(.systemRed), lineWidth: 1.5)
                                        .shadow(radius: 1, x: 1, y: 1)
                                )
                        }.offset(x: -8)
                        
                        NavigationLink(destination: WhoScoreView(game: game, statTapped: "foul", isMissShot: false, scoreLog: $scoreLog)){
                            Text("foul")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                                .frame(width: 75, height: 40)
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 180)
                                        .stroke(Color("Color1"), lineWidth: 1.5)
                                        .shadow(radius: 1, x: 1, y: 1)
                                )
                                .offset(x: 25)
                        }
                    }
                }.offset(x: -20)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        // alert when quarters end.
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("End \(quarters[quarter_index])"),
                primaryButton: .cancel(
                    Text("Cancel")
                ),
                secondaryButton: .default(
                    Text("Yes"),
                    action: {
                        // Action when quarters end.
                        if quarter_index == (quarters.count - 1) {
                            
                            // Add action when the game finishes
                            finishGame()
                            
                            // Action to end game
                            navigateToHomeView = true
                        }
                        else {
                            quarter_index += 1
                        }
                    }
                )
            )
        }
        .background(
            NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true), isActive: $navigateToHomeView) {
                EmptyView()
            }
        )
        
        // for in-game score view
        .overlay(inGameScore)
        .overlay(substitution)
        
    }
    
    // for in-game score view
    var inGameScore: some View {
            ZStack {
                if isShowInGameScore {
                    Color.gray.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            // Dismiss the overlay when tapped
                            isShowInGameScore.toggle()
                        }
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.3))
                    
                    InGameScoreView(game: game, navigateToHomeView: $navigateToHomeView, isShow: $isShowInGameScore)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut(duration: 0.3))
                }
            }
        }
    
    // for substitution view
    var substitution: some View {
            ZStack {
                if isShowSub {
                    Color.gray.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            // Dismiss the overlay when tapped
                            isShowSub.toggle()
                        }
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.3))
                    
                    SubstitutionView(game: game, isShowSub: $isShowSub)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut(duration: 0.3))
                }
            }
        }
    
    // Action when the game finishes.
    private func finishGame() {
        
        let team = game.team
        
        do {
            // update properties in team
            team?.gamePlayed += 1
            if game.myteam_score > game.opp_score {
                team?.win += 1
            }
            else {
                team?.loss += 1
            }
            
            // get team
            let players_in_game = Array(game.my_players?.allObjects as! [Player])
            
            // update all the properties in Player
            for p in team?.players?.allObjects as! [Player] {
                if let index = playersBeforeGame.firstIndex(where: { $0.id == p.id }) {
                    
                    let player = playersBeforeGame[index]
                    
                    p.point += player.point
                    p.assist += player.assist
                    p.block += player.block
                    p.def_reb += player.def_reb
                    p.off_reb += player.off_reb
                    p.turnover += player.turnover
                    p.foul += player.foul
                    p.steal += player.steal

                    p.fg_attempt += player.fg_attempt
                    p.fg_made += player.fg_made
                    p.ft_made += player.fg_made
                    p.ft_attempt += player.ft_attempt
                    p.threepoint_made = player.threepoint_made
                    p.threepoint_attempt = player.threepoint_attempt

                    // TODO: fg percent
                    p.fg_percent += player.fg_percent
                    p.ft_percent += player.ft_percent
                    p.threepoint_percent += player.threepoint_percent
                }
                p.gamePlayed += 1
            }
            
            // Save the changes to Core Data
            try viewContext.save()
                    
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    
}




//
//struct InGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        InGameView(game: test_game)
//            .previewInterfaceOrientation(.landscapeRight)
//    }
//}
