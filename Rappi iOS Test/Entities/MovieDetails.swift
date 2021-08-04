//
//  MovieDetails.swift
//
//
//  Created by Alex Rodriguez on 02/08/21.
//

import Foundation
import Realm
import RealmSwift

class MovieDetails: Object, Codable  {
    
    @Published @objc dynamic var homepage : String?
    @Published @objc dynamic var status : String?
    @Published @objc dynamic var backdrop_path : String?
    @Published @objc dynamic var popularity  : Double = 0
    @Published @objc dynamic var vote_count  : Int = 0
    @Published @objc dynamic var poster_path : String?
    @Published @objc dynamic var overview : String?
    @Published @objc dynamic var release_date : Date?
    @objc dynamic var id  : Int = 0
    @Published @objc dynamic var original_language : String?
    @Published @objc dynamic var vote_average  : Double = 0
    @Published @objc dynamic var adult  : Bool = false
    @Published @objc dynamic var budget  : Int = 0
    @Published @objc dynamic var imdb_id : String?
    @Published @objc dynamic var original_title : String?
    @Published @objc dynamic var revenue  : Int = 0
    @Published @objc dynamic var runtime  : Int = 0
    @Published @objc dynamic var tagline : String?
    @Published @objc dynamic var title : String?
    @Published @objc dynamic var video  : Bool = false
    @Published var spoken_languages : Array<Languages>?
    @Published var production_countries : Array<ProductionCountries>?
    @Published var production_companies : Array<ProductionCompany>?
    @Published var genres : Array<Genre>?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        homepage = try? container.decode(String.self, forKey: .homepage)
        status = try? container.decode(String.self, forKey: .status)
        poster_path = try? container.decode(String.self, forKey: .poster_path)
        adult = try! container.decode(Bool.self, forKey: .adult)
        overview = try? container.decode(String.self, forKey: .overview)
        release_date = try? container.decode(Date.self, forKey: .release_date)
        id = try! container.decode(Int.self, forKey: .id)
        budget = try! container.decode(Int.self, forKey: .budget)
        original_title = try? container.decode(String.self, forKey: .original_title)
        imdb_id = try? container.decode(String.self, forKey: .imdb_id)
        original_language = try? container.decode(String.self, forKey: .original_language)
        title = try? container.decode(String.self, forKey: .title)
        revenue = try! container.decode(Int.self, forKey: .revenue)
        runtime = try! container.decode(Int.self, forKey: .runtime)
        tagline = try? container.decode(String.self, forKey: .tagline)
        backdrop_path = try? container.decode(String.self, forKey: .backdrop_path)
        popularity = try! container.decode(Double.self, forKey: .popularity)
        vote_count = try! container.decode(Int.self, forKey: .vote_count)
        video = try! container.decode(Bool.self, forKey: .video)
        vote_average = try! container.decode(Double.self, forKey: .vote_average)
        spoken_languages = try? container.decode([Languages].self, forKey: .spoken_languages)
        production_countries = try? container.decode([ProductionCountries].self, forKey: .production_countries)
        production_companies = try? container.decode([ProductionCompany].self, forKey: .production_companies)
        genres = try? container.decode([Genre].self, forKey: .genres)
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

extension MovieDetails{
    enum CodingKeys: String, CodingKey {
        case homepage
        case status        
        case poster_path
        case adult
        case overview
        case release_date
        case id
        case budget
        case original_title
        case imdb_id
        case original_language
        case title
        case revenue
        case runtime
        case tagline
        case backdrop_path
        case popularity
        case vote_count
        case video
        case vote_average
        case spoken_languages
        case production_countries
        case production_companies
        case genres
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(homepage, forKey: .homepage)
        try? container.encode(status, forKey: .status)
        try? container.encode(poster_path, forKey: .poster_path)
        try? container.encode(adult, forKey: .adult)
        try? container.encode(overview, forKey: .overview)
        try? container.encode(release_date, forKey: .release_date)
        try? container.encode(id, forKey: .id)
        try? container.encode(budget, forKey: .budget)
        try? container.encode(original_title, forKey: .original_title)
        try? container.encode(imdb_id, forKey: .imdb_id)
        try? container.encode(original_language, forKey: .original_language)
        try? container.encode(title, forKey: .title)
        try? container.encode(revenue, forKey: .revenue)
        try? container.encode(runtime, forKey: .runtime)
        try? container.encode(tagline, forKey: .tagline)
        try? container.encode(backdrop_path, forKey: .backdrop_path)
        try? container.encode(popularity, forKey: .popularity)
        try? container.encode(vote_count, forKey: .vote_count)
        try? container.encode(video, forKey: .video)
        try? container.encode(vote_average, forKey: .vote_average)
        try? container.encode(spoken_languages, forKey: .spoken_languages)
        try? container.encode(production_countries, forKey: .production_countries)
        try? container.encode(production_companies, forKey: .production_companies)
        try? container.encode(genres, forKey: .genres)
    }
}

