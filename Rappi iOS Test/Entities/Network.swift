//
//  Network.swift
//  
//
//  Created by Alex Rodriguez on 02/08/21.
//

import Foundation
import Realm
import RealmSwift

class Network: Object, Codable {
    @objc dynamic var id : Int = 0
    @Published @objc dynamic var name : String?
    @Published @objc dynamic var logo_path : String?
    @Published @objc dynamic var origin_country : String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        logo_path = try? container.decode(String.self, forKey: .logo_path)
        origin_country = try? container.decode(String.self, forKey: .origin_country)
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

extension Network{
    enum CodingKeys: String, CodingKey {
        case logo_path
        case origin_country
        case id
        case name        
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(logo_path, forKey: .logo_path)
        try? container.encode(origin_country, forKey: .origin_country)
        try? container.encode(id, forKey: .id)
        try? container.encode(name, forKey: .name)
    }
}
