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
  // @State private var isAnimated: Bool = false
  @State  var isAnimated: Bool = true
  
  // MARK: - BODY
  
  var body: some View {
    HStack {
        Button(action: {
            self.presentNavigationBar.toggle()
        }, label: {
          ZStack {
            // Image(systemName: "line.horizontal.3")
            Image("menu")
               .resizable()
               .frame(width: 32, height: 32)
              .font(.title)
              .foregroundColor(.black)
            
            // Circle()
            //   .fill(Color.red)
            //   .frame(width: 14, height: 14, alignment: .center)
            //   .offset(x: 13, y: -10)
          }
        }) //: BUTTON
        
      Spacer()
      
            LogoView()
              .opacity(isAnimated ? 1 : 0)
              .offset(x: 0, y: isAnimated ? 0 : -25)
              .onAppear(perform: {
                withAnimation(.easeOut(duration: 0.5)) {
                  // isAnimated.toggle()
                    print("isAni : \(isAnimated)")
                }
              })
              // .onDisappear{
              //     withAnimation(.easeOut(duration: 0.5)) {
              //       isAnimated = true
              //         print("isAni : \(isAnimated)")
              //     }
              // }
              // 
   
      
      Spacer()
      
    
    } //: HSTACK
  }
}

// #Preview {
//     NavigationBarView(presentSideMenu:, isAnimated:  .false)
// }
