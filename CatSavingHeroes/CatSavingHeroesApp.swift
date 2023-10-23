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
    @StateObject private var eventAddViewModel = EventAddViewModel(model: Model(userLocation: .constant(nil), locations: .constant([]))) // Model 인스턴스 생성 및 주입
    
    
    init() {
        FirebaseApp.configure()
        let db = Firestore.firestore()
    }
   
    var body: some Scene {
        
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
                .environmentObject(AddressManager.shared) // 환경 객체 공유
                .environmentObject(addressManager)
                .environmentObject(eventAddViewModel) // EventAddViewModel 환경 객체 주입
        }
    }
}
