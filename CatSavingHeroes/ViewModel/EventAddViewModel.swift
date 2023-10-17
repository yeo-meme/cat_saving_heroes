//
//  EventAddViewModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/11.
//

import Foundation
import RealmSwift
import MapKit

class EventAddViewModel: ObservableObject {
  
    private var model: Model
    private var isLocationTrackingEnabled: Bool = false // Model 인스턴스를 저장하는 프로퍼티 추가
    @Published var annotations: [MKPointAnnotation] = []
    
    
    init(model: Model) {  // 생성자에서 Model 인스턴스 주입
        self.model = model
        isLocationTrackingEnabled = model.isLocationTrackingEnabled
        print("Where - Event Add ViewModel 초기 isLocationTrackingEnabled: \(model.isLocationTrackingEnabled)")
        
    }
    
    @Published var eventCat: Results<CareRealmModel>?
    // @Published var careModel = Cat()
    
    
    func isRunningCatWalk(latitude: Double, logtitude: Double, state: String, user_id: String, cat_id: String, memo: String, coordinate: String, address: String, date: Date){
        
        // 
        let config = Realm.Configuration(
            schemaVersion: 0, // 스키마 버전을 0으로 설정
            deleteRealmIfMigrationNeeded: true // 마이그레이션이 필요한 경우 Realm 삭제
        )
        Realm.Configuration.defaultConfiguration = config
        
        let sessionId = UserDefaults.standard.string(forKey: "User") ?? ""
        // guard let currentUserId = AuthViewModel.shared.currentUser?.id else { return }
        print("현재 user: \(sessionId)")
        
        //TODO 고양이 아이디외의 모든 정보 리스트로 담기
        let catId = UserDefaults.standard.string(forKey: "CatId") ?? ""
        print("선택 냥이 가제 : \(catId)")
        
        if readLocationUserDefaults() {
            
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
                    careModel.latitude = latitude
                    careModel.longitude = logtitude
                    careModel.date = Date() // 현재 날짜를 설정
                    do {
                        RealmHelper.shared.create(careModel)
                        print("realm기록하였음 트래킹 있음: Latitude: \(latitude), Longitude: \(logtitude)")
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
            //
            // // 위치 기록을 Realm에 저장
            // let locationRecord = LocationRecord()
            // locationRecord.latitude = latitude
            // locationRecord.longitude = logtitude
            // 
            // do {
            //     let realm = try Realm()
            //     try realm.write {
            //         realm.add(locationRecord)
            //     }
            //     print("realm기록하였음: Latitude: \(locationRecord.latitude), Longitude: \(locationRecord.longitude)")
            // } catch {
            //     print("Error saving location: \(error.localizedDescription)")
            // }
            
            
        } 
    }
    
    
    func isNotRuningCatWalk(state: String, user_id: String, cat_id: String, memo: String, coordinate: String, address: String, date: Date) {
        let sessionId = UserDefaults.standard.string(forKey: "User") ?? ""
        // guard let currentUserId = AuthViewModel.shared.currentUser?.id else { return }
        print("현재 user: \(sessionId)")
        
        //TODO 고양이 아이디외의 모든 정보 리스트로 담기
        let catId = UserDefaults.standard.string(forKey: "CatId") ?? ""
        print("선택 냥이 가제 : \(catId)")
        
        if !readLocationUserDefaults() {
            
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
                    careModel.latitude = 0.0
                    careModel.longitude = 0.0
                    careModel.date = Date() // 현재 날짜를 설정
                    
                   
                    
                    do {
                        RealmHelper.shared.create(careModel)
                        
                        print("realm기록하였음 트래킹 없음: Latitude: \(careModel.latitude), Longitude: \(careModel.longitude)")
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
            //
            // // 위치 기록을 Realm에 저장
            // let locationRecord = LocationRecord()
            // locationRecord.latitude = latitude
            // locationRecord.longitude = logtitude
            //
            // do {
            //     let realm = try Realm()
            //     try realm.write {
            //         realm.add(locationRecord)
            //     }
            //     print("realm기록하였음: Latitude: \(locationRecord.latitude), Longitude: \(locationRecord.longitude)")
            // } catch {
            //     print("Error saving location: \(error.localizedDescription)")
            // }
            
            
        }
    }
    
    func eventAddCat(state: String, user_id: String, cat_id: String, memo: String, coordinate: String, address: String, date: Date) {
        
        let sessionId = UserDefaults.standard.string(forKey: "User") ?? ""
        // guard let currentUserId = AuthViewModel.shared.currentUser?.id else { return }
        print("현재 user: \(sessionId)")
        
        //TODO 고양이 아이디외의 모든 정보 리스트로 담기
        let catId = UserDefaults.standard.string(forKey: "CatId") ?? ""
        print("선택 냥이 가제 : \(catId)")
        
        
        // 트레킹 있을때 로드하기
        if !readLocationUserDefaults() {
           
            // Attempt to retrieve the JSON data from UserDefaults
            // if let jsonData = UserDefaults.standard.data(forKey: "catsData") {
            //     do {
            //         // Decode the JSON data into a Cat object
            //         let decoder = JSONDecoder()
            //         let cat = try decoder.decode(Cat.self, from: jsonData)
            //         
            //         // Extract the 'id' value and store it in a variable
            //         let idFromSavedData = cat.id
            //         
            //         //이벤트 등록
            //         // CareRealmModel 객체 생성 및 데이터 등록
            //         let careModel = CareRealmModel()
            //         careModel.state = state
            //         careModel.user_id = sessionId
            //         careModel.cat_id = idFromSavedData
            //         careModel.memo = memo
            //         careModel.coordinate = "Coordinates"
            //         careModel.address = "Address"
            //         careModel.latitude = latitude
            //         careModel.longtitude = longtitude
            //         careModel.date = Date() // 현재 날짜를 설정
            //         
            //         let realm = try! Realm()
            //         do {
            //             try realm.write {
            //                 realm.add(careModel)
            //             }
            //         } catch {
            //             print("Error saving data: \(error)")
            //         }
            //         loadEventAddCat()
            //         // Now, 'idFromSavedData' contains the 'id' value from the saved data
            //         print("Loaded 'id' from saved data: \(idFromSavedData)")
            //     } catch {
            //         print("Error decoding JSON: \(error)")
            //     }
            // } else {
            //     print("No JSON data found in UserDefaults.")
            // }
            
        } else {
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
    
    //트레킹
    func readLocationUserDefaults() -> Bool{
        
        let defaults = UserDefaults.standard
        
        // "isLocationTrackingEnabled" 키로 저장된 값 가져오기
        if let existingValue = defaults.object(forKey: "isLocationTrackingEnabled") as? NSNumber {
            // "isLocationTrackingEnabled" 키로 저장된 값이 존재하면
            return existingValue.boolValue // 불리언 값으로 변환해서 반환
        } else {
            // "isLocationTrackingEnabled" 키로 저장된 값이 없다면 기본값 반환
            return false // 또는 true, 앱의 초기 설정에 따라 달라집니다.
        }
        
        
        // let defaults = UserDefaults.standard
        //
        // // 기존 값 가져오기
        // //as? NSNumber를 통해 NSNumber 형식으로 변환되며, 반환된 값을 옵셔널로 처리
        // let existingValue = defaults.object(forKey: "isLocationTrackingEnabled") as? NSNumber
        // let existingState = existingValue?.boolValue
        //
        // if let existingValue, let existingState {
        //
        //     // // 위치 기록을 Realm에 저장
        //     // let locationRecord = LocationRecord()
        //     // locationRecord.latitude = model.lastLocation.latitude
        //     // locationRecord.longitude = model.lastLocation.longitude
        //     //
        //     // do {
        //     //     let realm = try Realm()
        //     //     try realm.write {
        //     //         realm.add(locationRecord)
        //     //     }
        //     //     print("realm기록하였음: Latitude: \(locationRecord.latitude), Longitude: \(locationRecord.longitude)")
        //     // } catch {
        //     //     print("Error saving location: \(error.localizedDescription)")
        //     // }
        //     // return true
        //     // } else {
        //     //     return false
        //     // }
        //     // } else {
        //     //     print("existingState is nil")
        //     //     // return false
        //     return true
        // } else {
        //     return false
        // }
    }
    
    // //고양이 이벤트 표시 realm 호출
    // func loadAnnotationsFromRealm() {
    //     do {
    //         let realm = try Realm()
    //         let careModels = realm.objects(CareRealmModel.self)
    //         for careModel in careModels {
    //             if careModel.latitude != 0.0 && careModel.longitude != 0.0 {
    //                 let annotation = MKPointAnnotation()
    //                 annotation.coordinate = CLLocationCoordinate2D(latitude: careModel.latitude, longitude: careModel.longitude)
    //                 annotations.append(annotation)
    //             }
    //         }
    //     } catch {
    //         print("Error loading data from Realm: \(error)")
    //     }
    // }
    
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

