//
//  Stats_MasterApp.swift
//  Stats Master
//
//  Created by KJ on 5/10/23.
//

import SwiftUI

@main
struct Stats_MasterApp: App {
    let persistenceController = PersistenceController.shared
    
    // when the first use of the app, preload data
    @AppStorage("isFirstLaunch") var isFirstLaunch = true
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    if isFirstLaunch {
                        // Preload data into CoreData
                        preloadData()
                        
                        // Set isFirstLaunch to false
                        isFirstLaunch = false
                    }
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
    func preloadData() {
        
        // Perform your data preloading logic here
        // This could involve creating CoreData objects and saving them
        // to the persistent store.
        let team = Team(context: persistenceController.container.viewContext)
        
        team.id = UUID()
        team.loss = 0
        team.win = 0
        team.name = "Default Team"
        team.league = "NBA"
        team.gamePlayed = 0
        let img = UIImage(named: "logo2")
        if let imageData = img?.pngData() {
            team.image = imageData
        }
        
        team.addToPlayers(createPlayer(firstname: "Kevin", lastname: "Durant", number: "1"))
        team.addToPlayers(createPlayer(firstname: "Kevin", lastname: "Durant", number: "2"))
        team.addToPlayers(createPlayer(firstname: "Kevin", lastname: "Durant", number: "3"))
        team.addToPlayers(createPlayer(firstname: "Kevin", lastname: "Durant", number: "4"))
        team.addToPlayers(createPlayer(firstname: "Kevin", lastname: "Durant", number: "5"))
        team.addToPlayers(createPlayer(firstname: "Kevin", lastname: "Durant", number: "6"))
        team.addToPlayers(createPlayer(firstname: "Kevin", lastname: "Durant", number: "7"))
        team.addToPlayers(createPlayer(firstname: "Kevin", lastname: "Durant", number: "8"))
        team.addToPlayers(createPlayer(firstname: "Kevin", lastname: "Durant", number: "9"))
        team.addToPlayers(createPlayer(firstname: "Kevin", lastname: "Durant", number: "10"))
        
        do {
            try persistenceController.container.viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            
            print("Error saving context: \(error)")
            
        }
    }
    
    // Function to add player to a team
    private func createPlayer(firstname: String, lastname: String, number: String) -> Player {
    
        // create new player object
        let newPlayer = Player(context: persistenceController.container.viewContext)
        
        // from the arguments
        newPlayer.firstname = firstname
        newPlayer.lastname = lastname
        newPlayer.number = number
        
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
        
        let img = UIImage(named: "kevin_durant")
        if let imageData = img?.pngData() {
            newPlayer.image = imageData
        }

        do {
            try persistenceController.container.viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            
            print("Error saving context: \(error)")
        }
        
        return newPlayer
    }
    
}
