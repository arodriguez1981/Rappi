//
//  Language.swift
//  
//
//  Created by Alex Rodriguez on 02/08/21.
//

import Foundation
import Realm
import RealmSwift


class Languages: Object, Codable {
    @objc dynamic var iso_639_1 : String = ""
    @Published @objc dynamic var name : String?
    @Published @objc dynamic var english_name : String?
   

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        iso_639_1 = try! container.decode(String.self, forKey: .iso_639_1)
        name = try? container.decode(String.self, forKey: .name)
        english_name = try? container.decode(String.self, forKey: .english_name)
    }
    
    override static func primaryKey() -> String?
    {
        return "iso_639_1"
    }
    
    required override init()
    {
        super.init()
    }
}

extension Languages{
    enum CodingKeys: String, CodingKey {
        
        case iso_639_1
        case name
        case english_name
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(iso_639_1, forKey: .iso_639_1)
        try? container.encode(name, forKey: .name)
        try? container.encode(english_name, forKey: .english_name)
    }
}
