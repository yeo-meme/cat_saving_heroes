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
    
    
    
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var addressManager : Model
    @Binding var isShowingModal:Bool
    @State var isShowingSearchModal = false
    @State var isSearchEnd = false
    //Alamofire 컴플리트 핸들러
    @State var completeAction = false
    @State private var selectedEvent: String="" //선택된이벤트 저장
    //이벤트
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
    // @State var coordinate = "Coordinates"
    @State var address = "Address"
    @State var date = Date()
    @State private var isEditing = false
    
    //realm 검색관련
    @State var catModelData:[CatRealmModel]
    @State var selectedCat : CatRealmModel?
    
    //몽고 검색관련
    @State var catListData : [Cats]
    @State var catSearchListData : [Cats]
    @State var choiceCat : Cats?
    
    //이벤트 버튼 초이스 인덱스
    var selectedIndex: Int=10
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
                    SearchBar(text: $searchText, isEditing: $isEditing, isShowingSearchModal: $isShowingSearchModal, catSearchListData: $catSearchListData, choiceCat: $choiceCat, isSearchEnd: $isSearchEnd)
                        .onTapGesture {
                            isEditing.toggle()
                            print("토글 : \(isEditing)")
                        }
                        .padding(.trailing, 32)
                        .padding(.leading, 32)
                        .padding(.top , 32)
                    VStack{
                        if isEditing {
                            SearchCatView(showConversationView: .constant(false), isEditing: $isEditing,selectedCatArr:$catSearchListData,choiceCat:$choiceCat)
                            
                          
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
                                                .foregroundColor(Color.primaryColor)
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
                                        // model.eventAddCat(state: state, user_id: user_id, cat_id: cat_id, memo: memo, coordinate: coordinate, address: address, date: date)
                                        
                                        // //리얼엠 마이그레이션
                                        // let config = Realm.Configuration(
                                        //     schemaVersion: 0, // 스키마 버전을 0으로 설정
                                        //     deleteRealmIfMigrationNeeded: true // 마이그레이션이 필요한 경우 Realm 삭제
                                        // )
                                        // Realm.Configuration.defaultConfiguration = config
                                       
                                     
                                        
                                        
                                        if addressManager.isLocationTrackingEnabled {
                                            let locationRecord = LocationRecord()
                                            locationRecord.latitude = addressManager.lastLocation.latitude
                                            locationRecord.longitude = addressManager.lastLocation.longitude
                                            let coordinates = [locationRecord.longitude,locationRecord.latitude]
                                            
                                            
                                            model.isRuningCatWalkEventAdd(state: state, user_id: user_id, cat_id: cat_id, memo: memo, coordinates: coordinates, address: address,completeAction: completeAction)
                                            print("isRunningCatWalk send : \(locationRecord.latitude), \(locationRecord.longitude)")
                                            
                                        } else {
                                            let locationRecord = LocationRecord()
                                            locationRecord.latitude = addressManager.lastLocation.latitude
                                            locationRecord.longitude = addressManager.lastLocation.longitude
                                            let coordinates = [locationRecord.longitude,locationRecord.latitude]
                                            
                                            model.notRuningCatWalkEventAdd(state: state, user_id: user_id, cat_id: cat_id, memo: memo, address: address, date: date, coordinates:coordinates)
                                            print("isRunningCatWalk send : \(locationRecord.latitude), \(locationRecord.longitude)")
                                        }
                                        
                                        mode.wrappedValue.dismiss()
                                        print("모달 닫기 ")
                                    }//: 캡슐버튼
                                }//:VSTACK
                                .padding(.top, 60)
                            }
                        }//:else 서치 페이지
                            }//:ZSTACK
                            }//:SCROLLVIEW
                        }//: VSTACK
                    }//: NAVIGATIONVIEW
                }
                
            }
            
            
            struct SearchBar: View {
                @Binding var text: String
                @Binding var isEditing: Bool
                @Binding var isShowingSearchModal:Bool
                // @Binding var catRealmArr:[CatRealmModel] //String
                // @Binding var selectedCat : CatRealmModel?
                @Binding var catSearchListData:[Cats] //String
                @Binding var choiceCat : Cats?
                @State var isCatArrfinish:Bool = false
                @Binding var isSearchEnd:Bool
                
                // @Binding var catSearchListData : [Cats]?
                // @Binding var catSearchData : Cats?
                
                
                var body: some View {
                    HStack {
                        TextField("고양이의 이름을 입력하세요", text: $text)
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
                            .onSubmit {
                                catsSearch()
                                // realmCall()
                            }
                      
                        if isEditing {
                            Button(action: {
                                isEditing = false
                                text = ""
                                // selectedCat = ""
                                UIApplication.shared.endEditing()
                            }, label: {
                                Text("Cancel")
                                    .foregroundColor(.black)
                            })
                            .padding(.trailing, 8)
                        }
                    }
                    
                }
                // func realmCall() {
                //     let cats = RealmHelper.shared.readCats(withName: text)
                //     catRealmArr = cats
                //     isSearchEnd = true
                // }
                
                func catsFilterSearch(){
                    print("고양이 검색어 : \(text)")
                    if self.catSearchListData.isEmpty {
                        
                    }
                    for catsData in self.catSearchListData {
                        if catsData.name == text {
                            self.catSearchListData.removeAll()
                            self.catSearchListData.append(catsData)
                            print("고양이 검색어 catSearchListData : \(self.catSearchListData)")
                        }
                    }
                    isSearchEnd = true
                }
                
                
                func catsSearch() {
                    AF.request(CAT_SELECT_API_URL, method: .post).responseDecodable(of: [Cats].self) { response in
                        switch response.result {
                        case .success(let value):
                            print("성공 디코딩 : \(value)")
                            self.catSearchListData = value
                            catsFilterSearch()
                        case .failure(let error):
                            print("실패 디코딩 : \(error.localizedDescription)")
                        }
                    }
                }
            }
            
            
            #Preview {
                AddEventView(isShowingModal: .constant(false), model: EventAddViewModel(model: Model(userLocation: .constant(CLLocationCoordinate2D(latitude: 37.551134, longitude: 126.965871)), locations: .constant([CLLocationCoordinate2D(latitude: 37.551134, longitude: 126.965871), CLLocationCoordinate2D(latitude: 37.552134, longitude: 126.966871)]))),  catModelData: [], catListData: [], catSearchListData: []
                )}
