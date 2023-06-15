//
//  GamePlayedView.swift
//  Stats Master
//
//  Created by KJ on 6/3/23.
//

import SwiftUI

struct GamePlayedView: View {
    
    let team: Team
    @State var isShowingSheet = false
    @State private var gameSelected: Game?
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            List(Array(team.games ?? []) as! [Game]){ g in
                if g.my_players?.allObjects.count as! Int > 0 {
                    Button {
                        showGameSheet(gameSelected: g, completion: {
                            isShowingSheet = true
                        })
                    } label: {
                        HStack {
                            Text(g.name ?? "\(g.myteam_name) vs \(g.opp_name)")
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .navigationTitle("Games")
            .sheet(isPresented: $isShowingSheet) {
                if let game = gameSelected {
                    GameSummaryView(game: game)
                        .animation(.easeInOut(duration: 0.5))
                }
                else {
                    Button {
                        isShowingSheet = false
                    } label: {
                        
                    }
                }
            }
        }
    }
    
    private func showGameSheet(gameSelected: Game, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation {
                self.gameSelected = gameSelected
            }
        }
        completion()
    }
}

//struct GamePlayedView_Previews: PreviewProvider {
//    static var previews: some View {
//        GamePlayedView(team: Team())
//    }
//}
