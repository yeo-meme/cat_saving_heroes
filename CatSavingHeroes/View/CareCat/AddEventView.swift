//
//  AddEventView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/11.
//

import SwiftUI
import RealmSwift

struct AddEventView: View {
    @EnvironmentObject var addressManager : Model
    @Binding var isShowingModal:Bool
    @State var isShowingSearchModal = false
    @State private var isButtonClicked1 = false //버튼 클릭시 상태
    @State private var isButtonClicked2 = false //버튼 클릭시 상태
    @State private var isButtonClicked3 = false //버튼 클릭시 상태
    @State private var isButtonClicked4 = false //버튼 클릭시 상태
    @State private var isButtonClicked5 = false //버튼 클릭시 상태
    
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
                
                NavigationLink(destination: SearchCatView( showConversationView: .constant(false)), isActive: $isLinkActive) {
                                   Button(action: {
                                       self.isLinkActive = true
                                   }) {
                                       HStack {
                                           Image(systemName: "magnifyingglass")
                                               .foregroundColor(Color(.systemGray2))
                                               .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                               .padding(.leading, 10)
                                           Text("Search...")
                                               .foregroundColor(Color(.systemGray2))
                                           Spacer() // 오른쪽 정렬을 위해 Spacer 추가
                                       }
                                       .padding()
                                       .background(Color(.systemGroupedBackground))
                                       .cornerRadius(8)
                                   }
                               }
                
                
                    // NavigationLink(destination: SearchCatView( showConversationView: .constant(false))) {
                    //     Button(action: {
                    //         isShowingSearchModal.toggle()
                    //     }, label: {
                    //         HStack {
                    //             Image(systemName: "magnifyingglass")
                    //                 .foregroundColor(Color(.systemGray2))
                    //                 .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    //                 .padding(.leading, 10)
                    //             Text("Search...")
                    //                 .foregroundColor(Color(.systemGray2))
                    //             Spacer() // 오른쪽 정렬을 위해 Spacer 추가
                    //         }
                    //         .padding()
                    //         .background(Color(.systemGroupedBackground))
                    //         .cornerRadius(8)
                    //     })
                    // }
                    // .isPresented($isShowingSearchModal)
                
                
                
                
                
                
                ScrollView{
                    
                   
                            
                    
                    
                    // SearchBar(text: $searchText, isEditing: $isEditing, isShowingSearchModal: $isShowingSearchModal)
                    //     .onTapGesture {
                    //         isEditing.toggle()
                    //     
                    //     }
                    // .padding()
                 
                    ZStack(alignment: .topLeading){
                        Image("play_cat_background")
                            .resizable()
                            .scaledToFill() // 배경 이미지를 화면에 맞게 확대
                            .edgesIgnoringSafeArea(.all) // 이미지가 화면 전체를 덮도록 설정
                        VStack(alignment:.center,spacing: 0){
                            VStack(spacing: 0){
                                Capsule()
                                    .frame(width: 100, height: 50)
                                    .foregroundColor(Color.primaryColor)
                                    .overlay(
                                        Text("#12.24")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                    )
                            }.padding(.top, 10)
                            VStack(spacing: 0){
                                HStack{
                                    Button(action: {
                                        isButtonClicked1.toggle()
                                        // 버튼 클릭 시 수행할 작업
                                    }) {
                                        EventAddButton(isButtonClicked: $isButtonClicked1, text: "찾음", action:{})
                                    }
                                    Button(action: {
                                        isButtonClicked5.toggle()
                                    }) {
                                        EventAddButton(isButtonClicked: $isButtonClicked5, text: "인사", action:{})
                                    }
                                    Button(action: {
                                        isButtonClicked4.toggle()
                                    }) {
                                        EventAddButton(isButtonClicked: $isButtonClicked4, text: "놀이", action:{})
                                    }
                                }
                                HStack(spacing: 0){
                                    Button(action: {
                                        // 버튼 클릭 시 수행할 작업
                                        isButtonClicked2.toggle()
                                    }) {
                                        //"밥줌", "인사", "놀이", "아픔"
                                        EventAddButton(isButtonClicked: $isButtonClicked2, text: "밥줌", action:{})
                                    }
                                    // .background(Color.black)
                                    
                                    Button(action: {
                                        isButtonClicked3.toggle()
                                    }) {
                                        EventAddButton(isButtonClicked: $isButtonClicked3, text: "아픔", action:{})
                                    }
                                    
                                }
                                
                                // .offset(x: 50, y: 50) // 버튼의 위치를 조절 (원하는 위치로 설정)
                            }
                            .frame(height: 50)
                            
                        }
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
                    }
                }
            }
        }//: NAVIGATIONVIEW
    }
}


//
// #Preview {
//     AddEventView(model: EventAddViewModel(model: <#Model#>), isShowingModal: .constant(false))
// }
