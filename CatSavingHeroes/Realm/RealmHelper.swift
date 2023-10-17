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

    //
    var realm = try! Realm()
    
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
}
