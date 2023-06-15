//
//  GameSummaryView.swift
//  Stats Master
//
//  Created by KJ on 6/6/23.
//

import SwiftUI

struct HalfRect: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // right side
        path.move(to: CGPoint(x: rect.maxX/2+90, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX/2-90, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        
        // left side
        path.move(to: CGPoint(x: rect.maxX/2+75, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX/2-105, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.minY))
        return path
    }
}

struct GameSummaryView: View {
    
    let game: Game
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ZStack{
                    HStack() {
                        Spacer()
                        let myteam_image = UIImage(data: game.team?.image ?? Data()) ?? UIImage()
                        Image(uiImage: myteam_image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                        Text("111")
                            .font(.title)
                        
                        Image(systemName: "arrowtriangle.left.fill")
                        Text("FINAL")
                            .bold()
                        Text("108")
                            .font(.title)
                        if let opp_image = UIImage(data: game.opp_logo ?? Data()) {
                            Image(uiImage: opp_image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                                .padding(.horizontal)
                        }
                        else {
                            Text("\(game.opp_name)")
                                .font(.title)
                        }
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Button("Done", action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }).padding(.horizontal)
                            .offset(x: -20)
                    }
                }.foregroundColor(.white)
                    .padding(.vertical, 5)
                    .background(Color("Color1"))
                    .ignoresSafeArea(.all)
                
                ScrollView(.vertical) {
                    VStack(spacing: 0) {
                        ZStack {
                            HalfRect()
                                .foregroundColor(Color("Color1").opacity(0.5))
                            
                            HStack {
                                Group {
                                    let myteam_image = UIImage(data: game.team?.image ?? Data()) ?? UIImage()
                                    Image(uiImage: myteam_image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 120, height: 120)
                                        .clipShape(Circle())
                                        .padding(.horizontal)
                                    Text("\(game.myteam_name)")
                                        .font(.headline).bold()
                                        .padding(.horizontal)
                                }.offset(x: 30)
                                Spacer()
                                Group {
                                    Text("\(game.opp_name)")
                                        .font(.headline).bold()
                                        .padding(.horizontal)
                                    let opp_image = UIImage(data: game.opp_logo ?? Data()) ?? UIImage()
                                    Image(uiImage: opp_image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 120, height: 120)
                                        .clipShape(Circle())
                                        .padding(.horizontal)
                                }.offset(x: -30)
                            }
                        }
                        .frame(height: 150)
                        
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color("Color1")).opacity(0.2)
                        
                        ScrollView(.horizontal){
                            LazyVStack(alignment: .leading) {
                                // Hstack for Stats name on the top
                                HStack(spacing: 14.5) {
                                   Spacer().frame(width: 215)
                                    Group {
                                        Text("PTS")
                                        Text("AST")
                                        Text("REB")
                                        Text("STL")
                                        Text("BLK")
                                        Text("FGM")
                                        Text("FGA")
                                    }.frame(width: 30, alignment: .trailing)
                                    Text("FG%")
                                        .frame(width: 60, alignment: .trailing)
                                    Group {
                                        Text("3PM")
                                        Text("3PA")
                                   }.frame(width: 30, alignment: .trailing)
                                    Text("3P%")
                                        .frame(width: 60, alignment: .trailing)
                                    Group {
                                        Text("FTM")
                                        Text("FTA")
                                    }.frame(width: 30, alignment: .trailing)
                                    Text("FT%")
                                        .frame(width: 60, alignment: .trailing)
                                    Group {
                                       Text("TOV")
                                       Text("PF")
                                   }.frame(width: 30, alignment: .trailing)
                                   }.foregroundColor(.white)
                                    .font(.caption)
                                       .padding(.top, 5)
                                   ForEach(game.my_players?.allObjects as! [Player]) { p in
                                       // Hstack for all the Player's stats
                                       HStack(spacing: 15) {
                                           Spacer().frame(width: 30)
                                           let image = UIImage(data: p.image ?? Data()) ?? UIImage()
                                           Image(uiImage: image)
                                               .resizable()
                                               .scaledToFill()
                                               .frame(width: 30, height: 30) // Set your desired circle size
                                               .clipShape(Circle())
                                               .overlay(Circle().stroke(Color.white, lineWidth: 1)) // Optional: Add a white stroke to the circle
                                           Text("\(p.firstname) \(p.lastname)")
                                               .frame(width: 120 , alignment: .leading)
                                           Group {
                                               Text("\(p.point)")
                                               Text("\(p.assist)")
                                               Text("\(p.off_reb + p.def_reb)")
                                               Text("\(p.steal)")
                                               Text("\(p.block)")
                                               Text("\(p.fg_made)")
                                               Text("\(p.fg_attempt)")
                                           }.frame(width: 30, alignment: .trailing)
                                           Text("\(p.fg_percent, specifier: "%.1f")%")
                                               .frame(width: 60, alignment: .trailing)
                                           Group {
                                               Text("\(p.threepoint_made)")
                                               Text("\(p.threepoint_attempt)")
                                           }.frame(width: 30, alignment: .trailing)
                                           Text("\(p.threepoint_percent, specifier: "%.1f")%")
                                               .frame(width: 60, alignment: .trailing)
                                           Group {
                                               Text("\(p.ft_made)")
                                               Text("\(p.ft_attempt)")
                                           }.frame(width: 30, alignment: .trailing)
                                           
                                           Text("\(p.ft_percent, specifier: "%.1f")%")
                                                .frame(width: 60, alignment: .trailing)
                                           Group {
                                               Text("\(p.turnover)")
                                               Text("\(p.foul)")
                                           }.frame(width: 30, alignment: .trailing)
                                       }.foregroundColor(.white)
                                           .font(.body)
                                       
                                       Rectangle()
                                           .frame(height: 0.5)
                                           .foregroundColor(.white)
                                   }
                                }
                            }.background(LinearGradient(colors: [Color("Color1"), Color(.systemCyan)], startPoint: .bottomLeading, endPoint: .topTrailing))
                        }
                    }
                }.ignoresSafeArea(.all)
            }
        }
    }

struct GameSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        GameSummaryView(game: Game())
            .previewInterfaceOrientation(.landscapeRight)
    }
}
