//
//  AddPlyaerView.swift
//  Stats Master
//
//  Created by KJ on 5/11/23.
//

import SwiftUI

struct AddPlayerView: View {
    
    let teamToAddPlayerTo: Team
    
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var number = ""
    
    // Player Image
    @State private var playerImage = UIImage(named: "player_icon")
    
    // Placeholder for Player image
    @State private var placeholderPlayerImage = Image("player_icon")
    
    // Image picker
    @State private var isShowingImagePicker = false
    
    // Alert when textboxes are empty
    @State private var isShowAlert = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // get reference to view context
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationView {
            HStack{
                Form {
                    Section(header: Text("Player Info").font(.headline).foregroundColor(.white)) {
                        TextField("First Name", text: $firstname)
                        TextField("Last Name", text: $lastname)
                        TextField("Number #", text: $number)
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
                                Text("Add")
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
                        // action to update player
                        if isTextEmpty() {
                            isShowAlert = true
                        }
                        else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                addPlayer(firstname: self.firstname, lastname: self.lastname, number: self.number)
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                    })
                        .padding()
                        .frame(width: 40, height: 200)
                        .foregroundColor(.white)
                }
            }
            .navigationTitle("Add Player")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
        }
        .alert(isPresented: $isShowAlert, content: {
            Alert(
                title: Text("Fill out player's info"),
                dismissButton: .default(Text("OK"))
            )
        })
        // Image Picker
        .sheet(isPresented: $isShowingImagePicker, onDismiss: {
            placeholderPlayerImage = Image(uiImage: playerImage!)
        }, content: {
            ImagePicker(imageToAdd: $playerImage)
        })
    }
    
    func loadPlayerImage() {
        // Handle the dismissing action.
        if playerImage != nil {
            // set it as placeHolder image
            placeholderPlayerImage = Image(uiImage: playerImage!)
        }
    }
    
    private func isTextEmpty() -> Bool {
        if self.firstname == "" || self.lastname == "" || self.number == "" {
            return true
        }
        return false
    }
    
    // Function to add player to a team
    private func addPlayer(firstname: String, lastname: String, number: String) {
    
        // create new player object
        let newPlayer = Player(context: viewContext)
        
        // from the arguments
        newPlayer.firstname = firstname.trimmingCharacters(in: .whitespacesAndNewlines)
        newPlayer.lastname = lastname.trimmingCharacters(in: .whitespacesAndNewlines)
        newPlayer.number = number.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // initialize the other properties
        newPlayer.id = UUID()
        newPlayer.assist = 0
        newPlayer.block = 0
        newPlayer.def_reb = 0
        newPlayer.foul = 0
        newPlayer.off_reb = 0
        newPlayer.point = 0
        newPlayer.steal = 0
        newPlayer.turnover = 0
        newPlayer.isStarting = false
        newPlayer.fg_attempt = 0
        newPlayer.fg_made = 0
        newPlayer.fg_percent = 0.0
        newPlayer.ft_attempt = 0
        newPlayer.ft_made = 0
        newPlayer.ft_percent = 0.0
        newPlayer.threepoint_made = 0
        newPlayer.threepoint_attempt = 0
        newPlayer.threepoint_percent = 0.0
        
//      Deal with image here as UIImage
        newPlayer.image = playerImage?.pngData()
        
        // Let the team this player belongs to as the team selected
        // in the previous view.
        teamToAddPlayerTo.addToPlayers(newPlayer)

        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

//struct AddPlayerView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPlayerView()
//            .previewInterfaceOrientation(.landscapeRight)
//    }
//}
