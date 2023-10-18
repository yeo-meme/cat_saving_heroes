//
//  Global.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/16.
//

import Foundation
import SwiftUI
import RealmSwift

let presentSideMenu = false
// @State static var presentSideMenu = false
// @Binding static var PRESENT_SIDE_MENU = false


func realmMigration() {
    let config = Realm.Configuration(
        schemaVersion: 0, // 스키마 버전을 0으로 설정
        deleteRealmIfMigrationNeeded: true // 마이그레이션이 필요한 경우 Realm 삭제
    )
    Realm.Configuration.defaultConfiguration = config
}
