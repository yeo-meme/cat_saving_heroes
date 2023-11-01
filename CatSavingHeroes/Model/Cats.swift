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
     var age: Int?
     var memo:String?
     var gender:String
     var cat_photo: String
     var discover_address: String
     var insert_user: String
     var coordinates: [Double?]
     var status: Int
     var _id:String
     var color:[Double?]

}
