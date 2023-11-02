//
//  StrayCatsItemViewModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/25.
//

import Foundation
import Alamofire
import SwiftUI


class StrayCatsALLViewModel: ObservableObject {
    @Published var arrGeoCatsList:[EventCat]?
    @Published var filterGeoCatsList=[Cats]() //최종
    @Published var arrGeoCatsId:[String]=[]
    @Published var coordinates:[Double]?
    @Published var meter:Int?
    @Published var isDataLoaded:Bool = false
    // @EnvironmentObject var model:AddressManager
    
    @Published var userInfoArr:[UserInfo]=[]  
    @Published var eventMatchCat:EventCat?
 
    // let _meterInit:Int?
    // let coordinatesInit:[Double]?
    
    
    init() {
        // var coordi:Array=[0.0,0.0]
        // coordi[0]=model.currentGeoPoint?.longitude ?? 0.0
        // coordi[1]=model.currentGeoPoint?.latitude ?? 0.0
        // print("현재위치. : \(coordi)")
        
       
        // super.init()
        //
        self.loadStrayAllCatsIfNotLoaded(coordinates: [127.029429,37.554297] , meter: 1000)
        
    }
    
    
    func loadStrayAllCatsIfNotLoaded(coordinates: [Double], meter: Int) {
           if !isDataLoaded { // 데이터가 아직 로드되지 않았을 때만 로드
               loadStrayAllCats(coordinates: coordinates, meter: meter)
           }
       }
    
    
    func loadUserInfoLikeButton() {
        
        
        let user = AuthViewModel.shared.currentUser?.id ?? ""
        let parameters: Parameters = [
            "user_uuid": user,
         ]
        
        AF.request(USER_INFO_ALL_ROAD, method: .post, parameters: parameters ).responseDecodable(of: [UserInfo].self) { response in
                switch response.result {
                case .success(let value):
                    print("성공 디코딩 loadUserInfoLikeButton: \(value)")
                    self.userInfoArr = value
                case .failure(let error):
                    print("실패 디코딩 loadUserInfoLikeButton : \(error.localizedDescription)")
                }
            }
    }
    
    func matchFinding(cats: Cats, userInfo:UserInfo)->[Int] {
        var flagInterest = 0
        var flagCare = 0
        
        for catId in userInfo.interest_cat_ids {
            if catId == cats._id {
                flagInterest = 1
            }
        }
       
        for catId in userInfo.care_cat_ids {
            if catId == cats._id {
                flagCare = 1
            }
        }
        
      
        
        return [flagInterest, flagCare]
    }
    
    func loadDetail() {
        
        
        let parameters: Parameters = [
            "_id": arrGeoCatsId,
            // "_id": arrGeoCatsId[1],
         ]
        
        AF.request(GEO_CAT_API_URL, method: .post,parameters: parameters).responseDecodable(of: [Cats].self) { response in
            switch response.result {
            case .success(let value):
                print("나왔니 다람쥐: \(value)")
                self.filterGeoCatsList = value
                print("나왔니 다람쥐 : \(self.filterGeoCatsList)")
                self.isDataLoaded = true
                // self.filterCat()
            case .failure(let error):
                print("실패 나왔니 : \(error.localizedDescription)")
            }
        }
    }
    
    func loadStrayAllCats(coordinates:[Double],meter:Int) -> [EventCat]? {
           print("coordinates: \(coordinates)")
        let parameters: Parameters = [
            "coordinates": coordinates,
             "meter": meter,
         ]
        
        AF.request(GEO_CARE_API_URL, method: .post, parameters: parameters).responseDecodable(of: [EventCat].self) { response in
                switch response.result {
                case .success(let value):
                    print("성공 디코딩 StrayCatsItemViewModel: \(value)")
                    self.arrGeoCatsList = value
                    self.matchingCatCall()
                    print("성공 디코딩 StrayCatsItemViewModel arrCats: \(self.arrGeoCatsList)")
                case .failure(let error):
                    print("실패 디코딩 StrayCatsItemViewModel : \(error.localizedDescription)")
                }
            }
        return self.arrGeoCatsList
    }
    
    
    func matchingCatCall() {
        arrGeoCatsId.removeAll()
        if let arrGeoCatsList = self.arrGeoCatsList {
            for geoCat in arrGeoCatsList {
                arrGeoCatsId.append(geoCat.cat_uuid ?? "")
                print("arrGeoCatsId : \(arrGeoCatsId)")
            }
        }
   
        
        let parameters: Parameters = [
            "_id": arrGeoCatsId,
         ]
        
        print("params : \(parameters)")
        AF.request(GEO_CAT_API_URL, method: .post, parameters: parameters)
            .responseDecodable(of: [Cats].self) { response in
            switch response.result {
            case .success(let value):
                print("나왔니 다람쥐: \(value)")
                self.filterGeoCatsList = value
                print("나왔니 다람쥐 : \(self.filterGeoCatsList)")
                self.isDataLoaded = true
                self.filterCat()
                // self.filterCat()
            case .failure(let error):
                print("실패 나왔니 : \(error)")
            }
        }
        
        
    }
    
    func filterCat() {
        //eventCat 이벤트 넘버 디테일 보내기 위해
        if !filterGeoCatsList.isEmpty {
            for cat in filterGeoCatsList {
                if let arrGeoCats = self.arrGeoCatsList {
                    for arrCat in arrGeoCats {
                        if arrCat.cat_uuid == cat._id {
                            print("나와라 이벤트  cat_uuid: \(arrCat.cat_uuid),\(cat._id)")
                            self.eventMatchCat = arrCat
                            print("나와라 이벤트 : \(self.eventMatchCat)")
                            break // 매칭되는 항목을 찾았으면 루프를 종료
                        }
                    }
                }
            }
        } else {
            print("리스트 비워져있음")
        }
        }
    }
    
    // func loadStrayCats() {
    //         AF.request(CARE_CAT_SELECT_API_URL, method: .get).responseDecodable(of: [EventCat].self) { response in
    //             switch response.result {
    //             case .success(let value):
    //                 print("성공 디코딩 EventItemViewModel: \(value)")
    //                 self.arrCatsList = value
    //                 print("성공 디코딩 EventItemViewModel arrCats: \(self.arrCatsList)")
    //             case .failure(let error):
    //                 print("실패 디코딩 EventItemViewModel : \(error.localizedDescription)")
    //             }
    //         }
    // }

