//
//  RosterDetailView.swift
//  Stats Master
//
//  Created by KJ on 6/2/23.
//

import SwiftUI

struct RosterDetailView: View {
    
    let player: Player
    
    @State var isShowingPlayerEdit = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                HStack {
                    let image = UIImage(data: player.image ?? Data()) ?? UIImage()
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.black, lineWidth: 2)
                        )
                    VStack(alignment: .leading, spacing: 2) {
                        Text("\(player.firstname)")
                        Text("\(player.lastname)  #\(player.number)")
                        Button {
                            isShowingPlayerEdit = true
                        } label: {
                            RoundedRectangle(cornerRadius: 90)
                                .shadow(radius: 1, x: 1, y: 1)
                                .frame(width: 70, height: 30)
                                .foregroundColor(.white)
                                .overlay(
                                    Text("Edit")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .bold()
                                )
                                .padding(.top, 5)
                        }
                    } .font(.system(size: 30)).bold()
                        .foregroundColor(.black)
                        .frame(width: 200, alignment: .center)
                        .padding(.trailing, 20)
                }.padding()
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.white)
                    .ignoresSafeArea(.all)
                
                HStack(spacing: 20) {
                    VStack(alignment: .center) {
                        Text("PPG")
                            .font(.body)
                        Text("\(player.pointsPerGame, specifier: "%.1f")")
                            .font(.title)
                            .bold()
                    }
                    Rectangle()
                        .frame(width: 3, height: 40)
                        .foregroundColor(.white)
                        .ignoresSafeArea(.all)
                    
                    VStack(alignment: .center) {
                        Text("RPG")
                            .font(.body)
                        Text("\(player.reboundPerGame, specifier: "%.1f")")
                            .font(.title)
                            .bold()
                    }
                    Rectangle()
                        .frame(width: 3, height: 40)
                        .foregroundColor(.white)
                        .ignoresSafeArea(.all)
                    VStack(alignment: .center) {
                        Text("APG")
                            .font(.body)
                        Text("\(player.assistPerGame, specifier: "%.1f")")
                            .font(.title)
                            .bold()
                    }
                    Rectangle()
                        .frame(width: 3, height: 40)
                        .foregroundColor(.white)
                        .ignoresSafeArea(.all)
                    VStack(alignment: .center) {
                        Text("FG%")
                            .font(.body)
                        Text("\(player.pointsPerGame, specifier: "%.1f")")
                            .font(.title)
                            .bold()
                    }
                }
                HStack(spacing: 20) {
                    VStack(alignment: .center) {
                        Text("STL")
                            .font(.body)
                        Text("\(player.stealPerGame, specifier: "%.1f")")
                            .font(.title)
                            .bold()
                    }
                    Rectangle()
                        .frame(width: 3, height: 40)
                        .foregroundColor(.white)
                        .ignoresSafeArea(.all)
                    
                    VStack(alignment: .center) {
                        Text("BLK")
                            .font(.body)
                        Text("\(player.blockPerGame, specifier: "%.1f")")
                            .font(.title)
                            .bold()
                    }
                    Rectangle()
                        .frame(width: 3, height: 40)
                        .foregroundColor(.white)
                        .ignoresSafeArea(.all)
                    VStack(alignment: .center) {
                        Text("TOV")
                            .font(.body)
                        Text("\(player.turnoverPerGame, specifier: "%.1f")")
                            .font(.title)
                            .bold()
                    }
                    Rectangle()
                        .frame(width: 3, height: 40)
                        .foregroundColor(.white)
                        .ignoresSafeArea(.all)
                    VStack(alignment: .center) {
                        Text("3P%")
                            .font(.body)
                        Text("\(player.pointsPerGame, specifier: "%.1f")")
                            .font(.title)
                            .bold()
                    }
                    Rectangle()
                        .frame(width: 3, height: 40)
                        .foregroundColor(.white)
                        .ignoresSafeArea(.all)
                    VStack(alignment: .center) {
                        Text("+/-")
                            .font(.body)
                        Text("\(player.pointsPerGame, specifier: "%.1f")")
                            .font(.title)
                            .bold()
                    }
                }
                Spacer()
                
            }
        }
        .background(LinearGradient(colors: [Color("Color1"), Color(.systemCyan)], startPoint: .bottomLeading, endPoint: .topTrailing))
        .frame(width: 500)
        .sheet(isPresented: $isShowingPlayerEdit) {
            RosterEditView(playerToEdit: player)
        }
    }
    
}

struct RosterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RosterDetailView(player: Player())
    }
}
