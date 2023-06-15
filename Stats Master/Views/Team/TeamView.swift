//
//  TeamView.swift
//  Stats Master
//
//  Created by KJ on 5/10/23.
//

import SwiftUI

struct TeamItem: View {
    // team model
    let team: Team

    var body: some View {
        HStack(alignment: .top) {
            VStack{
                HStack {
                    let image = UIImage(data: team.image ?? Data()) ?? UIImage()
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .padding(.leading, 10)
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("\(team.name)")
                            .font(.system(size: 35)).bold()
                            .foregroundColor(.black)
                            .frame(width: 200, alignment: .center)
                            .padding(.trailing, 20)
                        Text("\(team.win) - \(team.loss)")
                            .foregroundColor(.white)
                            .font(.italic(.title3)())
                            .bold()
                            .frame(width: 200, alignment: .center)
                    }
                }
                HStack {
                    NavigationLink(destination: RosterView(team: team)) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 30)
                                .frame(width: 100, height: 40)
                                .foregroundColor(.white)
                                .overlay {
                                    Text("Roster")
                                        .foregroundColor(.black)
                                        .padding()
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                        }
                        .padding(.horizontal)
                    }
                    NavigationLink(destination: GamePlayedView(team: team)) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 30)
                                .frame(width: 100, height: 40)
                                .foregroundColor(.white)
                                .overlay {
                                    Text("Games")
                                        .foregroundColor(.black)
                                        .padding()
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                        }
                    }
                    NavigationLink(destination: TeamEditView(teamToEdit: team)) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 30)
                                .frame(width: 100, height: 40)
                                .foregroundColor(.white)
                                .overlay {
                                    Text("Edit")
                                        .foregroundColor(.black)
                                        .padding()
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                        }
                        .padding(.horizontal)
                    }
                }
                .offset(y: 15)
            }
        }
        .padding(.horizontal, 20)
        .frame(width: 450, height: 300)
        .background(LinearGradient(colors: [Color("Color1"), Color(.systemCyan)], startPoint: .bottomLeading, endPoint: .topTrailing))
        .cornerRadius (25)
        .shadow (color: Color.gray.opacity(0.8), radius: 2, x: -2, y: 8)
    }
}

struct TeamView: View {
    
    // get reference to view context
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // get teams data from core data
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) private var teams: FetchedResults<Team>
    
    // for creating new team
    @State private var isShowingAddTeam = false
    @State private var teamname: String = ""
    
    // Team Image for adding team
    @State private var teamImage = UIImage(named: "picture_empty")
    
    // place holder image=
    @State private var placeHolderImage = Image("picture_empty")
    
    // Image Picker
    @State private var isShowingImagePicker = false

    var body: some View {
        NavigationView {
            VStack {
                // Custom NavigationBar
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .bold()
                            Text("Home")
                        }
                    }
                    Spacer()
                    Text("Teams")
                        .bold()
                        .offset(x: -10)
                    Spacer()
                    // Button to add team
                    Button {
                        isShowingAddTeam.toggle()
                    } label: {
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                            Image(systemName: "plus")
                                .foregroundColor(.black)
                                .font(.system(size: 25).bold())
                                .padding(5)
                        }
                    }
                }.padding(.vertical, 5)
                    .background(Color(.white))
                
                // Team Items
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack{
                        ForEach(teams){ t in
                            TeamItem(team: t)
                                .padding()
                        }
                    }
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        // Sheet for ImagePicker
        .sheet(isPresented: $isShowingImagePicker ,content: {
            ImagePicker(imageToAdd: $teamImage)
        })
        
        // sheet to add new teams
        .sheet(isPresented: $isShowingAddTeam){
            AddTeamView()
        }
    }
}


struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
