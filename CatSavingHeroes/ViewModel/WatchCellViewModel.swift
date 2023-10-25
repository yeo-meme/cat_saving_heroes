//
//  WatchCellViewModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/24.
//

import Foundation


class WatchCellViewModel: ObservableObject {
    @Published var userCats=[CatRealmModel]()
    // @Published var userCats = [CatRealmModel]()
    @Published var finishedLoad = false
    @Published var catsM:[Cat]=[]
    
    init() {
        fetchUsercat()
        print("값이 안들어오는건 아닐까? \(userCats)")
    }
    
    // var catName: String {
    //     // guard let catNames = userCats2 else {return ""}
    //     for cat in userCats2 {
    //         let catName = cat.name
    //         return String(catName)
    //     }
    //     return ""
    // }
    // 
    // var catProfileImage: String {
    //     // guard let catProfileImage = userCats2 else {return ""}
    //     for cat in userCats2 {
    //         let catProfileImage = cat.profileImage
    //         return String(catProfileImage)
    //     }
    // }
    
    
    func fetchUsercat() {
        if let userId = AuthViewModel.shared.currentUser?.uid {
            print("fetchUsercat user ID : \(userId)")
            
            let arr = RealmHelper.shared.read(CatRealmModel.self)
            print("fetchUsercat user ID get CatRealmModel : \(arr)")
            
            for userCat in arr {
                if userCat.user_id == userId {
                    userCats.append(userCat)
                    print("fetchUsercat 일치하는거 userCat datarealmCall All: \(userCats)")
                }
                print("fetchUsercat 걍출력 userCat datarealmCall All: \(userCat)")
            }
            // let results = RealmHelper.shared.getCatByUserId(userId: userId)
            // userCats2 = results
            // print("fetchUsercat userCat 쿼리 결과 : \(userCats2)")
            // finishedLoad = true
        }
    }

    }
