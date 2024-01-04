//
//  AddEventView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/11.
//

import SwiftUI
import RealmSwift
import MapKit
import Alamofire

struct AddEventView: View {
    
    let currentDate = Date()
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd"
        return formatter
    }()

    @State private var selectedEvent: String="" //선택된이벤트 저장
    let catState = ["찾음", "밥줌", "인사", "놀이", "아픔"]
    @ObservedObject var model = EventAddViewModel()
    //검색리스트 초기화 모델
    @ObservedObject var searchModel = SearchCatViewModel()
    @EnvironmentObject var authModel:AuthViewModel
    @State private var careStateIndex = 0
    @State private var state  = ""
    @State private var memo = ""
    let user_id = "User ID"
    let cat_id = "Cat ID"
    @State var address = "Address"
    @State var date = Date()
    @State private var isEditing = false
    
    //realm 검색관련
    // @State var catModelData:[CatRealmModel]
    // @State var selectedCat : CatRealmModel?
    
    //몽고 검색관련
    // @State var catListData : [Cats]
    // @State var catSearchListData : [Cats]
    @State var choiceCat : Cats?
    //이벤트 버튼 초이스 인덱스
    var selectedIndex: Int=10
    @State var isLinkActive = false
    
    //검색어
    @State private var searchText = ""
    
    var body: some View {
        // NavigationView{
            VStack {
                // CloseButtonView()
                //     .padding(.top, 10)
                ScrollView{
                    SearchBar(model: model, isEditing: $isEditing)
                        .onTapGesture {
                            isEditing.toggle()
                            print("토글 : \(isEditing)")
                        }
                        .padding(.trailing, 32)
                        .padding(.leading, 32)
                        .padding(.top , 32)
                    
                    VStack{
                        if isEditing {
                            ScrollView {
                                // VStack(spacing: 1) {
                                //     ForEach(searchText.isEmpty ? model.catSearchListData : model.filteredCats(searchText)
                                //     ) { cats in
                                //         Button(action: {
                                //             isEditing.toggle()
                                //             self.choiceCat = cats
                                //             // mode.wrappedValue.dismiss()
                                //         }, label: {
                                //             SearchCatCell(cat: cats)
                                //         })
                                //     }
                                // }
                            }
                            // SearchCatView(showConversationView: .constant(false), isEditing: $isEditing,selectedCatArr:model.catSearchListData,choiceCat:$choiceCat)
                        } else {
                            ZStack(alignment:.bottomTrailing) {
                                VStack(spacing: 0) {
                                    Capsule()
                                        .frame(width: 100, height: 50)
                                        .foregroundColor(Color.primaryColor)
                                        .overlay(
                                            Text("# \(dateFormatter.string(from: currentDate))")
                                                .foregroundColor(.white)
                                                .font(.headline)
                                        )
                                    // Other content specific to this VStack
                                    BrandItemView(selectedEvent: $selectedEvent)
                                    
                                    //선택된 고양이
                                    VStack(spacing: 0) {
                                        if let cat = choiceCat {
                                            Capsule()
                                                .frame(width: 100, height: 50)
                                                .foregroundColor(Color.complementColor)
                                                .overlay(
                                                    Text(cat.name)
                                                        .foregroundColor(.white)
                                                        .font(.headline)
                                                )
                                        } else {
                                            Text("검색을 통해 고양이를 검색해주세요")
                                                .font(.system(size: 18, weight: .semibold))
                                                .frame(width: 200, height: 80)
                                            // .clipShape(Circle())
                                                .overlay(RoundedRectangle(cornerRadius: 20) .stroke(style: StrokeStyle(lineWidth: 2, dash: [5])))
                                        }
                                        
                                        // Capsule()
                                        //     .frame(width: 100, height: 50)
                                        //     .foregroundColor(Color.primaryColor)
                                        //     .overlay(
                                        //         Text(selectedCat?.name ?? "")
                                        //             .foregroundColor(.white)
                                        //             .font(.headline)
                                        //     )
                                        // Other content specific to this VStack
                                    }//:Date
                                    
                                    
                                    CustomTextField(imageName: "OIGG",
                                                    placeholder: "나만의 메모를 남겨보세요",
                                                    isSecureField: false,
                                                    text: $memo)
                                    .padding(.trailing, 32)
                                    .padding(.leading, 32)
                                    .padding(.top, 30)
                                    
                                    //false가 저장하기 텍스트 true가 인디케팅되는 상태
                                    CapsuleButton(text: "저장하기", disabled: false, isAnimating: false) {
                                        print("이벤트 기록하기 ")
                                    
                                        // if addressManager.isLocationTrackingEnabled {
                                        //     let locationRecord = LocationRecord()
                                        //     locationRecord.latitude = addressManager.lastLocation.latitude
                                        //     locationRecord.longitude = addressManager.lastLocation.longitude
                                        //     let coordinates = [locationRecord.longitude,locationRecord.latitude]
                                        //     
                                        //     
                                        //     model.isRuningCatWalkEventAdd(state: state, user_id: user_id, cat_id: cat_id, memo: memo, coordinates: coordinates, address: address,completeAction: completeAction)
                                        //     print("isRunningCatWalk send : \(locationRecord.latitude), \(locationRecord.longitude)")
                                        //     
                                        // } else {
                                        //     let locationRecord = LocationRecord()
                                        //     locationRecord.latitude = addressManager.lastLocation.latitude
                                        //     locationRecord.longitude = addressManager.lastLocation.longitude
                                        //     let coordinates = [locationRecord.longitude,locationRecord.latitude]
                                        //     
                                        //     model.notRuningCatWalkEventAdd(state: state, user_id: user_id, cat_id: cat_id, memo: memo, address: address, date: date, coordinates:coordinates)
                                        //     print("isRunningCatWalk send : \(locationRecord.latitude), \(locationRecord.longitude)")
                                        // }
                                        // 
                                        // mode.wrappedValue.dismiss()
                                        // print("모달 닫기 ")
                                    }//: 캡슐버튼
                                }//:VSTACK
                                .padding(.top, 60)
                            }
                        }//:else 서치 페이지
                    }//:ZSTACK
                }//:SCROLLVIEW
            }//: VSTACK
            // .navigationBarHidden(true)
        // }//: NAVIGATIONVIEW
        .onAppear{
            authModel.showTopCustomView = false
        }
       
        .showErrorMessage(showAlert: $model.isShowingAlert, message: model.errorMessage)
    }
    
}


