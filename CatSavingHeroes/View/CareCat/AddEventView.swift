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
    
    var body: some View {
        VStack {
            // SearchCatView()
            SearchBar(text: $searchText, isEditing: $isEditing)
                .onTapGesture { isEditing.toggle()
                }
                .padding()
            
            TextField("Search", text: $searchText)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding()
            
            Picker("고냥이의 이벤트 등록하기", selection: $careStateIndex) {
                ForEach(0 ..< catState.count) {
                    Text(self.catState[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Text("You've chosen '\(catState[careStateIndex])'.")
            
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
}


//
// #Preview {
//     AddEventView(model: $model)
// }
