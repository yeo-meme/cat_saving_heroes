//
//  Cats.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/25.
//

import Foundation


struct Cats: Identifiable , Codable{
    var id: String {
        return NSUUID().uuidString
    }
    var name: String
    var age: Int
    var memo:String
    var gender:String
    var cat_photo: String // cat_photo에 대한 매핑
    var discover_address: String
    var uuid: String
    var insert_user: String
    var latitude: String?
    var longitude: String?
    var status: Int
    // var timestamps:Timestamps
    // var created_at:String
    // var updated_at:String

    enum CodingKeys: String, CodingKey {
        // case _id
        case name
        case age
        case cat_photo
        case gender
        case discover_address
        case uuid
        case insert_user
        case latitude
        case longitude
        case status
        case memo
        // case timestamps
        // case created_at
        // case updated_at
    }
}
