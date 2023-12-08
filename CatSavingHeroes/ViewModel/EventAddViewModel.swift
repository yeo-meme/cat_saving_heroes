//
//  EventAddViewModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/11.
//

import Foundation
import RealmSwift
import MapKit
import Alamofire

class EventAddViewModel: ObservableObject {
    
    // private var model: Model
    private var isLocationTrackingEnabled: Bool = false // Model 인스턴스를 저장하는 프로퍼티 추가
    @Published var annotations: [MKPointAnnotation] = []
    @Published var typeChangeLocation: CLLocation?
    
    //알럿
    @Published var isShowingAlert: Bool = false
    @Published var errorMessage: String = ""
    
    //view에서 사용하는 searchData
    @Published var catSearchListData=[Cats]()
    //Cats전체데이터
    @Published var allCatSearchListData:[Cats]=[]
    @Published var tempCatSearchListData:[Cats]=[]
    
    
    @Published var isSearchEnd:Bool=false
    @Published var eventCat: Results<CareRealmModel>?
    var selectedIndex:Int?
    // init(model: Model) {  // 생성자에서 Model 인스턴스 주입
    //     self.model = model
    //     isLocationTrackingEnabled = model.isLocationTrackingEnabled
    //     print("Where - Event Add ViewModel 초기 isLocationTrackingEnabled: \(model.isLocationTrackingEnabled)")
    //     
    // }
    
    func filteredCats(_ query: String) -> [Cats] {
        let lowercasedQuery = query.lowercased()
        
        return catSearchListData.filter({
            $0.name.lowercased().contains(lowercasedQuery)
        })
    }
    //고양이 검색 API 후 필터 2
    func catsFilterSearch(_ temTxsearch:String){
        print("고양이 검색어 tempTx: \(temTxsearch)")
        
        self.tempCatSearchListData.removeAll()
        var isSearchResultEmpty = true
        
        for catsData in self.allCatSearchListData {
            if catsData.name == temTxsearch {
                self.catSearchListData.append(catsData)
                print("고양이 검색어 catSearchListData : \(self.catSearchListData)")
                isSearchResultEmpty = false
            }
        }
        if isSearchResultEmpty {
            isShowingAlert = true
            errorMessage = "등록된 고양이가 없습니다"
        }
        self.isSearchEnd = true
    }
    
    
    //고양이 전체 찾은후 검색한 이름으로 비교후 값 내보기
    func catsSearch(_ temTx:String) {
        AF.request(CAT_SELECT_API_URL, method: .post).responseDecodable(of: [Cats].self) { response in
            switch response.result {
            case .success(let value):
                print("성공 디코딩 : \(value)")
                self.allCatSearchListData = value
                self.catsFilterSearch(temTx)
            case .failure(let error):
                print("실패 디코딩 : \(error.localizedDescription)")
            }
        }
    }
    
