//
//  ChartView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/30.
//

import SwiftUI
import Charts

struct ChartView: View {
    let data = [
        (name: "Cachapa", sales: 9631),
        (name: "Crêpe", sales: 6959),
        (name: "Injera", sales: 4891),
        (name: "Jian Bing", sales: 2506),
        (name: "American", sales: 1777),
        (name: "Dosa", sales: 625),
    ]
    var body: some View {
        if #available(iOS 17.0, *) {
            Chart(data, id: \.name) { name, sales in
                SectorMark(angle: .value("Value", sales))
                    .foregroundStyle(by: .value("Product category", name))
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

#Preview {
    ChartView()
}
