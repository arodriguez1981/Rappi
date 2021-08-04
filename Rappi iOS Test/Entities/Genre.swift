//
//  Genre.swift
//  
//
//  Created by Alex Rodriguez on 02/08/21.
//

import Foundation
import Realm
import RealmSwift

class Genre: Object, Codable {
    @objc dynamic var id : Int = 0
    @Published @objc dynamic var name : String?
   

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
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

extension Genre{
    enum CodingKeys: String, CodingKey {        
        case id
        case name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(id, forKey: .id)
        try? container.encode(name, forKey: .name)
    }
}
