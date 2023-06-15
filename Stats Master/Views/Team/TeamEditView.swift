//
//  TeamEditView.swift
//  Stats Master
//
//  Created by KJ on 6/7/23.
//

import SwiftUI

struct TeamEditView: View {
    
    let teamToEdit: Team
    
    // get reference to view context
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // For alert when deleting the player
    @State private var showAlert: Bool = false
    
    // Alert when textbox is empty
    @State var showEmptyAlert: Bool = false
    
    @State private var teamname: String
    @State private var league: String
    // Player Image
    @State private var teamImage: UIImage?
    @State private var placeholderTeamImage: Image
    
    // initialize all the State properties
    init(teamToEdit: Team) {
        self.teamToEdit = teamToEdit
        _teamname = State(initialValue: teamToEdit.name)
        _league = State(initialValue: teamToEdit.league ?? "")
        _teamImage = State(initialValue: UIImage(data: teamToEdit.image ?? Data()) ?? UIImage())
        let image = UIImage(data: teamToEdit.image ?? Data()) ?? UIImage()
        _placeholderTeamImage = State(initialValue: Image(uiImage: image))
    }
    
    // Image picker
    @State private var isShowingImagePicker = false
    
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
                            // action to update team
                            updateTeam()
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    })
                        .padding()
                        .frame(width: 40, height: 200)
                }
            }
            .navigationTitle("Edit Team")
            .navigationBarTitleDisplayMode(.large)
        }.navigationBarBackButtonHidden(true)
        .alert(isPresented: $showAlert, content: {
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
    
    private func updateTeam() {
        teamToEdit.name = self.teamname
        teamToEdit.league = self.league
        teamToEdit.image = self.teamImage?.pngData()
        
        // Save the changes to Core Data
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

struct TeamEditView_Previews: PreviewProvider {
    static var previews: some View {
        TeamEditView(teamToEdit: Team())
    }
}
