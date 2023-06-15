//
//  RosterEditView.swift
//  Stats Master
//
//  Created by KJ on 6/2/23.
//

import SwiftUI

struct RosterEditView: View {
    
    let playerToEdit: Player
    
    // get reference to view context
    @Environment(\.managedObjectContext) private var viewContext
    
    // For alert when deleting the player
    @State private var showAlert: Bool = false
    
    // Alert when textbox is empty
    @State var showEmptyAlert: Bool = false
    
    @State private var firstname: String
    @State private var lastname: String
    @State private var number: String
    // Player Image
    @State private var playerImage: UIImage?
    @State private var placeholderPlayerImage: Image
    
    // initialize all the State properties
    init(playerToEdit: Player) {
        self.playerToEdit = playerToEdit
        _firstname = State(initialValue: playerToEdit.firstname)
        _lastname = State(initialValue: playerToEdit.lastname)
        _number = State(initialValue: playerToEdit.number)
        _playerImage = State(initialValue: UIImage(data: playerToEdit.image ?? Data()) ?? UIImage())
        let image = UIImage(data: playerToEdit.image ?? Data()) ?? UIImage()
        _placeholderPlayerImage = State(initialValue: Image(uiImage: image))
    }
    
    
    // Image picker
    @State private var isShowingImagePicker = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            HStack{
                Form {
                    Section(header: Text("Player Info").font(.headline).foregroundColor(.white)) {
                        TextField("First Name", text: $firstname)
                        TextField("Last Name", text: $lastname)
                        TextField("Number #", text: $number)
                    }
                    
                    Section {
                        Button {
                            self.showAlert = true
                        } label: {
                            Text("Delete Player")
                                .foregroundColor(Color(.systemRed))
                                .frame(alignment: .center)
                        }
                    }
                }.frame(width: 450, alignment: .leading)
                Spacer()
                VStack {
                    placeholderPlayerImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200) // Set your desired circle size
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2)) // Optional: Add a white stroke to the circle
                        .shadow(radius: 4) // Optional: Add a shadow to the circle
                    Button {
                        isShowingImagePicker = true
                    } label: {
                        RoundedRectangle(cornerRadius: 90)
                            .shadow(radius: 1, x: 1, y: 1)
                            .frame(width: 100, height: 40)
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
            .background(LinearGradient(colors: [Color("Color1"), Color(.systemCyan)], startPoint: .bottomLeading, endPoint: .topTrailing))
            .scrollContentBackground(.hidden)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: {
                        self.presentationMode.wrappedValue.dismiss()
                    })
                        .padding()
                        .frame(width: 40, height: 200)
                        .foregroundColor(.white)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save", action: {
                        if isTextEmpty() {
                            showEmptyAlert = true
                        }
                        else {
                            // action to update player
                            updatePlayer(playerToUpdate: playerToEdit)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    })
                        .padding()
                        .frame(width: 40, height: 200)
                        .foregroundColor(.white)
                }
            }
            .navigationTitle("Edit Player")
            .navigationBarTitleDisplayMode(.large)
        }
        // Image Picker
        .sheet(isPresented: $isShowingImagePicker, onDismiss: {
            placeholderPlayerImage = Image(uiImage: playerImage!)
        }, content: {
            ImagePicker(imageToAdd: $playerImage)
        })
        // Alert
        .alert(isPresented: self.$showAlert) {
            Alert(
                title: Text("Delete Player"),
                message: Text("Are you sure you delete this player?"),
                primaryButton: .default(Text("Cancel")),
                secondaryButton: .destructive(
                    Text("Delete"),
                    action: {      
                        removePlayerFromTeam(playerToRemove: playerToEdit)
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            )
        }
        .alert(isPresented: $showEmptyAlert) {
            Alert(
                title: Text("Fill out player's info"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    // Check textbox
    private func isTextEmpty() -> Bool {
        if self.firstname == "" || self.lastname == "" || self.number == "" {
            return true
        }
        return false
    }
    
    // Function to delete team
    private func removePlayerFromTeam(playerToRemove: Player) {
        
        let team = playerToRemove.team
        team?.removeFromPlayers(playerToRemove)
        
        // Save the changes to Core Data
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // Function to update player info
    private func updatePlayer(playerToUpdate: Player) {
        playerToUpdate.firstname = self.firstname
        playerToUpdate.lastname = self.lastname
        playerToUpdate.number = self.number
        playerToUpdate.image = self.playerImage?.pngData()
        
        // Save the changes to Core Data
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}

//struct RosterEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        RosterEditView(playerToEdit: Player())
//            .previewInterfaceOrientation(.landscapeRight)
//    }
//}
