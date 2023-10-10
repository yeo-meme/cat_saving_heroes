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
    func makeUIViewController(context: Context) -> TrackingViewController {
        return TrackingViewController()
    }

    func updateUIViewController(_ uiViewController: TrackingViewController, context: Context) {
        // Update the view controller if needed
    }
}

struct HeroTrackView: View {
    var body: some View {
        NavigationView {
           
            HeroTrackViewWrapper()
                .navigationBarTitle("Hero Track")
        }
    }
}

