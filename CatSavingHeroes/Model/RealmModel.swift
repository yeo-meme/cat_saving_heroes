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


class Tracking: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var arrival_time: String = "" //도착시간
    @Persisted var departure_time: String = "" //출발시간
    @Persisted var departure_point: String = "" //출발지점 coodinate
    @Persisted var destination_point: String = "" //목적지점 coodinate
    @Persisted var track_time: String = "" //루트한 시간
    @Persisted var route: String = ""
    @Persisted var distance: String = "" //거리
    @Persisted var timestamp: String = "" //
    @Persisted var user: String = ""
    @Persisted var arrival_address: String = "" //출발 한글주소
    @Persisted var departure_address: String = "" //도착 한글주소
    @Persisted var event_latitude: Double = 0.0 //
    @Persisted var event_longitude: Double  = 0.0  //
    @Persisted var event_time: String = "" //
    @Persisted var event_address: String = "" //
    @Persisted var event_cat: String = "" //이벤트 캣
}

class EventsCat: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var tracking_id: String = ""
    @Persisted var event_cat: String = "" //이벤트 캣
    //추가 예정
}



class CareRealmModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var state: String = ""
    @Persisted var user_id: String = ""
    @Persisted var cat_id: String = ""
    @Persisted var memo: String = ""
    @Persisted var coordinate: String = ""
    @Persisted var address: String = ""
    @Persisted var latitude:Double = 0.0
    @Persisted var longitude:Double = 0.0
    @Persisted var date:Date?
}
