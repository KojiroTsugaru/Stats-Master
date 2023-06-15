//
//  AddTeamView.swift
//  Stats Master
//
//  Created by KJ on 6/5/23.
//

import SwiftUI

struct AddTeamView: View {
    // get reference to view context
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // For alert when deleting the player
    @State var showAlert: Bool = false
    
    @State private var teamname: String = ""
    @State private var league: String = ""
    
    // Player Image
    @State private var teamImage = UIImage(named: "logo2")
    // Placeholder for Player image
    @State private var placeholderTeamImage = Image("logo2")
    // Image picker
    @State private var isShowingImagePicker = false
    // alert
    @State private var isShowAlert = false
    
    var body: some View {
        NavigationView {
            HStack{
                Form {
                    Section(header: Text("Team Info").font(.headline)) {
                        TextField("Team Name", text: $teamname)
                        TextField("League", text: $league)
                    }
                }.frame(width: 450, alignment: .leading)
                Spacer()
                VStack {
                    placeholderTeamImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200) // Set your desired circle size
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 2)) // Optional: Add a white stroke to the circle
                        .shadow(radius: 1) // Optional: Add a shadow to the circle
                    Button {
                        isShowingImagePicker = true
                    } label: {
                        RoundedRectangle(cornerRadius: 90)
                            .shadow(radius: 1, x: 1, y: 1)
                            .frame(width: 120, height: 40)
                            .foregroundColor(.white)
                            .overlay(
                                Text("Change")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .bold()
                                    .padding()
                            )
                            .padding(.top, 10)
                    }

                }
                Spacer()
            }
            .background(Color(.systemGray6))
            .scrollContentBackground(.hidden)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: {
                        self.presentationMode.wrappedValue.dismiss()
                    })
                        .padding()
                        .frame(width: 40, height: 200)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save", action: {
                        if isTextEmpty() {
                            showAlert = true
                        }
                        else {
                            // action to update player
                            addTeam(name: self.teamname, league: self.league)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    })
                        .padding()
                        .frame(width: 40, height: 200)
                }
            }
            .navigationTitle("Create New Team")
            .navigationBarTitleDisplayMode(.large)
        }
        .alert(isPresented: $isShowAlert, content: {
            Alert(
                title: Text("Fill out team's info"),
                dismissButton: .default(Text("OK"))
            )
        })
        // Image Picker
        .sheet(isPresented: $isShowingImagePicker, onDismiss: {
            placeholderTeamImage = Image(uiImage:teamImage!)
        }, content: {
            ImagePicker(imageToAdd: $teamImage)
        })
    }
    
    // check textbox
    private func isTextEmpty() -> Bool {
        if self.teamname == "" || self.league == "" {
            return true
        }
        return false
    }
    
    // Function to add team
    private func addTeam(name: String, league: String) {
        
        let newTeam = Team(context: viewContext)
        newTeam.id = UUID()
        newTeam.loss = 0
        newTeam.win = 0
        newTeam.name = name
        newTeam.league = league
        newTeam.image = teamImage?.pngData()

        do {
            try viewContext.save()
        } catch {
            print("crash test")
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}
