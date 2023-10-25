//
//  WatchItemCellModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/24.
//

import Foundation

class WatchItemCellModel: ObservableObject{
    @Published var userCats:Cats
    
    init(_ userCats: Cats) {
        self.userCats = userCats
        print("item cell : \(self.userCats)")
    }
    
    var accessUserCatName: String {
        print("WatchItemCellModel name : \(userCats.name)")
        return userCats.name
    }
    // 
    var accessUserCatProfileImage: String {
        print("WatchItemCellModel cat_photo : \(userCats.cat_photo)")
        return userCats.cat_photo
    }
}
