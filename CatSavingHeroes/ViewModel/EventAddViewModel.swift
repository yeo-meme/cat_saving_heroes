//
//  EventAddViewModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/11.
//

import Foundation
import RealmSwift

class EventAddViewModel: ObservableObject {
    private var model: Model
    private var isLocationTrackingEnabled: Bool = false // Model 인스턴스를 저장하는 프로퍼티 추가
    
    init(model: Model) {  // 생성자에서 Model 인스턴스 주입
        self.model = model
        isLocationTrackingEnabled = model.isLocationTrackingEnabled
        print("Where - Event Add ViewModel 초기 isLocationTrackingEnabled: \(model.isLocationTrackingEnabled)")
        
    }
    
    
    
    @Published var eventCat: Results<CareRealmModel>?
    // @Published var careModel = Cat()
    
    
    
    func eventAddCat(state: String, user_id: String, cat_id: String, memo: String, coordinate: String, address: String, date: Date) {
        
        let sessionId = UserDefaults.standard.string(forKey: "User") ?? ""
        // guard let currentUserId = AuthViewModel.shared.currentUser?.id else { return }
        print("현재 user: \(sessionId)")
        
        //TODO 고양이 아이디외의 모든 정보 리스트로 담기
        let catId = UserDefaults.standard.string(forKey: "CatId") ?? ""
        print("선택 냥이 가제 : \(catId)")
        
        
        // let careViewModel = Cat(from: Cat.self)
        // let cats = careViewModel.cats
        // isLocationTrackingEnabled
        if !readLocationUserDefaults() {
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
           
        }
        // if model.isLocationTrackingEnabled {
        //     // 위치 기록을 Realm에 저장
        //     let locationRecord = LocationRecord()
        //     locationRecord.latitude = model.lastLocation.latitude
        //     locationRecord.longitude = model.lastLocation.longitude
        //     
        //     do {
        //         let realm = try Realm()
        //         try realm.write {
        //             realm.add(locationRecord)
        //         }
        //         print("realm기록하였음: Latitude: \(locationRecord.latitude), Longitude: \(locationRecord.longitude)")
        //     } catch {
        //         print("Error saving location: \(error.localizedDescription)")
        //     }
        // } else {
        //     print("Where - Event Add ViewModel : isLocationTrackingEnabled is false")
        // }
    }
    
    func readLocationUserDefaults() -> Bool {
        
        let defaults = UserDefaults.standard
        // 기존 값 가져오기
        let existingValue = defaults.object(forKey: "isLocationTrackingEnabled") as? NSNumber
        let existingState = existingValue?.boolValue
        
        if let existingState {
            if existingState {
                // 위치 기록을 Realm에 저장
                let locationRecord = LocationRecord()
                locationRecord.latitude = model.lastLocation.latitude
                locationRecord.longitude = model.lastLocation.longitude
                
                do {
                    let realm = try Realm()
                    try realm.write {
                        realm.add(locationRecord)
                    }
                    print("realm기록하였음: Latitude: \(locationRecord.latitude), Longitude: \(locationRecord.longitude)")
                } catch {
                    print("Error saving location: \(error.localizedDescription)")
                }
                return true
            } else {
                
                return false
            }
        } else {
            print("existingState is nil")
            // return false
        }
        return false
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
