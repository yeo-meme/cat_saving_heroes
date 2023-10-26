//
//  EventCat.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/25.
//

import Foundation


class EventCat : Identifiable, Codable {
    var id: String?
    var visible:Int//0 공개,1 비공개
    var event:Int
    var user_uuid:String
    var cat_uuid:String
    var view_count:Int //고양이 보는냥 카운트수
    var save_count:Int
    var care_count:Int
    var address:String //위도 경도 이벤트발생
    var latitude:String
    var longitude:String
    // var location:String //한글 주소
    var status:Int
}
