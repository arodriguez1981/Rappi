//
//  ProductionCountries.swift
//  
//
//  Created by Alex Rodriguez on 02/08/21.
//

import Foundation
import Realm
import RealmSwift

class ProductionCountries: Object, Codable {
    @objc dynamic var iso_3166_1  : String?
    @Published @objc dynamic var name  : String?
   

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        iso_3166_1 = try? container.decode(String.self, forKey: .iso_3166_1)
        name = try? container.decode(String.self, forKey: .name)
    }
    
    override static func primaryKey() -> String?
    {
        return "iso_3166_1"
    }
    
    required override init()
    {
        super.init()
    }
}

extension ProductionCountries{
    enum CodingKeys: String, CodingKey {
        
        case iso_3166_1
        case name
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(iso_3166_1, forKey: .iso_3166_1)
        try? container.encode(name, forKey: .name)
    }
}
