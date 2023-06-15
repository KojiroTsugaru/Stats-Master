//
//  HomeView.swift
//  Stats Master
//
//  Created by KJ on 5/10/23.
//

import SwiftUI


struct HomeView: View {
    
    @State private var teamname: String = ""
    
    var body: some View {
        NavigationView {
            HStack(spacing: 80){
                VStack{
                    Image(systemName: "basketball.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                        .padding()
                        .foregroundColor(Color("Color1"))
                    Text("Stats Master")
                        .font(.title3)
                }
                VStack{
                    NavigationLink() {
                        TeamSelectView()
                    } label: {
                        Text("New Game")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .frame(width: 180, height: 60)
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 85)
                                    .stroke(Color("Color1"), lineWidth: 3)
                                    .shadow(radius: 1, x: 2, y: 2)
                            )
                            .padding()
                    }
                    NavigationLink {
                        TeamView()
                    } label: {
                        Text("Teams")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .frame(width: 180, height: 60)
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 85)
                                    .stroke(Color("Color1"), lineWidth: 3)
                                    .shadow(radius: 1, x: 2, y: 2)
                            )
                            .padding()
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
