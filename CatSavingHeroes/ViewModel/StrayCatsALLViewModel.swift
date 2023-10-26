//
//  StrayCatsItemViewModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/25.
//

import Foundation
import Alamofire


class StrayCatsALLViewModel: ObservableObject {
    @Published var arrAllCatsList:[Cats]?
    @Published var arrCatsList:[EventCat]?
    @Published var arrCatsId:[String]=[]
    //
    init() {
        loadStrayAllCats()
    }
    
    func loadStrayAllCats() {
            AF.request(CAT_SELECT_API_URL, method: .get).responseDecodable(of: [Cats].self) { response in
                switch response.result {
                case .success(let value):
                    print("성공 디코딩 StrayCatsItemViewModel: \(value)")
                    self.arrAllCatsList = value
                    print("성공 디코딩 StrayCatsItemViewModel arrCats: \(self.arrAllCatsList)")
                case .failure(let error):
                    print("실패 디코딩 StrayCatsItemViewModel : \(error.localizedDescription)")
                }
            }
    }
    
    
    func matchingCatCall() {
        AF.request(CAT_SELECT_API_URL, method: .get).responseDecodable(of: [Cats].self) { response in
            switch response.result {
            case .success(let value):
                print("성공 디코딩 StrayCatsItemViewModel: \(value)")
                self.arrAllCatsList = value
                print("성공 디코딩 StrayCatsItemViewModel arrCats: \(self.arrAllCatsList)")
                self.filterCat()
            case .failure(let error):
                print("실패 디코딩 StrayCatsItemViewModel : \(error.localizedDescription)")
            }
        }
    }
    
    func filterCat() {
        // if let arrAllCatsList = arrAllCatsList {
        //     for cat in arrAllCatsList {
        //         if cat.id =
        //     }
        //     
        // }
    }
    
    func loadStrayCats() {
            AF.request(CARE_CAT_SELECT_API_URL, method: .get).responseDecodable(of: [EventCat].self) { response in
                switch response.result {
                case .success(let value):
                    print("성공 디코딩 EventItemViewModel: \(value)")
                    self.arrCatsList = value
                    print("성공 디코딩 EventItemViewModel arrCats: \(self.arrCatsList)")
                case .failure(let error):
                    print("실패 디코딩 EventItemViewModel : \(error.localizedDescription)")
                }
            }
    }
}
