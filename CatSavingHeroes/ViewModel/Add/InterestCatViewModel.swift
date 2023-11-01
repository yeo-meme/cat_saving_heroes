//
//  InterestCatViewModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/11/02.
//

import Foundation
import Alamofire

class InterestCatViewModel: ObservableObject {
    @Published var allInterestCatList:[String?] = []
    @Published var interestCatList:[UserInfo]?
    
    func matchUserInterestCatLoad() {
        
        let user = AuthViewModel.shared.currentUser?.id ?? ""
        let jsonData = [
                       "user_uuid": user,
                   ] as [String : Any] // 데이터를 JSON 형식으로 준비
        AF.request(USER_INFO_ALL_ROAD, method: .post, parameters: jsonData ,  encoding: JSONEncoding.default)
            .responseDecodable(of: [UserInfo].self) { response in
                switch response.result {
                case .success(let userInfo):
                    // 성공적으로 데이터를 받았을 때
                    self.interestCatList = userInfo
                    self.fileterCat()
                    print("matchUserInterestCatLoad POST DEBUG : \(userInfo)")
                case .failure(let error):
                    // 요청 또는 응답이 실패했을 때
                    print("matchUserInterestCatLoad failed with error: \(error)")
                }
            }
    }
    
    func fileterCat() {
        if let interestCatList = interestCatList {
            for cat in interestCatList {
                print("졸려 : \(cat.interest_cat_ids)")
                allInterestCatList.append(contentsOf: cat.interest_cat_ids)
            }
            
        }
    }
    
    //TODO 불러오기
    func roadCat() {
        for optionalString in allInterestCatList {
            if let unwrappedString = optionalString {
                // unwrappedString에는 옵셔널이 아닌 값이 포함됩니다.
                print(unwrappedString)
            } else {
                // nil인 경우 처리할 내용을 여기에 추가할 수 있습니다.
                print("Value is nil")
            }
        }
    }
}
