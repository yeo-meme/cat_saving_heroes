//
//  SelectableUser.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/11/01.
//

import Foundation

struct SelectableUser: Identifiable {
    let user: UserInfo
    var isSelected: Bool = false
    
    var id: String {
        return user.id ?? NSUUID().uuidString
    }
}
