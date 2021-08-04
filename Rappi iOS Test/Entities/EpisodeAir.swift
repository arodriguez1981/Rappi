//
//  EpisodeAir.swift
//  
//
//  Created by Alex Rodriguez on 02/08/21.
//

import Foundation
import Realm
import RealmSwift

class EpisodeAir: Object, Codable {
    @objc dynamic var id : Int = 0
    
    @Published @objc dynamic var vote_average  : Double = 0
    @Published @objc dynamic var vote_count  : Int = 0
    @Published @objc dynamic var name : String?
    @Published @objc dynamic var overview : String?
    @Published @objc dynamic var air_date : Date?
    @Published @objc dynamic var episode_number  : Int = 0
    @Published @objc dynamic var season_number  : Int = 0
    @Published @objc dynamic var production_code : String?
    @Published @objc dynamic var still_path : String?
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        air_date = try? container.decode(Date.self, forKey: .air_date)
        still_path = try? container.decode(String.self, forKey: .still_path)
        overview = try? container.decode(String.self, forKey: .overview)
        id = try! container.decode(Int.self, forKey: .id)
        episode_number = try! container.decode(Int.self, forKey: .episode_number)
        season_number = try! container.decode(Int.self, forKey: .season_number)
        production_code = try! container.decode(String.self, forKey: .production_code)
        vote_count = try! container.decode(Int.self, forKey: .vote_count)
        vote_average = try! container.decode(Double.self, forKey: .vote_average)
        name = try? container.decode(String.self, forKey: .name)
    }
    
    override static func primaryKey() -> String?
    {
        return "id"
    }
    
    required override init()
    {
        super.init()
    }
}

extension EpisodeAir{
    enum CodingKeys: String, CodingKey {
        case air_date
        case still_path
        case overview
        case id
        case episode_number
        case season_number
        case production_code
        case vote_count
        case vote_average
        case name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(name, forKey: .name)
        try? container.encode(air_date, forKey: .air_date)
        try? container.encode(still_path, forKey: .still_path)
        try? container.encode(overview, forKey: .overview)
        try? container.encode(id, forKey: .id)
        try? container.encode(episode_number, forKey: .episode_number)
        try? container.encode(season_number, forKey: .season_number)
        try? container.encode(production_code, forKey: .production_code)
        try? container.encode(vote_count, forKey: .vote_count)
        try? container.encode(vote_average, forKey: .vote_average)
    }
}
