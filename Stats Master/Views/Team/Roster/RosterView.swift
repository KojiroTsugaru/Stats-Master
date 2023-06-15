//
//  RosterView.swift
//  Stats Master
//
//  Created by KJ on 6/2/23.
//

import SwiftUI

struct RosterView: View {
    
    @State private var playerSelected: Player?
    
    // get reference to view context
    @Environment(\.managedObjectContext) private var viewContext
    
    let team: Team
    @StateObject private var teamData: TeamData
        
    init(team: Team) {
        self.team = team
        self._teamData = StateObject(wrappedValue: TeamData(team: team))
    }
    
    @State private var isShowingSheet = false
    
    var body: some View {
        NavigationView {
//            let players = team.players?.allObjects as! [Player]?
            if teamData.players.count > 0 {
                HStack {
                    // set default player
                    List(teamData.players, id: \.self) { p in
                        Button(action: {
                            withAnimation {
                                playerSelected = p
                            }
                        }) {
                            Text("#\(p.number)    \(p.firstname) \(p.lastname)")
                                .foregroundColor(playerSelected == p ? Color(.systemGray) : .black)
                        }
                    }
                    .listStyle(SidebarListStyle())
                    
                    if let player = playerSelected {
                        RosterDetailView(player: player)
                    } else {
                        RosterDetailView(player: (teamData.players.first)!)
                    }
                }
            }
            else {
                VStack {
                    Text("No Players in This Team")
                        .font(Font.callout)
                    Button {
                        isShowingSheet = true
                    } label: {
                        RoundedRectangle(cornerRadius: 90)
                            .shadow(radius: 1, x: 1, y: 1)
                            .frame(width: 120, height: 30)
                            .foregroundColor(Color("Color1"))
                            .overlay(
                                Text("Add Player")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .bold()
                                    .padding()
                            )
                            .padding(.top, 5)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem{
                NavigationLink(destination: AddPlayerView(teamToAddPlayerTo: team)
                    .navigationBarBackButtonHidden(true)) {
                        HStack{
                            Image(systemName: "plus")
                            Text("Add Player")
                        }.foregroundColor(.white)
                        .bold()
                            .padding()
                }
            }
        }
        .sheet(isPresented: $isShowingSheet, content: {
            AddPlayerView(teamToAddPlayerTo: team)
        })
        .navigationTitle("Roster")
        .navigationBarTitleDisplayMode(.large)
    }
}

//struct RosterView_Previews: PreviewProvider {
//    static var previews: some View {
//        RosterView(team: Team())
//            .previewInterfaceOrientation(.landscapeRight)
//    }
//}
