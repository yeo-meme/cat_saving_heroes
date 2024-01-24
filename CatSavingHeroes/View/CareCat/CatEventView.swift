//
//  BrandItemView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/31.
//

import SwiftUI

struct CatEventView: View {
    // MARK: - PROPERTY
    @Binding var selectedEvent: String // 선택된 이벤트 식별자를 저장하는 상태 변수
  
    
    // MARK: - BODY
    let columnSpacing: CGFloat = 10
    var gridLayout: [GridItem] {
      return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
    }
    let rowSpacing: CGFloat = 10

    @State private var isCheckboxChecked: Bool = false
    @State var isLookChecked = false
    @State var isMealChecked = false
    @State var isSnackChecked = false
    @State var isFoldPressed = false
    
    var body: some View {

        VStack{
            HStack{
                Button {
                    print(isLookChecked)
                    isLookChecked = !isLookChecked
                } label: {
                    if isLookChecked == false {
                        Image("EmptyCheckBox")
                            .resizable()
                            .frame(width: 20, height: 20)
                    } else {
                        Image("FullCheckBox")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }
                Text("목격")
                Spacer()
            }
            
            HStack{
                Text("식사")
                    .font(.system(size: 24))
                    .bold()
                    .padding()
                   Spacer()
                
                Image(isFoldPressed ? "down_fold":"up_fold")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .onTapGesture {
                        hadleHStackTap()
                    }.padding(.trailing, 25)
                
          
            }
            
            VStack{
                if isFoldPressed {
                    HStack{
                        Button {
                            print(isSnackChecked)
                            isSnackChecked = !isSnackChecked
                        } label: {
                            if isSnackChecked == false {
                                Image("EmptyCheckBox")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            } else {
                                Image("FullCheckBox")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        Text("간식급여")
                        Spacer()
                    }//:간식급여
                    HStack{
                        Button {
                            print(isMealChecked)
                            isMealChecked = !isMealChecked
                        } label: {
                            if isMealChecked == false {
                                Image("EmptyCheckBox")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            } else {
                                Image("FullCheckBox")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        Text("식사급여")
                        Spacer()
                    }//:간식급여
                } else {
                    EmptyView()
                }
            }.padding(.leading,35)
       
           
        }
        
        
    }
    
    func hadleHStackTap() {
        isFoldPressed.toggle()
        
      
    }
}

#Preview {
    CatEventView(selectedEvent: .constant("먹이"))
}