    //고양이 이름 검색 API
    func catsNameSearchAPI(_ searchWord:String) {
        // var searchName = $text
        
        print("고양이 검색어가 알려줘 : \(searchWord)")
        let parameters: [String:Any] = [
            "findName" : searchWord,
        ]
        
        AF.request(CAT_SELECT_API_URL, method: .post, parameters: parameters)
            .responseDecodable(of: [Cats].self) { response in
                switch response.result {
                case .success(let value):
                    if value.isEmpty {
                        self.catSearchListData.removeAll()
                    } else {
                        print("0-------- catsNameSearchAPI 성공 디코딩 : \(value)")
                        self.catSearchListData.removeAll()
                        print("0-------- catsNameSearchAPI 성공 디코딩 리스트값!!!! : \( self.catSearchListData)")
                        self.catSearchListData = value
                        
                        // catsFilterSearch()
                    }
                case .failure(let error):
                    print("catsNameSearchAPI 실패 디코딩 : \(error.localizedDescription)")
                }
            }
    }
    
    
    //CLLocationCoordinate2D -> CLLocation 변경
    func updateLocation(latitude: Double, longitude: Double) {
        let newLocation = CLLocation(latitude: latitude, longitude: longitude)
        typeChangeLocation = newLocation
    }
    
    
    func notRuningCatWalkEventAdd(state: String, user_id: String, cat_id: String, memo: String, address: String, date: Date,coordinates:[Double]) {
        
        let event = UserDefaults.standard.string(forKey: "selectedEvent") ?? ""
        let selectedEventNum = tranferEventIndex(event: event)
        print("이벤트 선택: \(String(describing: selectedEventNum))")
        
        let catId = UserDefaults.standard.string(forKey: "CatId") ?? ""
        print("선택 냥이 가제 : \(catId)")
        let idFromSavedData = catId
        print("test cat idFromSavedData : \(idFromSavedData)")
        
        guard let userId = AuthViewModel.shared.currentUser?.uid else {return}
        if !readLocationUserDefaults() {
            let jsonData = [
                // "_id": generateUUID(),
                "visible": 0,
                "event": selectedEventNum,
                "user_uuid":userId,
                "cat_uuid":idFromSavedData,
                "view_count":0,
                "save_count":0,
                "care_count":0,
                "address": "우리집",
                "coordinates": [0.0,0.0],
                "status":0,
            ] as [String : Any] // 데이터를 JSON 형식으로 준비
            
            AF.request(CARE_CAT_ADD_API_URL, method: .post, parameters: jsonData, encoding: JSONEncoding.default)
                .responseDecodable(of: EventCat.self) { response in
                    switch response.result {
                    case .success(let value) :
                        print("POST DEBUG not running: \(value)")
                    case .failure(let error) :
                        print("not runging 인서트 에러 : \(error.localizedDescription)")
                    }
                }
        }
    }
    
    
    func tranferEventIndex(event: String) -> Int? {
        var selectedIndex: Int?
        switch event {
        case "feeding" :
            selectedIndex = 0
        case "found":
            selectedIndex = 1
        case "greeting":
            selectedIndex = 2
        case "pain":
            selectedIndex = 3
        case "play":
            selectedIndex = 4
        case "play2":
            selectedIndex = 5
            
        default:
            selectedIndex = nil
        }
        return selectedIndex
    }
    
    func isRuningCatWalkEventAdd(state: String, user_id: String, cat_id: String, memo: String, coordinates: [Double], address: String,completeAction:Bool) {
        
        let event = UserDefaults.standard.string(forKey: "selectedEvent") ?? ""
        let selectedEventNum = tranferEventIndex(event: event)
        
        
        let catId = UserDefaults.standard.string(forKey: "CatId") ?? ""
        print("선택 냥이 가제 : \(catId)")
        let idFromSavedData = catId
        print("test cat idFromSavedData : \(idFromSavedData)")
        
        guard let userId = AuthViewModel.shared.currentUser?.uid else {return}
        
        
        if readLocationUserDefaults() {
            let jsonData = [
                // "_id": generateUUID(),
                "visible": 0,
                "event": selectedEventNum,
                "user_uuid":userId,
                "cat_uuid":idFromSavedData,
                "view_count":0,
                "save_count":0,
                "care_count":0,
                "address": "우리집",
                "coordinates": coordinates,
                "status":0,
            ] as [String : Any] // 데이터를 JSON 형식으로 준비
            
            AF.request(CARE_CAT_ADD_API_URL, method: .post, parameters: jsonData, encoding: JSONEncoding.default)
                .responseDecodable(of: EventCat.self) { response in
                    switch response.result {
                    case .success(let value) :
                        print("POST DEBUG running: \(value)")
                    case .failure(let error) :
                        print("runging 인서트 에러 : \(error.localizedDescription)")
                    }
                }
        }
    }
    
