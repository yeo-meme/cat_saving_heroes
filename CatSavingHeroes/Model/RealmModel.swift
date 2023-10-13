//
//  RealmModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/11.
//

import Foundation
import RealmSwift

// 고양이 데이터 모델
class CatRealmModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String = ""
    @Persisted var age: String = ""
    @Persisted var address: String = ""
    @Persisted var gender: String = ""
    @Persisted var memo: String = ""
    @Persisted var profileImage: String = ""
}



class CareRealmModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var state: String = ""
    @Persisted var user_id: String = ""
    @Persisted var cat_id: String = ""
    @Persisted var memo: String = ""
    @Persisted var coordinate: String = ""
    @Persisted var address: String = ""
    @Persisted var date:Date?
}
