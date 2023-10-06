//
//  HeroCalendarView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/06.
//

import SwiftUI
import UIKit

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
            HeroCalendarViewWrapper()
                .navigationBarTitle("Hero Calendar")
        }
    }
}

#Preview {
    HeroCalendarView()
}
