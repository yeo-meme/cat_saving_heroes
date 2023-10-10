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
    @StateObject private var locationManager = Model(userLocation: .constant(nil), locations: .constant([])) // 환경 객체
    // @StateObject private var locationManager = Model() // 환경 객체
    
    init() {
        FirebaseApp.configure()
        let db = Firestore.firestore()
     
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
                .environmentObject(locationManager) // 환경 객체 공유
        }
    }
}
