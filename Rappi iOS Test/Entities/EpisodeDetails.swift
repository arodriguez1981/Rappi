//
//  EpisodeDetails.swift
//  
//
//  Created by Alex Rodriguez on 02/08/21.
//

import Foundation
import Realm
import RealmSwift

class EpisodeDetails: Object, Codable {
    @Published @objc dynamic var backdrop_path : String?
    @Published @objc dynamic var popularity : Double = 0
    @Published @objc dynamic var vote_count : Int = 0
    @Published @objc dynamic var poster_path : String?
    @Published dynamic var in_production : Bool?
    @objc dynamic var id : Int = 0
    @Published @objc dynamic var overview : String?
    @Published @objc dynamic var original_language : String?
    @Published @objc dynamic var vote_average : Double = 0
    @Published @objc dynamic var number_of_episodes : Int = 0
    @Published @objc dynamic var number_of_seasons : Int = 0
    @Published @objc dynamic var first_air_date : Date?
    @Published @objc dynamic var homepage : String?
    @Published @objc dynamic var last_air_date : Date?
    @Published @objc dynamic var name : String?
    @Published @objc dynamic var status : String?
    @Published @objc dynamic var type : String?
    @Published @objc dynamic var original_name : String?
    @Published var last_episode_to_air : EpisodeAir?
    @Published var production_companies : Array<ProductionCompany>?
    @Published var seasons : Array<Season>?
    @Published var genres : Array<Genre>?
    @Published var created_by : Array<CreatedBy>?
    @Published var episode_run_time : Array<Int>?
    @Published var origin_country : Array<String>?
    @Published var networks : Array<Network>?
    @Published var languages : Array<String>?
    
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        in_production = try? container.decode(Bool.self, forKey: .in_production)
        homepage = try? container.decode(String.self, forKey: .homepage)
        type = try? container.decode(String.self, forKey: .type)
        status = try? container.decode(String.self, forKey: .status)
        poster_path = try? container.decode(String.self, forKey: .poster_path)
        overview = try? container.decode(String.self, forKey: .overview)
        id = try! container.decode(Int.self, forKey: .id)
        number_of_episodes = try! container.decode(Int.self, forKey: .number_of_episodes)
        number_of_seasons = try! container.decode(Int.self, forKey: .number_of_seasons)
        original_name = try? container.decode(String.self, forKey: .original_name)
        original_language = try? container.decode(String.self, forKey: .original_language)
        first_air_date = try? container.decode(Date.self, forKey: .first_air_date)
        last_air_date = try? container.decode(Date.self, forKey: .last_air_date)
        backdrop_path = try? container.decode(String.self, forKey: .backdrop_path)
        popularity = try! container.decode(Double.self, forKey: .popularity)
        vote_count = try! container.decode(Int.self, forKey: .vote_count)
        vote_average = try! container.decode(Double.self, forKey: .vote_average)
        name = try? container.decode(String.self, forKey: .name)
        last_episode_to_air = try? container.decode(EpisodeAir.self, forKey: .last_episode_to_air)
        production_companies = try? container.decode([ProductionCompany].self, forKey: .production_companies)
        seasons = try? container.decode([Season].self, forKey: .seasons)
        genres = try? container.decode([Genre].self, forKey: .genres)
        created_by = try? container.decode([CreatedBy].self, forKey: .created_by)
        episode_run_time = try? container.decode([Int].self, forKey: .episode_run_time)
        origin_country = try? container.decode([String].self, forKey: .origin_country)
        networks = try? container.decode([Network].self, forKey: .networks)
        languages = try? container.decode([String].self, forKey: .languages)
        
        
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

extension EpisodeDetails{
    enum CodingKeys: String, CodingKey {
        case in_production
        case homepage
        case type
        case status
        case poster_path
        case overview
        case id
        case number_of_episodes
        case number_of_seasons
        case original_name
        case original_language
        case backdrop_path
        case popularity
        case vote_count
        case vote_average
        case first_air_date
        case last_air_date
        case name
        case last_episode_to_air
        case production_companies
        case seasons
        case genres
        case created_by
        case episode_run_time
        case origin_country
        case networks
        case languages
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(name, forKey: .name)
       
        try? container.encode(in_production, forKey: .in_production)
        try? container.encode(homepage, forKey: .homepage)
        try? container.encode(type, forKey: .type)
        try? container.encode(status, forKey: .status)
        try? container.encode(poster_path, forKey: .poster_path)
        try? container.encode(overview, forKey: .overview)
        try? container.encode(id, forKey: .id)
        try? container.encode(number_of_episodes, forKey: .number_of_episodes)
        try? container.encode(number_of_seasons, forKey: .number_of_seasons)
        try? container.encode(first_air_date, forKey: .first_air_date)
        try? container.encode(last_air_date, forKey: .last_air_date)
        try? container.encode(original_name, forKey: .original_name)
        try? container.encode(original_language, forKey: .original_language)
        try? container.encode(backdrop_path, forKey: .backdrop_path)
        try? container.encode(popularity, forKey: .popularity)
        try? container.encode(vote_count, forKey: .vote_count)
        try? container.encode(vote_average, forKey: .vote_average)
        try? container.encode(last_episode_to_air, forKey: .last_episode_to_air)
        try? container.encode(production_companies, forKey: .production_companies)
        try? container.encode(seasons, forKey: .seasons)
        try? container.encode(genres, forKey: .genres)
        try? container.encode(created_by, forKey: .created_by)
        try? container.encode(episode_run_time, forKey: .episode_run_time)
        try? container.encode(origin_country, forKey: .origin_country)
        try? container.encode(networks, forKey: .networks)
        try? container.encode(languages, forKey: .languages)
    }
}
