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
    
    func eventAddCat(state: String, user_id: String, cat_id: String, memo: String, coordinate: String, address: String, date: Date) {
        // CareRealmModel 객체 생성 및 데이터 등록
        let careModel = CareRealmModel()
        careModel.state = "Some State"
        careModel.user_id = "User ID"
        careModel.cat_id = "Cat ID"
        careModel.memo = "Some Memo"
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
        }
    
    func geteventAddCat() {
        let realm = try! Realm()
        let careModels = realm.objects(CareRealmModel.self)

        for careModel in careModels {
            print("State: \(careModel.state)")
            print("User ID: \(careModel.user_id)")
            print("Cat ID: \(careModel.cat_id)")
            print("Memo: \(careModel.memo)")
            print("Coordinates: \(careModel.coordinate)")
            print("Address: \(careModel.address)")
            if let date = careModel.date {
                print("Date: \(date)")
            } else {
                print("Date is nil")
            }
            print("---------")
        }
    }
}
