//
//  WatchCellViewModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/24.
//

import Foundation
import Alamofire

class WatchCellViewModel: ObservableObject {
    @Published var userCats=[CatRealmModel]()
    // @Published var userCats = [CatRealmModel]()
    @Published var arrUsercats=[Cats]()
    @Published var isDataLoaded = false

    init() {
        fetchMatchCat()
    }
    
    func fetchMatchCat() {
        AF.request(CAT_SELECT_API_URL, method: .get).responseDecodable(of: [Cats].self) { response in
             switch response.result {
             case .success(let value):
              print("성공 디코딩 : \(value)")
                 self.arrUsercats = value
                 self.isDataLoaded = true
             case .failure(let error):
                 print("실패 디코딩 : \(error.localizedDescription)")
             }
         }
    }

    
    
    // func fetchUsercat() {
    //     if let userId = AuthViewModel.shared.currentUser?.uid {
    //         print("fetchUsercat user ID : \(userId)")
    //         
    //         let arr = RealmHelper.shared.read(CatRealmModel.self)
    //         print("fetchUsercat user ID get CatRealmModel : \(arr)")
    //         
    //         for userCat in arr {
    //             if userCat.user_id == userId {
    //                 userCats.append(userCat)
    //                 print("fetchUsercat 일치하는거 userCat datarealmCall All: \(userCats)")
    //             }
    //             print("fetchUsercat 걍출력 userCat datarealmCall All: \(userCat)")
    //         }
    //         // let results = RealmHelper.shared.getCatByUserId(userId: userId)
    //         // userCats2 = results
    //         // print("fetchUsercat userCat 쿼리 결과 : \(userCats2)")
    //         // finishedLoad = true
    //     }
    // }

    }
