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
    // var uuid: String
    var insert_user: String
    var coordinates: Array<Double>
    var status: Int
    var _id:String
    // var watch_count: Int
    // var interest_count: Int
    // var care_count: Int
    // var watch_id: Array<String>
    // var interest_id: Array<String>
    // var care_id: Array<String>

    // var timestamps:Timestamps
    // var created_at:String
    // var updated_at:String

    enum CodingKeys: String, CodingKey {
        case name
        case age
        case cat_photo
        case gender
        case discover_address
        // case uuid
        case insert_user
        case coordinates
        case status
        case memo
        case _id
        // case watch_count
        // case interest_count
        // case care_count
        // case watch_id
        // case interest_id
        // case care_id
        // case timestamps
        // case created_at
        // case updated_at
    }
}