struct SearchBar: View {
    
    @ObservedObject var model : EventAddViewModel
    // @EnvironmentObject var viewModel: AuthViewModel
    @Binding var isEditing: Bool
    // @Binding var isShowingSearchModal:Bool

    // @Binding var choiceCat : Cats?
    @State var isCatArrfinish:Bool = false
    // @Binding var isSearchEnd:Bool
    
    @State var searchName:String = ""
    @State var tempTx:String = ""
 
    // @Binding var isShowingAlert:Bool
    
    var body: some View {
        HStack {
            TextField("고양이의 이름을 입력하세요", text: $searchName)
                .padding(8)
                .padding(.horizontal, 32)
                .background(Color(.systemGroupedBackground))
                .cornerRadius(8)
                .overlay(
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(.systemGray2))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                )
                // .onSubmit {
                //     tempTx = searchName
                //     // catsNameSearchAPI(tempTx)
                //     if tempTx == "" {
                //         model.isShowingAlert = true
                //         model.errorMessage = "고양이 이름을 검색해주세요"
                //         print("고양이 이름을 검색해주세요")
                //         return
                //     }
                //     model.catsSearch(tempTx)
                // }
            
            if isEditing {
                Button(action: {
                    isEditing = false
                    tempTx = ""
                    searchName = ""
                    model.catSearchListData.removeAll()
                    UIApplication.shared.endEditing()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.black)
                })
                .padding(.trailing, 8)
            }
        }
        
    }

}


// #Preview {
//     AddEventView(isShowingModal: .constant(false), model: EventAddViewModel(model: Model(userLocation: .constant(CLLocationCoordinate2D(latitude: 37.551134, longitude: 126.965871)), locations: .constant([CLLocationCoordinate2D(latitude: 37.551134, longitude: 126.965871), CLLocationCoordinate2D(latitude: 37.552134, longitude: 126.966871)]))),  catModelData: [], catListData: [], catSearchListData: []
//     )}
