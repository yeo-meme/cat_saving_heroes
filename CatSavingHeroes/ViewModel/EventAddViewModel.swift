//
//  EventAddViewModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/11.
//

import Foundation
import RealmSwift

class EventAddViewModel: ObservableObject {
    @Published var eventCat: Results<CareRealmModel>?
    // @Published var careModel = Cat()
    
    
    
    func eventAddCat(state: String, user_id: String, cat_id: String, memo: String, coordinate: String, address: String, date: Date) {
        
        let sessionId = UserDefaults.standard.string(forKey: "User") ?? ""
        // guard let currentUserId = AuthViewModel.shared.currentUser?.id else { return }
        print("현재 user: \(sessionId)")
        
        // Attempt to retrieve the JSON data from UserDefaults
        if let jsonData = UserDefaults.standard.data(forKey: "catsData") {
            do {
                // Decode the JSON data into a Cat object
                let decoder = JSONDecoder()
                let cat = try decoder.decode(Cat.self, from: jsonData)
                
                // Extract the 'id' value and store it in a variable
                let idFromSavedData = cat.id
                
                
                //이벤트 등록
                // CareRealmModel 객체 생성 및 데이터 등록
                let careModel = CareRealmModel()
                careModel.state = state
                careModel.user_id = sessionId
                careModel.cat_id = idFromSavedData
                careModel.memo = memo
                careModel.coordinate = "Coordinates"
                careModel.address = "Address"
                careModel.date = Date() // 현재 날짜를 설정
                
                let realm = try! Realm()
                do {
                    try realm.write {
                        realm.add(careModel)
                    }
                } catch {
                    print("Error saving data: \(error)")
                }
                loadEventAddCat()
                // Now, 'idFromSavedData' contains the 'id' value from the saved data
                print("Loaded 'id' from saved data: \(idFromSavedData)")
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("No JSON data found in UserDefaults.")
        }
        //TODO 고양이 아이디외의 모든 정보 리스트로 담기
        let catId = UserDefaults.standard.string(forKey: "CatId") ?? ""
        print("선택 냥이 가제 : \(catId)")
        
        // let careViewModel = Cat(from: Cat.self)
        // let cats = careViewModel.cats
        
      
    }
    
    func loadEventAddCat() {
        let realm = try! Realm()
        let careModels = realm.objects(CareRealmModel.self)
        
        for careModel in careModels {
            print("e State: \(careModel.state)")
            print("e User ID: \(careModel.user_id)")
            print("e Cat ID: \(careModel.cat_id)")
            print("e Memo: \(careModel.memo)")
            print("e Coordinates: \(careModel.coordinate)")
            print("e Address: \(careModel.address)")
            if let date = careModel.date {
                print("e Date: \(date)")
            } else {
                print("e Date is nil")
            }
            print("---------")
        }
    }
}
