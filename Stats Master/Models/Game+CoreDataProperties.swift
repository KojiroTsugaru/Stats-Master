//
//  Game+CoreDataProperties.swift
//  Stats Master
//
//  Created by KJ on 6/3/23.
//
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var myteam_score: Int64
    @NSManaged public var name: String?
    @NSManaged public var opp_logo: Data?
    @NSManaged public var opp_name: String
    @NSManaged public var opp_score: Int64
    @NSManaged public var myteam_name: String
    @NSManaged public var my_players: NSSet?
    @NSManaged public var opp_players: NSSet?
    @NSManaged public var team: Team?

}

// MARK: Generated accessors for my_players
extension Game {

    @objc(addMy_playersObject:)
    @NSManaged public func addToMy_players(_ value: Player)

    @objc(removeMy_playersObject:)
    @NSManaged public func removeFromMy_players(_ value: Player)

    @objc(addMy_players:)
    @NSManaged public func addToMy_players(_ values: NSSet)

    @objc(removeMy_players:)
    @NSManaged public func removeFromMy_players(_ values: NSSet)

}

// MARK: Generated accessors for opp_players
extension Game {

    @objc(addOpp_playersObject:)
    @NSManaged public func addToOpp_players(_ value: Player)

    @objc(removeOpp_playersObject:)
    @NSManaged public func removeFromOpp_players(_ value: Player)

    @objc(addOpp_players:)
    @NSManaged public func addToOpp_players(_ values: NSSet)

    @objc(removeOpp_players:)
    @NSManaged public func removeFromOpp_players(_ values: NSSet)

}

extension Game : Identifiable {

}
