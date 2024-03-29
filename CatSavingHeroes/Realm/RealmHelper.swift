//
//  RealmHelper.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/10.
//

import Foundation
import RealmSwift
import UIKit

class RealmHelper {
    
    private init() {}
    static let shared = RealmHelper()
    var realm = try! Realm()
    var arrResults = [CatRealmModel]()
    
    
    func create<T:Object>(_ object:T){
        do{
            try realm.write {
                realm.add(object)
            }
        }catch{
            print("realm create error: \(error)")
        }
    }
    
    func delete<T:Object>(_ object:T){
        do{
            try realm.write {
                realm.delete(object)
            }
        }catch{
            print("realm delete Error: \(error)")
        }
    }
    
    func read<T:Object>(_ type: T.Type) -> [T] {
        
        do {
            let results = realm.objects(type)
            // Realm 데이터베이스에서 해당 타입의 모든 데이터를 가져옴
            
            return Array(results) // 결과를 배열로 변환하여 반환
        } catch {
            // 오류 처리: Realm 데이터베이스 연결 오류 등
            print("Error reading data from Realm: \(error)")
            return [] // 오류 시 빈 배열을 반환하거나 다른 오류 처리 방법을 사용할 수 있음
        }
    }
    
    func readCats(withName name: String) -> [CatRealmModel] {
        do {
            let results = realm.objects(CatRealmModel.self).filter("name CONTAINS[c] %@", name)
            // "name CONTAINS[c] %@"는 고양이 이름에 name 문자열이 포함된 결과를 반환합니다.
            // [c] 옵션은 대소문자를 구분하지 않고 검색합니다.
            
            return Array(results)
        } catch {
            print("Error reading cats from Realm: \(error)")
            return []
        }
    }
    
    func getCatByUserId(userId: String) -> [CatRealmModel] {
        do {
        
            let results = realm.objects(CatRealmModel.self)
            for userCat in results {
                print("userId getCatByUserId : \(userCat.user_id)")
                if userCat.user_id == userId {
                    print("같은 아이디 : \(userCat)")
                    arrResults.append(userCat)
                }
            }
            return arrResults // 결과를 배열로 변환하여 반환
        } catch {
            // 오류 처리: Realm 데이터베이스 연결 오류 등
            print("Error reading data from Realm: \(error)")
            return [] // 오류 시 빈 배열을 반환하거나 다른 오류 처리 방법을 사용할 수 있음
        }
        
    }
    
}
