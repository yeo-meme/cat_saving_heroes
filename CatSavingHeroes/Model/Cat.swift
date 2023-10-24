//
//  Cat.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/11.
//

import Foundation


struct Cat: Identifiable, Decodable, Encodable {
   
    var id: String
    var name: String
    var age: Int
    var address: String
    var gender: String
    var memo: String
    var profileImage: String
    var user_id: String
    var location: String
    var state: Int

    enum CodingKeys: String, CodingKey {
          case id
          case name
          case age
          case address
          case gender
          case memo
          case profileImage
          case user_id
          case location
          case state
      }
}

