//
//  CreatedBy.swift
//  
//
//  Created by Alex Rodriguez on 02/08/21.
//

import Foundation
import Realm
import RealmSwift

class CreatedBy: Object, Codable {
    @objc dynamic var id  : Int = 0
    @Published @objc dynamic var name : String?
    @Published @objc dynamic var profile_path : String?
    @Published @objc dynamic var gender  : Int = 0
    @Published @objc dynamic var credit_id : String?

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        profile_path = try? container.decode(String.self, forKey: .profile_path)
        credit_id = try? container.decode(String.self, forKey: .credit_id)
        gender = try! container.decode(Int.self, forKey: .gender)
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

extension CreatedBy{
    enum CodingKeys: String, CodingKey {
        case profile_path
        case credit_id
        case gender
        case id
        case name
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(profile_path, forKey: .profile_path)
        try? container.encode(credit_id, forKey: .credit_id)
        try? container.encode(gender, forKey: .gender)
        try? container.encode(id, forKey: .id)
        try? container.encode(name, forKey: .name)
    }
}
