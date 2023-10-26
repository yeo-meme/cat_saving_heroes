//
//  WatchItemCellModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/24.
//

import Foundation

class WatchItemCellModel: ObservableObject{
    @Published var userCat:Cats
    
    init(_ userCat: Cats) {
        self.userCat = userCat
        print("item cell WatchItemCellModel : \(self.userCat)")
    }
    
    // var accessUserCatName: String {
    //     print("WatchItemCellModel name : \(userCat.name)")
    //     return userCat.name
    // }
    // // 
    // var accessUserCatProfileImage: String {
    //     print("WatchItemCellModel cat_photo : \(userCat.cat_photo)")
    //     return userCat.cat_photo
    // }
}
