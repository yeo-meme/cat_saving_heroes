//
//  WatchItemCellModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/24.
//

import Foundation

class WatchItemCellModel: ObservableObject{
    @Published var userCats:CatRealmModel?
    
    init(_ userCats: CatRealmModel) {
        self.userCats = userCats
    }
    
    var accessUserCatName: String {
        print("WatchItemCellModel : \(userCats?.name)")
        return userCats?.name ?? ""
    }
    
    var accessUserCatProfileImage: String {
        print("WatchItemCellModel : \(userCats?.profileImage)")
        return userCats?.profileImage ?? ""
    }
}
