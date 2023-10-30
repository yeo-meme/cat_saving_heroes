//
//  StrayCatsItemViewModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/25.
//

import Foundation
import Alamofire


class StrayCatsALLViewModel: ObservableObject {
    @Published var arrGeoCatsList:[EventCat]?
    @Published var filterGeoCatsList:[Cats]?
    @Published var arrGeoCatsId:[String]=[]
    @Published var coordinates:[Double]?
    @Published var meter:Int?
    @Published var isDataLoaded:Bool = false
    
    init() {
        // var coordi:Array=[0.0,0.0]
        // coordi[0]=model.currentGeoPoint?.longitude ?? 0.0
        // coordi[1]=model.currentGeoPoint?.latitude ?? 0.0
        // print("현재위치. : \(coordi)")
        // 
        // self.loadStrayAllCats(coordinates: coordi, meter: 500)
    }
    
    func loadStrayAllCats(coordinates:[Double],meter:Int) {
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
            // "_id": arrGeoCatsId[1],
         ]
        
        print("params : \(parameters)")
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
    
    func filterCat() {
        // if let arrGeoCatsList = arrGeoCatsList, let filterGeoCatsList = filterGeoCatsList {
        //     let matchingItems = arrGeoCatsList.filter { eventCat in
        //         return filterGeoCatsList.contains { cat in
        //             return cat.uuid == eventCat.cat_uuid
        //         }
        //     }
    // print("매칭 캣 : \(matchingItems)")
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

