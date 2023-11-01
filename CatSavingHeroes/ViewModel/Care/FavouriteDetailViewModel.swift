//
//  FavouriteDetailViewModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/27.
//

import Foundation
import Alamofire

class FavouriteDetailViewModel:ObservableObject {
    
    
    func seeAdd() {
        
        
        let choicecat = UserDefaults.standard.string(forKey: "CatId") ?? ""
        
     
        let uid = AuthViewModel.shared.currentUser?.id ?? ""
        print("see Add choicecat : \(choicecat)")
        print("see Add uid: \(uid)")
        
        
        let jsonData = [
            "user_uuid": uid,
            "see_cat_id":choicecat,
        ] as [String : Any] // 데이터를 JSON 형식으로 준비
        
        do {
            AF.request(USER_INFO_SEE_CAT_ID_ADD, method: .post,parameters: jsonData,  encoding: JSONEncoding.default)
                .responseDecodable(of: UserInfo.self) { response in
                    switch response.result {
                    case .success(let userInfo):
                        // 성공적으로 데이터를 받았을 때
                        print("allRoadUserInfoAPI POST DEBUG : \(userInfo)")
                    case .failure(let error):
                        // 요청 또는 응답이 실패했을 때
                        print("allRoadUserInfoAPI failed with error: \(error)")
                    }
                }
        } catch {
            print("디코딩 에러: \(error)")
        }
    }
    
    func careAdd() {
        
        
        let choicecat = UserDefaults.standard.string(forKey: "CatId") ?? ""
        
     
        let uid = AuthViewModel.shared.currentUser?.id ?? ""
        print("see Add choicecat : \(choicecat)")
        print("see Add uid: \(uid)")
        
        
        let jsonData = [
            "user_uuid": uid,
            "care_cat_id":choicecat,
        ] as [String : Any] // 데이터를 JSON 형식으로 준비
        
        do {
            AF.request(USER_INFO_SEE_CAT_ID_ADD, method: .post,parameters: jsonData,  encoding: JSONEncoding.default)
                .responseDecodable(of: UserInfo.self) { response in
                    switch response.result {
                    case .success(let userInfo):
                        // 성공적으로 데이터를 받았을 때
                        print("allRoadUserInfoAPI POST DEBUG : \(userInfo)")
                    case .failure(let error):
                        // 요청 또는 응답이 실패했을 때
                        print("allRoadUserInfoAPI failed with error: \(error)")
                    }
                }
        } catch {
            print("디코딩 에러: \(error)")
        }
    }
    
    
    func interestAdd() {
        let choicecat = UserDefaults.standard.string(forKey: "CatId") ?? ""
        
     
        let uid = AuthViewModel.shared.currentUser?.id ?? ""
        print("see Add choicecat : \(choicecat)")
        print("see Add uid: \(uid)")
        
        
        let jsonData = [
            "user_uuid": uid,
            "interest_cat_id":choicecat,
        ] as [String : Any] // 데이터를 JSON 형식으로 준비
        
        do {
            AF.request(USER_INFO_INTEREST_CAT_ID_ADD, method: .post,parameters: jsonData,  encoding: JSONEncoding.default)
                .responseDecodable(of: UserInfo.self) { response in
                    switch response.result {
                    case .success(let userInfo):
                        // 성공적으로 데이터를 받았을 때
                        print("allRoadUserInfoAPI POST DEBUG : \(userInfo)")
                    case .failure(let error):
                        // 요청 또는 응답이 실패했을 때
                        print("allRoadUserInfoAPI failed with error: \(error)")
                    }
                }
        } catch {
            print("디코딩 에러: \(error)")
        }
        
    }
}
