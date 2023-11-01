//
//  UserInfo.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/11/01.
//

import Foundation


struct UserInfo: Identifiable, Decodable {
   
    var id: String {
        return NSUUID().uuidString
    }
    let user_uuid: String
    var user_email: String
    var user_name: String
    var track_uuids: Array<String>
    var see_cat_ids:Array<String>
    var interest_cat_ids: Array<String>
    var care_cat_ids: Array<String>
    var status: Int

    
    enum CodingKeys: String, CodingKey {
          // case id = "_id"
          case user_uuid
          case user_email
          case user_name
          case track_uuids
          case see_cat_ids
          case interest_cat_ids
          case care_cat_ids
          case status
      }
}
