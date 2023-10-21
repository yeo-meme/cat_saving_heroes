//
//  CustomDivider.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/21.
//

import SwiftUI

struct CustomDivider: View {
    let leadingSpace: CGFloat
    
    var body: some View {
        Divider()
            .background(Color(.systemGray6))
            .padding(.leading, leadingSpace)
    }
}

// #Preview {
//     CustomDivider()
// }
