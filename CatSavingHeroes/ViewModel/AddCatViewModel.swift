//
//  AddCatViewModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/11.
//

import Foundation
import RealmSwift



// 고양이 데이터 모델
class Cat: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String = ""
    @Persisted var age: String = ""
    @Persisted var address: String = ""
    @Persisted var gender: String = ""
    @Persisted var memo: String = ""
}

class AddCatViewModel: ObservableObject {
    @Published var cats: Results<Cat>?
    
    var preUserId: String {
        return AuthViewModel.shared.currentUser?.uid ?? ""
    }
    
    init() {
        do {
            // Realm 데이터베이스 객체 생성
            let config = Realm.Configuration(schemaVersion: 2) // 버전 번호를 새로운 숫자로 업데이트
            let realm = try! Realm(configuration: config)

            // Cat 모델의 모든 객체 삭제
            // try! realm.write {
            //     realm.delete(realm.objects(Cat.self))
            // }
            cats = realm.objects(Cat.self)
        } catch {
            print("Error initializing Realm: \(error)")
        }
    }
    
    func saveCat(name: String, age: String, address: String, gender: String, memo: String) {
        do {
            let realm = try Realm()
            try realm.write {
                let cat = Cat()
                cat.name = name
                cat.age = age
                cat.address = address
                cat.gender = gender
                cat.memo = memo
                realm.add(cat)
            }
        } catch {
            print("Error saving cat: \(error)")
        }
    }
    // 다시 불러오는 함수
    func loadCats() {
        do {
            let realm = try Realm()
            cats = realm.objects(Cat.self)
            print("Loaded \(cats?.count ?? 0) cats:")
                       cats?.forEach { cat in
                           print("Name: \(cat.name)")
                           print("Age: \(cat.age)")
                           print("Address: \(cat.address)")
                           print("Gender: \(cat.gender)")
                           print("Memo: \(cat.memo)")
                           print("----")
                       }
        } catch {
            print("Error loading cats: \(error)")
        }
    }
    
    
    func catImageUpload(_ image: UIImage, completion: @escaping(Bool) -> Void) {
        
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
            
            // self.currentUser?.profileImageUrl = imageUrl
            // self.userSession = Auth.auth().currentUser
            // self.fetchUser()
        }
    }
    
}
