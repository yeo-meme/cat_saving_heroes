//
//  UserInfo.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/11/01.
//

import Foundation


struct UserInfo: Identifiable, Decodable {
    // var id: ObjectIdentifier
    
    // var id: String {
    //     return NSUUID().uuidString
    // }
    let id: String?
    let user_uuid: String?
    let user_email: String?
    let user_name: String?
    let track_uuids: [String?]
    let see_cat_ids: [String?]
    let interest_cat_ids: [String?]
    let care_cat_ids: [String?]
    let status: Int?
    // let created_at: String
    // let updated_at: String
    // 
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case user_uuid
        case user_email
        case user_name
        case track_uuids
        case see_cat_ids
        case interest_cat_ids
        case care_cat_ids
        case status
        // case created_at
        // case updated_at
    }

    // init(from decoder: Decoder) throws {
    //     let container = try decoder.container(keyedBy: CodingKeys.self)
    // 
    //     _id = try container.decode(String.self, forKey: .id)
    //     user_uuid = try container.decode(String.self, forKey: .user_uuid)
    //     user_email = try container.decode(String.self, forKey: .user_email)
    //     user_name = try container.decode(String.self, forKey: .user_name)
    //     track_uuids = try container.decode([String].self, forKey: .track_uuids)
    //     see_cat_ids = try container.decode([String].self, forKey: .see_cat_ids)
    //     interest_cat_ids = try container.decode([String].self, forKey: .interest_cat_ids)
    //     care_cat_ids = try container.decode([String].self, forKey: .care_cat_ids)
    //     status = try container.decode(Int.self, forKey: .status)
    //     // created_at = try container.decode(String.self, forKey: .created_at)
    //     // updated_at = try container.decode(String.self, forKey: .updated_at)
    // }

}

  
