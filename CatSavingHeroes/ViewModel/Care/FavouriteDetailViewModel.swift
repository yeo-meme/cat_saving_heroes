//
//  FavouriteDetailViewModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/27.
//

import Foundation
import Alamofire

class FavouriteDetailViewModel:ObservableObject {
    
    @Published var allUserInfoCatList:[UserInfo]=[]
    
    
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
            AF.request(USER_INFO_CARE_CAT_ID_ADD, method: .post,parameters: jsonData,  encoding: JSONEncoding.default)
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
    
    //좋아요
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
    
    //좋아요 상태뷰 표시를 위한 데이터 로드
    func dataLoad(finished: @escaping([UserInfo]) -> Void) {
        let uid = AuthViewModel.shared.currentUser?.id ?? ""
        print("compareInterestOwner user uid: \(uid)")
        
        let jsonData = [
            "user_uuid": uid,
        ] as [String:Any]
        
        do {
            AF.request(USER_INFO_ALL_ROAD, method: .post, parameters: jsonData, encoding: JSONEncoding.default)
                .responseDecodable(of:[UserInfo].self) { response in
                    switch response.result {
                    case .success(let info):
                        print("user info 불러오기 성공 : \(info)")
                        self.allUserInfoCatList=info
                        finished(info)
                        
                    case .failure(let error):
                        print("userInfo loaded fail : \(error)")
                    }
                }
        } catch {
            print("FavouriteDetailViewModel error: \(error.localizedDescription)")
        }
    }

  
    func checkCommonIds()->Bool {
        return allUserInfoCatList.contains { idArray in
            hasCommonIds(idArray)
        }
    }
    
    func hasCommonIds(_ userInter:UserInfo) -> Bool {
        let choicecat = UserDefaults.standard.string(forKey: "CatId") ?? ""
        print("catMatchLoad see Add uid: \(choicecat)")
        
        print("똑같은게 잇는지 : \(userInter.interest_cat_ids.contains(choicecat))")
        return userInter.interest_cat_ids.contains(choicecat)
    }
}
