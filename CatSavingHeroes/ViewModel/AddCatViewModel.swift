//
//  AddCatViewModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/11.
//

import Foundation
import RealmSwift



// 고양이 데이터 모델
// class Cat: Object {
//     @Persisted(primaryKey: true) var id: ObjectId
//     @Persisted var name: String = ""
//     @Persisted var age: String = ""
//     @Persisted var address: String = ""
//     @Persisted var gender: String = ""
//     @Persisted var memo: String = ""
// }

class AddCatViewModel: ObservableObject {
    @Published var cats: Results<CatRealmModel>?
    @Published var catId:String = ""
    var catArr: [Cat] = []
    var preUserId: String {
        return AuthViewModel.shared.currentUser?.uid ?? ""
    }
    
    static let shared = AddCatViewModel()
    init() {
        do {
            
            // let realm = try Realm()
            // try! realm.write {
            //     realm.delete(realm.objects(Cat.self))
            // }
            
            // Realm 데이터베이스 객체 생성
            // let config = Realm.Configuration(schemaVersion: 2) // 버전 번호를 새로운 숫자로 업데이트
            // let realm = try! Realm(configuration: config)

            // Cat 모델의 모든 객체 삭제
            // try! realm.write {
            //     realm.delete(realm.objects(Cat.self))
            // }
            // cats = realm.objects(Cat.self)
            // let config = Realm.Configuration()

            // if let currentSchemaVersion = config.schemaVersion {
            //     print("Current Realm Schema Version: \(currentSchemaVersion)")
            // } else {
            //     print("Realm Configuration does not have a schema version.")
            // }
        
            // let config = Realm.Configuration(
            //     schemaVersion: 0, // 스키마 버전을 0으로 설정
            //     deleteRealmIfMigrationNeeded: true // 마이그레이션이 필요한 경우 Realm 삭제
            // )
            // Realm.Configuration.defaultConfiguration = config
            // 
            let realm = try Realm()
            cats = realm.objects(CatRealmModel.self)
      
        } catch {
            print("Error initializing Realm: \(error)")
        }
    }
    
    func saveCat(name: String, age: String, address: String, gender: String, memo: String,profileImage:String) {
        do {
            
            //마이그레이션 초기화
            // let config = Realm.Configuration(
            //      schemaVersion: 0, // 스키마 버전을 0으로 설정
            //       deleteRealmIfMigrationNeeded: true // 마이그레이션이 필요한 경우 Realm 삭제
            //      )
            // Realm.Configuration.defaultConfiguration = config
            
            let realm = try Realm()
            try realm.write {
                let cat = CatRealmModel()
                cat.name = name
                cat.age = age
                cat.address = address
                cat.gender = gender
                cat.memo = memo
                cat.profileImage = profileImage
                realm.add(cat)
                
                print("고양이 데이터 \(cat.name)")
            }
        } catch {
            print("Error saving cat: \(error)")
        }
    }
    // 다시 불러오는 함수 Addcat 하고 데이터 확인
    func loadCats() {
        do {
            let realm = RealmHelper.shared.realm
            cats = realm.objects(CatRealmModel.self)
            print("Loaded \(cats?.count ?? 0) cats:")
                      
            cats?.forEach { cat in
                         
                           let id = cat.id.stringValue
                           let name = cat.name
                           let age = cat.age
                           let address = cat.address
                           let gender = cat.gender
                           let memo = cat.memo
                           let profileImage = cat.profileImage
                           print("Name: \(cat.name)")
                           print("Age: \(cat.age)")
                           print("Address: \(cat.address)")
                           print("Gender: \(cat.gender)")
                           print("Memo: \(cat.memo)")
                           print("Id: \(cat.id)")
                           print("profileImage: \(cat.profileImage)")
                           print("----")
                           
                           
                           
                           // Create an array of Cat objects
                               // Populate the array with Cat objects
                            let catString = Cat(id: id, name: name , age: age, address: address, gender: gender, memo: memo, profileImage: profileImage)
                             
                           
                //로드할때 UserDefaults에 저장하고 
                           do {
                               // Use JSONEncoder to encode the array of Cat objects to JSON data
                               let encoder = JSONEncoder()
                               encoder.outputFormatting = .prettyPrinted // Optional for pretty-printed JSON
                               let jsonData = try encoder.encode(catString)
                               
                               if let jsonString = String(data: jsonData, encoding: .utf8) {
                                   // Print the JSON string
                                   print(jsonString)
                                   
                                   // Save the JSON data to UserDefaults
                                   UserDefaults.standard.set(jsonData, forKey: "catsData")
                                   print("JSON data saved to UserDefaults")
                               }
                           } catch {
                               print("Error encoding JSON: \(error)")
                           }

                           
                           // Cat: Identifiable 구조의 인스턴스를 UserDefaults에 저장합니다.
                           // let userDefaults = UserDefaults.standard
                           // let cat = Cat(id: id, name: name, age: age, address: address, gender: gender, memo: memo, profileImage: "")
                           
                           // Cat 구조체를 Property List 객체로 변환합니다.
                           // let catData = try PropertyListEncoder().encode(cat)
                           // Property List 객체를 UserDefaults에 저장합니다.
                             // userDefaults.set(catData, forKey: "Cat")
                           
                           // userDefaults.set(cat, forKey: "Cat")
                           print("cat Id stringValue: \(id)")
                           UserDefaults.standard.set(id, forKey: "CatId")
                         
                       }
            // self.cats=catArr
        } catch {
            print("Error loading cats: \(error)")
        }
    }
    
    
    func catImageUpload(_ image: UIImage, completion: @escaping(Bool,String?) -> Void) {
        
        ImageUploader.uploadImage(image: image, folderName: FOLDER_CAT_IMAGES, uid: preUserId) { imageUrl in
            let data: [String: Any] = [KEY_CAT_IMAGE_URL : imageUrl]
            
            print("data : \(data)")
            COLLECTION_CAT_PROFILE.addDocument(data: data) { error in
                if let errorMessage = error?.localizedDescription {
                    // self.showErrorAlert = true
                    // self.errorMessage = errorMessage
                    // print("errror \(errorMessage)")
                    // completion(false)
                    return
                }
            }
            completion(true, imageUrl)
            
            // self.currentUser?.profileImageUrl = imageUrl
            // self.userSession = Auth.auth().currentUser
            // self.fetchUser()
        }
    }
    
}
