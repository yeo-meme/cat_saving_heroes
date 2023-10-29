//
//  HeroCalendarViewWrapper.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/10.
//

import SwiftUI
import UIKit
import Charts

//Uikit을 변형해주는 코드
struct HeroCalendarViewWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> HeroCalendarViewController {
        return HeroCalendarViewController()
    }

    func updateUIViewController(_ uiViewController: HeroCalendarViewController, context: Context) {
        // Update the view controller if needed
    }
}

struct HeroCalendarView: View {
    var body: some View {
        NavigationView {
            ScrollView{
                ChartView()
                HeroCalendarViewWrapper()
                    .navigationBarTitle("Hero Calendar")
            }
        }
        
    }
}
