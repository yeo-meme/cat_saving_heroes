//
//  CatSavingHeroesApp.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/05.
//

import SwiftUI
import Firebase
import FirebaseCore


@main
struct CatSavingHeroesApp: App {
    
    init() {
        FirebaseApp.configure()
        let db = Firestore.firestore()
        // UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        //          if granted {
        //              print("사용자가 알림 권한을 허용했습니다.")
        //          } else if let error = error {
        //              print("알림 권한 요청 중 오류 발생: \(error.localizedDescription)")
        //          }
        //      }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
        }
    }
}
