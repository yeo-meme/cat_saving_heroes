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
    var age: String
    var address: String
    var gender: String
    var memo: String
    var profileImage: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case age = "age"
        case address = "address"
        case gender = "gender"
        case memo = "memo"
        case profileImage = "profileImage"
    }
}

