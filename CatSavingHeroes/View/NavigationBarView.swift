//
//  NavigationBarView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/19.
//

import SwiftUI

struct NavigationBarView: View {
  // MARK: - PROPERTY
    @Binding var presentNavigationBar:Bool
  @State private var isAnimated: Bool = false
  
  // MARK: - BODY
  
  var body: some View {
    HStack {
        Button(action: {
            self.presentNavigationBar.toggle()
        }, label: {
          ZStack {
            Image(systemName: "line.horizontal.3")
              .font(.title)
              .foregroundColor(.black)
            
            Circle()
              .fill(Color.red)
              .frame(width: 14, height: 14, alignment: .center)
              .offset(x: 13, y: -10)
          }
        }) //: BUTTON
        
      Spacer()
      
      LogoView()
        .opacity(isAnimated ? 1 : 0)
        .offset(x: 0, y: isAnimated ? 0 : -25)
        .onAppear(perform: {
          withAnimation(.easeOut(duration: 0.5)) {
            isAnimated.toggle()
          }
        })
      
      Spacer()
      
    
    } //: HSTACK
  }
}

// #Preview {
//     NavigationBarView(presentSideMenu:, isAnimated:  .false)
// }
