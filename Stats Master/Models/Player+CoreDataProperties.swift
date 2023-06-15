//
//  Player+CoreDataProperties.swift
//  Stats Master
//
//  Created by KJ on 6/3/23.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var assist: Int
    @NSManaged public var block: Int
    @NSManaged public var def_reb: Int
    @NSManaged public var fg_attempt: Int
    @NSManaged public var fg_made: Int
    @NSManaged public var fg_percent: Float
    @NSManaged public var firstname: String
    @NSManaged public var foul: Int
    @NSManaged public var ft_attempt: Int
    @NSManaged public var ft_made: Int
    @NSManaged public var ft_percent: Float
    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var isStarting: Bool
    @NSManaged public var lastname: String
    @NSManaged public var number: String
    @NSManaged public var off_reb: Int
    @NSManaged public var on_court: Bool
    @NSManaged public var point: Int
    @NSManaged public var steal: Int
    @NSManaged public var threepoint_attempt: Int64
    @NSManaged public var threepoint_made: Int64
    @NSManaged public var threepoint_percent: Float
    @NSManaged public var turnover: Int64
    @NSManaged public var gamePlayed: Int64
    @NSManaged public var team: Team?
    
    var pointsPerGame: Float {
        if gamePlayed != 0 { return Float(point) / Float(gamePlayed) } else { return 0.0 }
    }
    var assistPerGame: Float {
        if gamePlayed != 0 { return Float(assist) / Float(gamePlayed) } else { return 0.0 }
    }
    var reboundPerGame: Float {
        if gamePlayed != 0 { return Float(off_reb + def_reb) / Float(gamePlayed) } else { return 0.0 }
    }
    var blockPerGame: Float {
        if gamePlayed != 0 { return Float(block) / Float(gamePlayed) } else { return 0.0 }
    }
    var stealPerGame: Float {
        if gamePlayed != 0 { return Float(steal) / Float(gamePlayed) } else { return 0.0 }
    }
    var turnoverPerGame: Float {
        if gamePlayed != 0 { return Float(turnover) / Float(gamePlayed) } else { return 0.0 }
    }

}

extension Player : Identifiable {

}
