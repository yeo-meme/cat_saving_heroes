//
//  AddEventView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/11.
//

import SwiftUI
import RealmSwift
import MapKit

struct AddEventView: View {
    @EnvironmentObject var addressManager : Model
    @Binding var isShowingModal:Bool
    @State var isShowingSearchModal = false
    
    
    @State private var isButtonClicked1 = false
    @State private var isButtonClicked2 = false
    @State private var isButtonClicked3 = false
    @State private var isButtonClicked4 = false
    @State private var isButtonClicked5 = false
    @State var buttonStates: [Bool] = [false, false, false, false, false]
    
    let catState = ["찾음", "밥줌", "인사", "놀이", "아픔"]
    @ObservedObject var model :EventAddViewModel
    
    @State private var searchText = ""
    @State private var careStateIndex = 0
    @State private var state  = ""
    @State private var memo = ""
    let user_id = "User ID"
    let cat_id = "Cat ID"
    @State var coordinate = "Coordinates"
    @State var address = "Address"
    @State var date = Date()
    @State private var isEditing = false
    
    
    @State var isLinkActive = false
    var body: some View {
        NavigationView{
            VStack {
                CloseButtonView(isShowingModal: $isShowingModal)
                    .padding(.top, 10)
                
                // NavigationLink(destination: SearchCatView( showConversationView: .constant(false)), isActive: $isLinkActive) {
                //                    Button(action: {
                //                        self.isLinkActive = true
                //                    }) {
                //                        HStack {
                //                            Image(systemName: "magnifyingglass")
                //                                .foregroundColor(Color(.systemGray2))
                //                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                //                                .padding(.leading, 10)
                //                            Text("Search...")
                //                                .foregroundColor(Color(.systemGray2))
                //                            Spacer() // 오른쪽 정렬을 위해 Spacer 추가
                //                        }
                //                        .padding()
                //                        .background(Color(.systemGroupedBackground))
                //                        .cornerRadius(8)
                //                    }
                //                }
                
                
                
                
                ScrollView{
                    SearchBar(text: $searchText, isEditing: $isEditing, isShowingSearchModal: $isShowingSearchModal)
                        .onTapGesture {
                            isEditing.toggle()
                        }
                        .padding()
                    
                    if isEditing {
                        SearchCatView(showConversationView: .constant(false))
                    } else {
                        ZStack {
                            Image("play_cat_background")
                                .resizable()
                                .scaledToFill()
                                .edgesIgnoringSafeArea(.all)
                            
                            VStack(spacing: 0) {
                                Capsule()
                                    .frame(width: 100, height: 50)
                                    .foregroundColor(Color.primaryColor)
                                    .overlay(
                                        Text("#12.24")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                    )
                                // Other content specific to this VStack
                            }
                            .padding(.top, 10)
                            .offset(y: -200)
                            
                            VStack {
                                HStack(spacing: 10) {
                                    
                                    EventAddButton(buttonStates: $buttonStates, careStateIndex: $careStateIndex, text: "찾음", action: {
                                        careStateIndex=0
                                    })
                                    EventAddButton(buttonStates: $buttonStates, careStateIndex: $careStateIndex, text: "찾음", action: {
                                        careStateIndex=1
                                    })
                                    EventAddButton(buttonStates: $buttonStates, careStateIndex: $careStateIndex, text: "찾음", action: {
                                        careStateIndex=2
                                    })
                                    EventAddButton(buttonStates: $buttonStates, careStateIndex: $careStateIndex, text: "찾음", action: {
                                        careStateIndex=3
                                    })
                                    EventAddButton(buttonStates: $buttonStates, careStateIndex: $careStateIndex, text: "찾음", action: {
                                        careStateIndex=4
                                    })
                                    // Button(action: {
                                    //     print("button 1: \($isButtonClicked1.wrappedValue)")
                                    //     isButtonClicked1.toggle()
                                    //    
                                    //     // buttonStates[0].toggle() //false
                                    //     print("button 이벤트 후 토글 : \(buttonStates[0])")
                                    //     toggleState(index: 0)
                                    //     // 버튼 클릭 시 수행할 작업
                                    // }) {
                                    //     EventAddButton(buttonStates: $buttonStates, text: "찾음", action: {})
                                    //     
                                    //     
                                    // }
                                    // 
                                    // Button(action: {
                                    //     isButtonClicked2.toggle()
                                    //     toggleState(index: 1)
                                    //     print("button 2: \($isButtonClicked2)")
                                    // }) {
                                    //     EventAddButton(buttonStates: $buttonStates, text: "인사", action: {})
                                    // }
                                    // 
                                    // Button(action: {
                                    //     isButtonClicked3.toggle()
                                    //     toggleState(index: 2)
                                    //     print("button 3: \($isButtonClicked3)")
                                    // }) {
                                    // 
                                    //     EventAddButton(buttonStates: $buttonStates, text: "놀이", action: {})
                                    // }
                                    // 
                                    // Button(action: {
                                    //     // 버튼 클릭 시 수행할 작업
                                    //     isButtonClicked4.toggle()
                                    //     toggleState(index: 3)
                                    //     print("button 4: \($isButtonClicked4)")
                                    // }) {
                                    //     EventAddButton(buttonStates: $buttonStates, text: "밥줌", action: {})
                                    // }
                                    // Button(action: {
                                    //     isButtonClicked5.toggle()
                                    //     toggleState(index: 4)
                                    //     print("button 5: \($isButtonClicked5)")
                                    // }) {
                                    //     EventAddButton(buttonStates: $buttonStates, text: "아픔", action: {})
                                    // }
                                    
                                }
                            }
                            .frame(height: 50)
                            .offset(y: -130)
                        }
                        
                        
                        VStack{
                            VStack{
                                TextField("나만의 메모", text: $memo)
                                    .textFieldStyle(RoundedBorderTextFieldStyle()) // 선택적으로 스타일 지정
                                    .padding()
                                
                                //false가 저장하기 텍스트 true가 인디케팅되는 상태
                                CapsuleButton(text: "저장하기", disabled: false, isAnimating: false) {
                                    print("이벤트 기록하기 ")
                                    // model.eventAddCat(state: state, user_id: user_id, cat_id: cat_id, memo: memo, coordinate: coordinate, address: address, date: date)
                                    
                                    //리얼엠 마이그레이션
                                    let config = Realm.Configuration(
                                        schemaVersion: 0, // 스키마 버전을 0으로 설정
                                        deleteRealmIfMigrationNeeded: true // 마이그레이션이 필요한 경우 Realm 삭제
                                    )
                                    Realm.Configuration.defaultConfiguration = config
                                    
                                    if addressManager.isLocationTrackingEnabled {
                                        let locationRecord = LocationRecord()
                                        locationRecord.latitude = addressManager.lastLocation.latitude
                                        locationRecord.longitude = addressManager.lastLocation.longitude
                                        model.isRunningCatWalk(latitude: locationRecord.latitude,logtitude:locationRecord.longitude,state: state, user_id: user_id, cat_id: cat_id, memo: memo, coordinate: coordinate, address: address, date: date)
                                        print("isRunningCatWalk send : \(locationRecord.latitude), \(locationRecord.longitude)")
                                        
                                    } else {
                                        let locationRecord = LocationRecord()
                                        locationRecord.latitude = addressManager.lastLocation.latitude
                                        locationRecord.longitude = addressManager.lastLocation.longitude
                                        model.isNotRuningCatWalk(state: state, user_id: user_id, cat_id: cat_id, memo: memo, coordinate: coordinate, address: address, date: date)
                                        print("isRunningCatWalk send : \(locationRecord.latitude), \(locationRecord.longitude)")
                                    }
                                }//:VSTACK
                            }//:VSTACK
                        }//:VSTACK 메모, 저장하기
                    }
                    
                    
                    
                    
                    
                    // Image("menu_cat")
                    //   .resizable()
                    //   .scaledToFit()
                    //   .padding(3)
                    //   .background(Color.white.cornerRadius(12))
                    //   .background(
                    //     RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1)
                    //   )
                    
                    // Picker("고냥이의 이벤트 등록하기", selection: $careStateIndex) {
                    //     ForEach(0 ..< catState.count) {
                    //         Text(self.catState[$0])
                    //     }
                    // }
                    // .pickerStyle(SegmentedPickerStyle())
                    // .padding()
                    //
                    // Text("You've chosen '\(catState[careStateIndex])'.")
                    
                    
                }//:SCROLLVIEW
            }//: VSTACK
        }//: NAVIGATIONVIEW
    }
    
 
    
    
    // func haha() {
    //     
    //     // print("button 들어와서 토글 : \(buttonStates[buttonNumber])")
    //     // for i in 0..<buttonStates.count {
    //     //     if i == buttonNumber {
    //     //         buttonStates[i] = !buttonStates[i]
    //     //         print("button 같은면 전환 : \(buttonStates[i])")
    //     //     } else {
    //     //         buttonStates[i] = false
    //     //         print("button 다르면 false : \(buttonStates[i])")
    //     //     }
    //     // }
    //     //
    //     // buttonStates[index].toggle() // 토글해 true->false
    //     for i in 0..<buttonStates.count {
    //               if i != index {
    //                   buttonStates[i] = false
    //                   print("button 아닌거 변환값 : \(buttonStates[i])")
    //               } else {
    //                   buttonStates[i] = true
    //                   print("button 긴거 변환값 : \(buttonStates[i])")
    //               }
    //           }
    // }
}


//
#Preview {
    AddEventView(isShowingModal: .constant(false), model: EventAddViewModel(model: Model(userLocation: .constant(CLLocationCoordinate2D(latitude: 37.551134, longitude: 126.965871)), locations: .constant([CLLocationCoordinate2D(latitude: 37.551134, longitude: 126.965871), CLLocationCoordinate2D(latitude: 37.552134, longitude: 126.966871)])))
    )}
