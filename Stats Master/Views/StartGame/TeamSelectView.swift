//
//  TeamSelectView.swift
//  Stats Master
//
//  Created by KJ on 5/10/23.
//

import SwiftUI

struct TeamSelectView: View {
    @FetchRequest(sortDescriptors: []) private var teams: FetchedResults<Team>
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
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
                    Text("Select Team")
                        .bold()
                        .offset(x: -15)
                    Spacer()
                }.padding(.vertical, 5)
                    .background(Color(.systemGray6))
                
                List(teams){ t in
                    let players = t.players?.allObjects as! [Player]
                    if players.count >= 5 {
                        NavigationLink {
                            OpponentCreateView(teamSelected: t)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            HStack{
                                // get image for each team
                                let image = UIImage(data: t.image ?? Data()) ?? UIImage()
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                VStack(alignment: .leading){
                                    Text(t.name)
                                    Text(t.league ?? "")
                                        .font(.system(size: 10))
                                }
                            }
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }.toolbar(.hidden, for: .navigationBar)
        .navigationTitle("Select Team")
        .navigationBarBackButtonHidden(true)
    }
}

//struct TeamSelectView_Previews: PreviewProvider {
//    static var previews: some View {
//        TeamSelectView(isBackButtonHidden: Binding.constant(true))
//            .previewInterfaceOrientation(.landscapeRight)
//    }
//}
