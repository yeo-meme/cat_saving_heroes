//
//  UserInfo.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/11/01.
//

import Foundation


struct UserInfo: Identifiable, Decodable {
    // var id: ObjectIdentifier
    
    var id: String {
        return NSUUID().uuidString
    }
    let _id: String?
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



}

  
