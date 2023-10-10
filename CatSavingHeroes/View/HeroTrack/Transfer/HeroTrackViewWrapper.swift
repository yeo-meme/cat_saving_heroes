//
//  HeroTrackViewWrapper.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/10.
//

import SwiftUI
import UIKit
import Charts
import MapKit

//Uikit을 변형해주는 코드
struct HeroTrackViewWrapper: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: TrackingViewController, context: Context) {
        
    }

    func makeUIViewController(context: Context) -> TrackingViewController {
        let trackingViewController = TrackingViewController()
        return trackingViewController
    }
}
// 
struct HeroTrackView: View {

    var body: some View {
        NavigationView {
           
            VStack {
                HeroTrackViewWrapper()
                    
            }
                .navigationBarTitle("Hero Track")
        }
    }
}
// 
