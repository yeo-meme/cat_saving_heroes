//
//  SideMenu.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/05.
//

import SwiftUI

struct SideMenu: View {
    @Binding var isShowing: Bool
    var content: AnyView
    var edgeTransition: AnyTransition = .move(edge: .leading)
    
    var body: some View {
        // GeometryReader { geometry in // 오른쪽 옵션
        ZStack(alignment: .bottom) {
                if (isShowing) {
                    Color.black
                        .opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            isShowing.toggle()
                        }
                    content
                        // .frame(maxWidth: geometry.size.width) // 오른쪽 옵션
                        // .offset(x: isShowing ? geometry.size.width/3 : 0)
                        // .disabled(isShowing ? true : false)
                        .transition(edgeTransition)
                        .background(
                            Color.clear
                        )
                }
            // }
  
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
            .animation(.easeInOut, value: isShowing)
     
    }
}