    //트랙킹 하고 있는 동안 이벤트 남기기
    func isRunningCatWalk(latitude: Double, logtitude: Double, state: String, user_id: String, cat_id: String, memo: String, coordinate: String, address: String, date: Date){
        
        
        print("++> isRunningCatWalk 이벤트 에서 트랙킹에 넣을 값 확인 : \(latitude)")
        updateTrackingObject(latitude: latitude, logtitude: logtitude)
        updateLocation(latitude: latitude, longitude: logtitude)
        
        let user = AuthViewModel.shared.currentUser?.id ?? ""
        let sessionId = UserDefaults.standard.string(forKey: "User") ?? ""
        // guard let currentUserId = AuthViewModel.shared.currentUser?.id else { return }
        print("현재 user: \(sessionId)")
        
        //고양이 아이디외의 모든 정보 리스트로 담기
        let catId = UserDefaults.standard.string(forKey: "CatId") ?? ""
        print("선택 냥이 가제 : \(catId)")
        
        
        
        
        
        if readLocationUserDefaults() {
            //고양이 데이터 선택했을 경우
            if let jsonData = UserDefaults.standard.data(forKey: "catsData") {
                do {
                    // Decode the JSON data into a Cat object
                    let decoder = JSONDecoder()
                    let cat = try decoder.decode(Cats.self, from: jsonData)
                    print("test cat : \(cat)")
                    
                    
                    
                    let catId = UserDefaults.standard.string(forKey: "CatId") ?? ""
                    print("선택 냥이 가제 : \(catId)")
                    let idFromSavedData = cat.id
                    print("test cat idFromSavedData : \(cat.id)")
                    
                    guard let userId = AuthViewModel.shared.currentUser?.uid else {return}
                    
                    let jsonData = [
                        // "_id": generateUUID(),
                        "visible": 0,
                        "event": 3,
                        "user_uuid":userId,
                        "cat_uuid":idFromSavedData,
                        "view_count":0,
                        "save_count":0,
                        "care_count":0,
                        "address": "우리집",
                        "latitude": latitude,
                        "longitude": logtitude,
                        "status":0,
                    ] as [String : Any] // 데이터를 JSON 형식으로 준비
                    
                    AF.request(CARE_CAT_ADD_API_URL, method: .post, parameters: jsonData, encoding: JSONEncoding.default)
                        .responseDecodable(of: EventCat.self) { response in
                            switch response.result {
                            case .success(let value) :
                                print("POST DEBUG not running: \(value)")
                            case .failure(let error) :
                                print("runging 인서트 에러 : \(error.localizedDescription)")
                            }
                        }
                    
                    // realmCareModel()
                } catch {
                    
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
    
    
    func isRunningRealmCareModel() {
        // do {
        //     // Decode the JSON data into a Cat object
        //     let decoder = JSONDecoder()
        //     let cat = try decoder.decode(Cat.self, from: jsonData)
        //
        //     // Extract the 'id' value and store it in a variable
        //     let idFromSavedData = cat.id
        //
        //     //이벤트 등록
        //     // CareRealmModel 객체 생성 및 데이터 등록
        //     let careModel = CareRealmModel()
        //     careModel.state = state
        //     careModel.user_id = sessionId
        //     careModel.cat_id = idFromSavedData
        //     careModel.memo = memo
        //     careModel.coordinate = "Coordinates"
        //     careModel.address = "Address"
        //     careModel.latitude = latitude
        //     careModel.longitude = logtitude
        //     careModel.date = Date() // 현재 날짜를 설정
        //
        //
        //     // do {
        //     //     RealmHelper.shared.create(careModel)
        //     //     print("realm기록하였음 트래킹 있음: Latitude: \(latitude), Longitude: \(logtitude)")
        //     // } catch {
        //     //     print("Error saving data: \(error)")
        //     // }
        //     loadEventAddCat()
        //     // Now, 'idFromSavedData' contains the 'id' value from the saved data
        //     print("Loaded 'id' from saved data: \(idFromSavedData)")
        // } catch {
        //     print("Error decoding JSON: \(error)")
        // }
        
    }
    
    func createTrackingObject(latitude: Double, logtitude: Double){
        
        print("++> 업데이트 트래킹 : \(latitude) ,")
        let tracking = Tracking()
        
        if let typeChangeLocation {
            // Tracking 객체의 속성 설정
            tracking.arrival_time = Date().description
            tracking.departure_time = Date().description
            tracking.departure_point = typeChangeLocation.coordinate.latitude.description + ", " + typeChangeLocation.coordinate.longitude.description
            tracking.destination_point = ""
            tracking.track_time = ""
            tracking.route = ""
            tracking.distance = ""
            tracking.timestamp = Date().description
            tracking.user = ""
            tracking.arrival_address = typeChangeLocation.coordinate.latitude.description + ", " + typeChangeLocation.coordinate.longitude.description
            tracking.departure_address = "departureAddress"
            tracking.event_latitude = latitude
            tracking.event_longitude = logtitude
            tracking.event_time = "eventTime"
            tracking.event_address = "eventAddress"
            tracking.event_cat = "eventCat"
            
            RealmHelper.shared.create(tracking)
            let track =  RealmHelper.shared.read(Tracking.self)
            
            //test
            for aa in track {
                print("++> 트랙킹 이벤트를 추가 저장한값 : \(aa.event_latitude)")
            }
        }
        
    }
    
    func updateTrackingObject(latitude: Double, logtitude: Double){
        
        print("++> 업데이트 트래킹 : \(latitude) ,")
        let tracking = Tracking()
        
        if let typeChangeLocation {
            // Tracking 객체의 속성 설정
            tracking.arrival_time = Date().description
            tracking.departure_time = Date().description
            tracking.departure_point = typeChangeLocation.coordinate.latitude.description + ", " + typeChangeLocation.coordinate.longitude.description
            tracking.destination_point = ""
            tracking.track_time = ""
            tracking.route = ""
            tracking.distance = ""
            tracking.timestamp = Date().description
            tracking.user = ""
            tracking.arrival_address = typeChangeLocation.coordinate.latitude.description + ", " + typeChangeLocation.coordinate.longitude.description
            tracking.departure_address = "departureAddress"
            tracking.event_latitude = latitude
            tracking.event_longitude = logtitude
            tracking.event_time = "eventTime"
            tracking.event_address = "eventAddress"
            tracking.event_cat = "eventCat"
            
            RealmHelper.shared.create(tracking)
            let track =  RealmHelper.shared.read(Tracking.self)
            
            //test
            for aa in track {
                print("++> 트랙킹 이벤트를 추가 저장한값 : \(aa.event_latitude)")
            }
        }
        
    }
    
    func isNotRuningCatWalk(state: String, user_id: String, cat_id: String, memo: String, coordinate: String, address: String, date: Date) {
        let sessionId = UserDefaults.standard.string(forKey: "User") ?? ""
        // guard let currentUserId = AuthViewModel.shared.currentUser?.id else { return }
        print("현재 user: \(sessionId)")
        
        // 고양이 아이디외의 모든 정보 리스트로 담기
        let catId = UserDefaults.standard.string(forKey: "CatId") ?? ""
        print("선택 냥이 가제 : \(catId)")
        
        if !readLocationUserDefaults() {
            // notRunningRealmEvent()
            if let jsonData = UserDefaults.standard.data(forKey: "catsData") {
                do {
                    // Decode the JSON data into a Cat object
                    let decoder = JSONDecoder()
                    let cat = try? decoder.decode(Cats.self, from: jsonData)
                    
                    // Extract the 'id' value and store it in a variable
                    guard let idFromSavedData = cat?.id else {return}
                    
                    guard let userId = AuthViewModel.shared.currentUser?.uid else {return}
                    let jsonData = [
                        // "_id": generateUUID(),
                        "visible": 0,
                        "event": 3,
                        "user_uuid":userId,
                        "cat_uuid":idFromSavedData,
                        "view_count":0,
                        "save_count":0,
                        "care_count":0,
                        "address": "우리집",
                        "latitude": "",
                        "longitude": "",
                        "status":0,
                    ] as [String : Any] // 데이터를 JSON 형식으로 준비
                    
                    AF.request(CARE_CAT_ADD_API_URL, method: .post, parameters: jsonData, encoding: JSONEncoding.default)
                        .responseDecodable(of: EventCat.self) { response in
                            switch response.result {
                            case .success(let value) :
                                print("POST DEBUG not running: \(value)")
                            case .failure(let error) :
                                print("not runging 인서트 에러 : \(error.localizedDescription)")
                                
                            }
                        }
                    
                    
                    //         //이벤트 등록
                    //         // CareRealmModel 객체 생성 및 데이터 등록
                    //         // let careModel = CareRealmModel()
                    //         // careModel.state = state
                    //         // careModel.user_id = sessionId
                    //         // careModel.cat_id = idFromSavedData
                    //         // careModel.memo = memo
                    //         // careModel.coordinate = "Coordinates"
                    //         // careModel.address = "Address"
                    //         // careModel.latitude = 0.0
                    //         // careModel.longitude = 0.0
                    //         // careModel.date = Date() // 현재 날짜를 설정
                    //         //
                    //
                    //         // do {
                    //         //     RealmHelper.shared.create(careModel)
                    //         //
                    //         //     print("realm기록하였음 트래킹 없음: Latitude: \(careModel.latitude), Longitude: \(careModel.longitude)")
                    //         // } catch {
                    //         //     print("Error saving data: \(error)")
                    //         // }
                    //         loadEventAddCat()
                    //         // Now, 'idFromSavedData' contains the 'id' value from the saved data
                    //         print("Loaded 'id' from saved data: \(idFromSavedData)")
                    //     } catch {
                    //         print("Error decoding JSON: \(error)")
                    //     }
                    // } else {
                    //     print("No JSON data found in UserDefaults.")
                    // }
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
                    
                    
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else {
                print("No JSON data found in UserDefaults.")
            }
        }
    }
    
    func notRunningRealmEvent() {
        // if let jsonData = UserDefaults.standard.data(forKey: "catsData") {
        //     do {
        //         // Decode the JSON data into a Cat object
        //         let decoder = JSONDecoder()
        //         let cat = try decoder.decode(Cats.self, from: jsonData)
        //
        //         // Extract the 'id' value and store it in a variable
        //         let idFromSavedData = cat.id
        //
        //         //이벤트 등록
        //         // CareRealmModel 객체 생성 및 데이터 등록
        //         // let careModel = CareRealmModel()
        //         // careModel.state = state
        //         // careModel.user_id = sessionId
        //         // careModel.cat_id = idFromSavedData
        //         // careModel.memo = memo
        //         // careModel.coordinate = "Coordinates"
        //         // careModel.address = "Address"
        //         // careModel.latitude = 0.0
        //         // careModel.longitude = 0.0
        //         // careModel.date = Date() // 현재 날짜를 설정
        //         //
        //
        //         // do {
        //         //     RealmHelper.shared.create(careModel)
        //         //
        //         //     print("realm기록하였음 트래킹 없음: Latitude: \(careModel.latitude), Longitude: \(careModel.longitude)")
        //         // } catch {
        //         //     print("Error saving data: \(error)")
        //         // }
        //         loadEventAddCat()
        //         // Now, 'idFromSavedData' contains the 'id' value from the saved data
        //         print("Loaded 'id' from saved data: \(idFromSavedData)")
        //     } catch {
        //         print("Error decoding JSON: \(error)")
        //     }
        // } else {
        //     print("No JSON data found in UserDefaults.")
        // }
    }
    
    func eventAddCat(state: String, user_id: String, cat_id: String, memo: String, coordinate: String, address: String, date: Date) {
        
        let sessionId = UserDefaults.standard.string(forKey: "User") ?? ""
        // guard let currentUserId = AuthViewModel.shared.currentUser?.id else { return }
        print("현재 user: \(sessionId)")
        
        // 고양이 아이디외의 모든 정보 리스트로 담기
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
                    // loadEventAddCat()
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


