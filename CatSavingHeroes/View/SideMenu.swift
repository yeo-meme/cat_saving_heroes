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
    var edgeTransition: AnyTransition = .move(edge: .trailing)
    
    var body: some View {
        
        GeometryReader { geometry in
        ZStack(alignment: .bottom) {
                if (isShowing) {
                    Color.black
                        .opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            isShowing.toggle()
                        }
                    content
                        .frame(maxWidth: geometry.size.width)
                        .offset(x: isShowing ? geometry.size.width/3 : 0)
                        .disabled(isShowing ? true : false)
                        .transition(edgeTransition)
                        .background(
                            Color.clear
                        )
                }
                   
            }
        }
    }
}

