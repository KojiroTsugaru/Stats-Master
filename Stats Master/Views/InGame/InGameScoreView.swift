//
//  InGameScoreView.swift
//  Stats Master
//
//  Created by KJ on 5/20/23.
//

import SwiftUI

struct InGameScoreView: View {
    
    let game: Game
    
    // To end the game
    @Binding var navigateToHomeView: Bool
    
    // Alert when ending the game
    @State private var showAlert = false
    
    @Binding var isShow: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 700, height: 350)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 5, y: 2)
                .overlay {
                    VStack {
                        HStack {
                            Button {
                                isShow.toggle()
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(.black)
                                    .font(.system(size: 25))
                            }.padding()
                            Spacer()
                        }
                        
                        HStack{
                            VStack (alignment: .leading){
                                ForEach(game.my_players?.allObjects as! [Player]) { p in
                                    if p.isStarting  {
                                        HStack{
                                            Text("\(p.number)")
                                            Text("\(p.firstname) \(p.lastname) ")
                                                .padding(.trailing, 20)
                                            Text("\(p.point)")
                                                .padding(.horizontal)
                                            Text("\(p.fg_percent, specifier: "%.1f")%")
                                                .padding(.horizontal)
                                            
                                        }.padding(.bottom, 1)
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                        
                        HStack {
                            Button {
                                // Add action to have a break inm the middle of the game
                            } label: {
                                RoundedRectangle(cornerRadius: 90)
                                    .stroke(Color(.systemGreen), lineWidth: 1.5)
                                    .shadow(radius: 1, x: 1, y: 1)
                                    .frame(width: 90, height: 45)
                                    .overlay(
                                        Text("Break")
                                            .font(.system(size: 20))
                                            .foregroundColor(.black)
                                    )
                                    .padding()
                            }
                            
                            Button {
                                // Add action to force to end the game
                                showAlert = true
                                
                            } label: {
                                RoundedRectangle(cornerRadius: 90)
                                    .stroke(Color(.systemRed), lineWidth: 1.5)
                                    .shadow(radius: 1, x: 1, y: 1)
                                    .frame(width: 90, height: 45)
                                    .overlay(
                                        Text("End")
                                            .font(.system(size: 20))
                                            .foregroundColor(.black)
                                    )
                                    .padding()
                            }
                        }
                    }
                }
            
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("End game"),
                message: Text("You will lose all data from this game"),
                primaryButton: .cancel(
                    Text("Cancel")
                ),
                secondaryButton: .destructive(
                    Text("End"),
                    action: {
                        // Action to force to end the game.
                        navigateToHomeView = true
                    }
                )
            )
        }
    }
}
    
//struct InGameScoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        InGameScoreView()
//            .previewInterfaceOrientation(.landscapeRight)
//    }
//}

