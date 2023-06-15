//
//  substitutionView.swift
//  Stats Master
//
//  Created by KJ on 5/30/23.
//

import SwiftUI

struct SubstitutionView: View {
    
    let game: Game
    
    // the color for the players selected
    @State private var players_on_court =  Set<Player>()

    // get reference to view context
    @Environment(\.managedObjectContext) private var viewContext
    
    // for presentation of this sheet
    @Binding var isShowSub: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 600, height: 300)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 5, y: 2)
                .overlay {
                    NavigationView {
                        List {
                            ForEach(game.my_players?.allObjects as! [Player]) { p in
                                Button {
                                    if !players_on_court.contains(p) && players_on_court.count < 5 {
                                        p.isStarting.toggle()
                                        p.on_court.toggle()
                                        players_on_court.insert(p)
                                    }
                                    else if players_on_court.count > 5 {
                                        
                                    }
                                    else {
                                        p.isStarting.toggle()
                                        p.on_court.toggle()
                                        players_on_court.remove(p)
                                    }
                                    
                                } label: {
                                    HStack{
                                        // get image for each player
                                        let image = UIImage(data: p.image ?? Data()) ?? UIImage()
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30)
                                            .clipShape(Circle())
                                        
                                        Text(p.number)
                                        Text("\(p.firstname)")
                                        Text("\(p.lastname)")
                                    }.foregroundColor(players_on_court.contains(p) ? .red : .black)
                                }
                            }
                        }
                        .toolbar(){
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    // save change
                                    do {
                                        try viewContext.save()
                                    } catch {
                                        print("crash test")
                                        // Replace this implementation with code to handle the error appropriately.
                                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                                        let nsError = error as NSError
                                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                    }
                                    
                                    isShowSub = false
                                } label: {
                                    Text("Save")
                                }
                            }
                        }
                        .navigationTitle("Player Subs")
                    }.padding(3)
                }
        }
        .onAppear() {
            let players = game.my_players?.allObjects as! [Player]
            players_on_court = Set(players.filter { $0.on_court })
        }
    }
}

//struct SubstitutionView_Previews: PreviewProvider {
//    static var previews: some View {
//        SubstitutionView()
//    }
//}
