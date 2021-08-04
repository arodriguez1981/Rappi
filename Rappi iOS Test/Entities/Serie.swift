//
//  Serie.swift
//  
//
//  Created by Alex Rodriguez on 02/08/21.
//

import Foundation
import Realm
import RealmSwift

class Serie: Object, Codable{
    @Published @objc dynamic var poster_path : String?
    @Published @objc dynamic var popularity  : Double = 0
    @objc dynamic var id : Int = 0
    @Published @objc dynamic var backdrop_path : String?
    @Published @objc dynamic var vote_average : Double = 0
    @Published @objc dynamic var overview : String?
    @Published @objc dynamic var first_air_date : Date?
    @Published @objc dynamic var original_language : String?
    @Published @objc dynamic var vote_count : Int = 0
    @Published @objc dynamic var genre_ids : Array<Int>?
    @Published @objc dynamic var name : String?
    @Published @objc dynamic var original_name : String?
    @Published var origin_country : Array<String>?
    
    init(_ idNew: Int) {
        poster_path = ""
        popularity = 0.0
        id = idNew
        backdrop_path = ""
        vote_average = 0.0
        overview = ""
        first_air_date = Date()
        original_language = ""
        vote_count = 0
        genre_ids = Array<Int>()
        name = ""
        original_name = ""
        origin_country = Array<String>()
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        poster_path = try? container.decode(String.self, forKey: .poster_path)
        overview = try? container.decode(String.self, forKey: .overview)
        origin_country = try? container.decode([String].self, forKey: .origin_country)
        id = try! container.decode(Int.self, forKey: .id)
        original_name = try? container.decode(String.self, forKey: .original_name)
        original_language = try? container.decode(String.self, forKey: .original_language)
        name = try? container.decode(String.self, forKey: .name)
        backdrop_path = try? container.decode(String.self, forKey: .backdrop_path)
        first_air_date = try? container.decode(Date.self, forKey: .first_air_date)
        popularity = try! container.decode(Double.self, forKey: .popularity)
        vote_count = try! container.decode(Int.self, forKey: .vote_count)
        vote_average = try! container.decode(Double.self, forKey: .vote_average)
        genre_ids = try? container.decode([Int].self, forKey: .genre_ids)
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


extension Serie{
    enum CodingKeys: String, CodingKey {
        case poster_path
        case overview
        case origin_country
        case id
        case original_name
        case original_language
        case name
        case backdrop_path
        case popularity
        case vote_count
        case vote_average
        case genre_ids
        case first_air_date
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(poster_path, forKey: .poster_path)
        try? container.encode(overview, forKey: .overview)
        try? container.encode(origin_country, forKey: .origin_country)
        try? container.encode(id, forKey: .id)
        try? container.encode(original_name, forKey: .original_name)
        try? container.encode(original_language, forKey: .original_language)
        try? container.encode(name, forKey: .name)
        try? container.encode(backdrop_path, forKey: .backdrop_path)
        try? container.encode(popularity, forKey: .popularity)
        try? container.encode(vote_count, forKey: .vote_count)
        try? container.encode(vote_average, forKey: .vote_average)
        try? container.encode(genre_ids, forKey: .genre_ids)
        try? container.encode(first_air_date, forKey: .first_air_date)
    }
}

