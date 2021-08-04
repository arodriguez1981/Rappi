//
//  Video.swift
//  Rappi iOS Test
//
//  Created by Alex Rodriguez on 03/08/21.

//

import Foundation
import Realm
import RealmSwift

class Video: Object, Codable {
    @objc dynamic var id  : Int = 0
    @Published @objc dynamic var name : String?
    @Published @objc dynamic var type : String?
    @Published @objc dynamic var site : String?
    @Published @objc dynamic var size  : Int = 0
    @Published @objc dynamic var key  : String?
    @Published @objc dynamic var iso_639_1 : String?

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try? container.decode(String.self, forKey: .type)
        id = try! container.decode(Int.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
        size = try! container.decode(Int.self, forKey: .size)
        site = try? container.decode(String.self, forKey: .site)
        key = try? container.decode(String.self, forKey: .key)        
        iso_639_1 = try? container.decode(String.self, forKey: .iso_639_1)
        
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


extension Video{
    enum CodingKeys: String, CodingKey {
        case site
        case key
        case size
        case iso_639_1
        case type
        case id
        case name
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(site, forKey: .site)
        try? container.encode(key, forKey: .key)
        try? container.encode(type, forKey: .type)
        try? container.encode(size, forKey: .size)
        try? container.encode(iso_639_1, forKey: .iso_639_1)
        try? container.encode(id, forKey: .id)
        try? container.encode(name, forKey: .name)
    }
}
