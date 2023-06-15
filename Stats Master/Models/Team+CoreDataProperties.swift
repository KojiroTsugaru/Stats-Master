//
//  Team+CoreDataProperties.swift
//  Stats Master
//
//  Created by KJ on 6/3/23.
//
//

import Foundation
import CoreData


extension Team {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Team> {
        return NSFetchRequest<Team>(entityName: "Team")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var league: String?
    @NSManaged public var loss: Int64
    @NSManaged public var name: String
    @NSManaged public var win: Int64
    @NSManaged public var gamePlayed: Int64
    @NSManaged public var games: NSSet?
    @NSManaged public var players: NSSet?

}

// MARK: Generated accessors for games
extension Team {

    @objc(addGamesObject:)
    @NSManaged public func addToGames(_ value: Game)

    @objc(removeGamesObject:)
    @NSManaged public func removeFromGames(_ value: Game)

    @objc(addGames:)
    @NSManaged public func addToGames(_ values: NSSet)

    @objc(removeGames:)
    @NSManaged public func removeFromGames(_ values: NSSet)

}

// MARK: Generated accessors for players
extension Team {

    @objc(addPlayersObject:)
    @NSManaged public func addToPlayers(_ value: Player)

    @objc(removePlayersObject:)
    @NSManaged public func removeFromPlayers(_ value: Player)

    @objc(addPlayers:)
    @NSManaged public func addToPlayers(_ values: NSSet)

    @objc(removePlayers:)
    @NSManaged public func removeFromPlayers(_ values: NSSet)

}

extension Team : Identifiable {

}
