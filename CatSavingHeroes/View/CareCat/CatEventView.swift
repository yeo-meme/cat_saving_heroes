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
    @State private var isIndicatorAnimating = false
    
    // MARK: - BODY
    let columnSpacing: CGFloat = 10
    var gridLayout: [GridItem] {
        return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
    }
    let rowSpacing: CGFloat = 10
    
    @State private var isCheckboxChecked: Bool = false
    
    //목격
    @State var isLookChecked = false
   
    //식사
    @State var isMealChecked = false
    @State var isSnackChecked = false
    
    //컨디션
    @State var isConditionDownChecked = false
    @State var isConditionStableChecked = false
    @State var isConditionUpChecked = false
    
    //건강상태
    @State var isSickChecked = false
    @State var isRecoverChecked = false
    @State var isGoodHealthChecked = false
    @State var isHealthConcernChecked = false
    
    //카테고리접이
    @State var isMealFoldPressed = false
    @State var isConditionFoldPressed = false
    @State var isHealthFoldPressed = false
    
    //기타
    @State var etcText:String=""
    @State var isEmptyETC:Bool=false
    
    var body: some View {
        
        HStack{
            Text("일지로 어떤 내용을 남기고 싶으신가요?")
                .font(.title3)
                .bold()
                .padding()
            
            Spacer()
        }
            
        
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
                
                Image("openmoji_black-cat")
                    .resizable()
                    .frame(width: 48, height: 45)
                Text("목격")
                    
                Spacer()
            }
            
            HStack{
                Text("식사")
                    .font(.system(size: 24))
                    .bold()
                Spacer()
                
                Image(isMealFoldPressed ? "down_fold":"up_fold")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .onTapGesture {
                        hadleMealTap()
                    }
                
                
            }
            VStack{
                if isMealFoldPressed {
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
            }//:식사
            
            HStack{
                Text("컨디션")
                    .font(.system(size: 24))
                    .bold()
                Spacer()
                
                Image(isConditionFoldPressed ? "down_fold":"up_fold")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .onTapGesture {
                        hadleConditionTap()
                    }
            }
            .padding(.top,20)
            VStack{
                if isConditionFoldPressed {
                    HStack{
                        Button {
                            print(isConditionDownChecked)
                            isConditionDownChecked = !isConditionDownChecked
                        } label: {
                            if isConditionDownChecked == false {
                                Image("EmptyCheckBox")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            } else {
                                Image("FullCheckBox")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        Text("컨디션 저하")
                        Spacer()
                    }//:저하
                    HStack{
                        Button {
                            print(isConditionStableChecked)
                            isConditionStableChecked = !isConditionStableChecked
                        } label: {
                            if isConditionStableChecked == false {
                                Image("EmptyCheckBox")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            } else {
                                Image("FullCheckBox")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        Text("컨디션 양호")
                        Spacer()
                    }//:양호
                    HStack{
                        Button {
                            print(isConditionUpChecked)
                            isConditionUpChecked = !isConditionUpChecked
                        } label: {
                            if isConditionUpChecked == false {
                                Image("EmptyCheckBox")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            } else {
                                Image("FullCheckBox")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        Text("컨디션 좋은")
                        Spacer()
                    }//:좋음
                } else {
                    EmptyView()
                }
            }//:컨디션
            
            
            HStack{
                Text("건강상태")
                    .font(.system(size: 24))
                    .bold()
                Spacer()
                
                Image(isHealthFoldPressed ? "down_fold":"up_fold")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .onTapGesture {
                        handleHealthTap()
                    }
            }.padding(.top,20)
            VStack{
                if isHealthFoldPressed {
                    HStack{
                        Button {
                            print(isGoodHealthChecked)
                            isGoodHealthChecked = !isGoodHealthChecked
                        } label: {
                            if isGoodHealthChecked == false {
                                Image("EmptyCheckBox")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            } else {
                                Image("FullCheckBox")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        Text("건강양호")
                        Spacer()
                    }//:저하
                    HStack{
                        Button {
                            print(isRecoverChecked)
                            isRecoverChecked = !isRecoverChecked
                        } label: {
                            if isRecoverChecked == false {
                                Image("EmptyCheckBox")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            } else {
                                Image("FullCheckBox")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        Text("회복중")
                        Spacer()
                    }//:양호
                    HStack{
                        Button {
                            print(isSickChecked)
                            isSickChecked = !isSickChecked
                        } label: {
                            if isSickChecked == false {
                                Image("EmptyCheckBox")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            } else {
                                Image("FullCheckBox")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        Text("아픔")
                        Spacer()
                    }//:좋음
                    HStack{
                        Button {
                            print(isHealthConcernChecked)
                            isHealthConcernChecked = !isHealthConcernChecked
                        } label: {
                            if isHealthConcernChecked == false {
                                Image("EmptyCheckBox")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            } else {
                                Image("FullCheckBox")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        Text("건강우려")
                        Spacer()
                    }//:좋음
                } else {
                    EmptyView()
                }
            }//:건강상태
            
            
            VStack{
                HStack{
                    Text("기타")
                        .font(.system(size: 24))
                        .bold()
                    Spacer()
                }.padding(.top,20)
                
                
                CustomTextField(imageName: "OIGG",
                                placeholder: "나만의 메모를 남겨보세요",
                                isSecureField: false,
                                text: $etcText)
                .onChange(of: etcText) { text in
                    isEmptyETC = !text.isEmpty
                }
                .padding(.top, 10)
                
                
                
                // TextField("", text:$etcText)
                //     .textFieldStyle(RoundedBorderTextFieldStyle())
                //     .lineLimit(nil)
                //     .multilineTextAlignment(.leading)
                //     .onChange(of: etcText) { text in
                //         isEmptyETC = !text.isEmpty
                //     }
            }
        }
        .padding(.leading, 40)
        .padding(.trailing, 40)
    }
    
    func hadleMealTap() {
        isMealFoldPressed.toggle()
    }
    
    func hadleConditionTap() {
        isConditionFoldPressed.toggle()
    }
    
    func handleHealthTap() {
        isHealthFoldPressed.toggle()
    }
    
    func isCheckedValue() -> Bool {
        
        let isAnyCheckboxChecked = isCheckboxChecked ||
                                  isLookChecked ||
                                  isMealChecked || isSnackChecked ||
                                  isConditionDownChecked || isConditionStableChecked || isConditionUpChecked ||
                                  isSickChecked || isRecoverChecked || isGoodHealthChecked || isHealthConcernChecked ||
                                  isMealFoldPressed || isConditionFoldPressed || isHealthFoldPressed || isEmptyETC
        
        return isAnyCheckboxChecked
    }
}

#Preview {
    CatEventView(selectedEvent: .constant("먹이"))
}
