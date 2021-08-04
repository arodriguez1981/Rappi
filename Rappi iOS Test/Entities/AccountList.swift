//
//  AccountList.swift
//  
//
//  Created by Alex Rodriguez on 02/08/21.
//

import Foundation
import Realm
import RealmSwift


class AccountList: Object, Codable {
    @Published @objc dynamic var iso_639_1 : String?
    @objc dynamic var id  : Int = 0
    @Published @objc dynamic var featured  : Int = 0
    @Published @objc dynamic var descript : String?
    @Published @objc dynamic var revenue : String?
    @Published @objc dynamic var publico  : Int = 0
    @Published @objc dynamic var sort_by  : Int = 0
    @Published @objc dynamic var name : String?
    @Published @objc dynamic var updated_at : String?
    @Published @objc dynamic var created_at : String?
    @Published @objc dynamic var backdrop_path : String?
    @Published @objc dynamic var iso_3166_1 : String?
    @Published @objc dynamic var adult  : Int = 0
    @Published @objc dynamic var runtime  : Int = 0
    @Published @objc dynamic var average_rating  : Double = 0
    @Published @objc dynamic var number_of_items  : Int = 0
    @Published @objc dynamic var poster_path : String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        iso_639_1 = try? container.decode(String.self, forKey: .iso_639_1)
        id = try! container.decode(Int.self, forKey: .id)
        featured = try! container.decode(Int.self, forKey: .featured)
        descript = try? container.decode(String.self, forKey: .descript)
        revenue = try? container.decode(String.self, forKey: .id)
        publico = try! container.decode(Int.self, forKey: .publico)
        sort_by = try! container.decode(Int.self, forKey: .sort_by)
        name = try? container.decode(String.self, forKey: .name)
        updated_at = try? container.decode(String.self, forKey: .updated_at)
        backdrop_path = try? container.decode(String.self, forKey: .backdrop_path)
        iso_3166_1 = try? container.decode(String.self, forKey: .iso_3166_1)
        adult = try! container.decode(Int.self, forKey: .adult)
        runtime = try! container.decode(Int.self, forKey: .runtime)
        average_rating = try! container.decode(Double.self, forKey: .average_rating)
        number_of_items = try! container.decode(Int.self, forKey: .runtime)
        poster_path = try? container.decode(String.self, forKey: .poster_path)
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


extension AccountList{
    enum CodingKeys: String, CodingKey {
        case iso_639_1
        case id
        case featured
        case release_date
        case descript = "description"
        case revenue
        case publico
        case sort_by
        case name
        case updated_at
        case created_at
        case backdrop_path
        case iso_3166_1
        case adult
        case runtime
        case average_rating
        case number_of_items
        case poster_path
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(iso_639_1, forKey: .iso_639_1)
        try? container.encode(id, forKey: .id)
        try? container.encode(featured, forKey: .featured)
        try? container.encode(descript, forKey: .descript)
        try? container.encode(revenue, forKey: .revenue)
        try? container.encode(publico, forKey: .publico)
        try? container.encode(sort_by, forKey: .sort_by)
        try? container.encode(name, forKey: .name)
        try? container.encode(updated_at, forKey: .updated_at)
        try? container.encode(created_at, forKey: .created_at)
        try? container.encode(backdrop_path, forKey: .backdrop_path)
        try? container.encode(iso_3166_1, forKey: .iso_3166_1)
        try? container.encode(adult, forKey: .adult)
        try? container.encode(runtime, forKey: .runtime)
        try? container.encode(average_rating, forKey: .average_rating)
        try? container.encode(number_of_items, forKey: .number_of_items)
        try? container.encode(poster_path, forKey: .poster_path)
    }
}


