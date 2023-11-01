//
//  CatDeatailViewModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/11/01.
//

import Foundation
import Alamofire

class CatDeatailViewModel: ObservableObject {
    
    func catCareInfoRoad() {
        AF.request(USER_INFO_SEE_CAT_ID_ADD, method: .get).responseDecodable(of: [Cats].self) { response in
            switch response.result {
            case .success(let value):
                print("성공 디코딩 : \(value)")
            case .failure(let error):
                print("실패 디코딩 : \(error.localizedDescription)")
            }
        }
    }
}
