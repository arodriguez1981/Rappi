//
//  Season.swift
//  
//
//  Created by Alex Rodriguez on 02/08/21.
//

import Foundation
import Realm
import RealmSwift

class Season: Object, Codable {
    @objc dynamic var id  : Int = 0
    @Published @objc dynamic var name : String?
    @Published @objc dynamic var poster_path : String?
    @Published @objc dynamic var overview : String?
    @Published @objc dynamic var episode_count  : Int = 0
    @Published @objc dynamic var season_number  : Int = 0
    @Published @objc dynamic var air_date : Date?

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        poster_path = try? container.decode(String.self, forKey: .poster_path)
        overview = try? container.decode(String.self, forKey: .overview)
        air_date = try? container.decode(Date.self, forKey: .air_date)
        episode_count = try! container.decode(Int.self, forKey: .episode_count)
        season_number = try! container.decode(Int.self, forKey: .season_number)
        id = try! container.decode(Int.self, forKey: .id)
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

extension Season{
    enum CodingKeys: String, CodingKey {
        case poster_path
        case air_date
        case episode_count
        case season_number
        case overview
        case id
        case name
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(poster_path, forKey: .poster_path)
        try? container.encode(air_date, forKey: .air_date)
        try? container.encode(overview, forKey: .overview)
        try? container.encode(episode_count, forKey: .episode_count)
        try? container.encode(season_number, forKey: .season_number)
        try? container.encode(id, forKey: .id)
        try? container.encode(name, forKey: .name)
    }
}
