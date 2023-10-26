//
//  StrayCatsItemViewModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/25.
//

import Foundation
import Alamofire


class StrayCatsItemViewModel: ObservableObject {
    @Published var arrCats:[Cats]=[]
    //
    init() {
        loadStrayCats()
    }
    
    func loadStrayCats() {
            AF.request(CAT_SELECT_API_URL, method: .get).responseDecodable(of: [Cats].self) { response in
                switch response.result {
                case .success(let value):
                    print("성공 디코딩 : \(value)")
                    self.arrCats = value
                case .failure(let error):
                    print("실패 디코딩 : \(error.localizedDescription)")
                }
            }
    }
}
