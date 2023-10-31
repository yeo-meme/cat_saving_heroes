//
//  StatusCell.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/31.
//

import SwiftUI

struct StatusCell: View {
    let status: Status
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 1) {
            HStack {
                Text(status.title)
                    .foregroundColor(.black)
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark")
                }
            }
            .padding()
            
            CustomDivider(leadingSpace: 16)
        }
        .background(Color.white)
    }
}
