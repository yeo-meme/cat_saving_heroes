//
//  CatSavingHeroesApp.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/05.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore



@main
struct CatSavingHeroesApp: App {
    // @StateObject private var locationManager = AddressManager()
    @StateObject private var addressManager = Model(userLocation: .constant(nil), locations: .constant([])) // 환경 객체
    // @StateObject private var locationManager = Model() // 환경 객체
    
    init() {
        FirebaseApp.configure()
        let db = Firestore.firestore()
    }
   
    var body: some Scene {
        
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
                .environmentObject(AddressManager.shared) // 환경 객체 공유
                .environmentObject(addressManager)
        }
    }
}
