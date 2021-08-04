//
//  Movie.swift
//  
//
//  Created by Alex Rodriguez on 02/08/21.
//

import Foundation
import Realm
import RealmSwift

class Movie: Object, Codable{
    @Published @objc dynamic var poster_path : String?
    @Published dynamic var adult  : Bool?
    @Published @objc dynamic var overview : String?
    @Published @objc dynamic var release_date : Date?
    @objc dynamic var id : Int = 0
    @Published @objc dynamic var original_title : String?
    @Published @objc dynamic var original_language : String?
    @Published @objc dynamic var title : String?
    @Published @objc dynamic var backdrop_path : String?
    @Published @objc dynamic var popularity  : Double = 0
    @Published @objc dynamic var vote_count  : Int = 0
    @Published dynamic var video  : Bool?
    @Published @objc dynamic var vote_average  : Double = 0
    @Published var genre_ids : Array<Int>?
    
    init(_ idNew: Int) {
        poster_path = ""
        adult = false
        overview = ""
        release_date = Date()
        id = idNew
        original_title = ""
        original_language = ""
        title = ""
        backdrop_path = ""
        popularity = 0.0
        vote_count = 0
        video = false
        vote_average = 0.0
        genre_ids = Array<Int>()
    }
    
    override static func primaryKey() -> String?
    {
        return "id"
    }
    
    required override init()
    {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        poster_path = try? container.decode(String.self, forKey: .poster_path)
        adult = try? container.decode(Bool.self, forKey: .adult)
        overview = try? container.decode(String.self, forKey: .overview)
        release_date = try? container.decode(Date.self, forKey: .release_date)
        id = try! container.decode(Int.self, forKey: .id)
        original_title = try? container.decode(String.self, forKey: .original_title)
        original_language = try? container.decode(String.self, forKey: .original_language)
        title = try? container.decode(String.self, forKey: .title)
        backdrop_path = try? container.decode(String.self, forKey: .backdrop_path)
        popularity = try! container.decode(Double.self, forKey: .popularity)
        vote_count = try! container.decode(Int.self, forKey: .vote_count)
        video = try? container.decode(Bool.self, forKey: .video)
        vote_average = try! container.decode(Double.self, forKey: .vote_average)
        genre_ids = try? container.decode([Int].self, forKey: .genre_ids)
    }
}

extension Movie{
    enum CodingKeys: String, CodingKey {
        case poster_path
        case adult
        case overview
        case release_date
        case id
        case original_title
        case original_language
        case title
        case backdrop_path
        case popularity
        case vote_count
        case video
        case vote_average
        case genre_ids
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(poster_path, forKey: .poster_path)
        try? container.encode(adult, forKey: .adult)
        try? container.encode(overview, forKey: .overview)
        try? container.encode(release_date, forKey: .release_date)
        try? container.encode(id, forKey: .id)
        try? container.encode(original_title, forKey: .original_title)
        try? container.encode(original_language, forKey: .original_language)
        try? container.encode(title, forKey: .title)
        try? container.encode(backdrop_path, forKey: .backdrop_path)
        try? container.encode(popularity, forKey: .popularity)
        try? container.encode(vote_count, forKey: .vote_count)
        try? container.encode(video, forKey: .video)
        try? container.encode(vote_average, forKey: .vote_average)
        try? container.encode(genre_ids, forKey: .genre_ids)
    }
}

