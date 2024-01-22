//
//  EmptyTestView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/12/18.
//

import SwiftUI
import RealmSwift
import MapKit
import Alamofire

struct EventAddView: View {
    @ObservedObject var viewModel: TakeCareOfCatViewModel
    @Environment(\.presentationMode) var mode
    let curretnDate: Data = Data()
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MM.dd"
        return formatter
    }()

    @State private var isEditing = false
    @State private var choiceCat :Cats?
    @State private var selectedEvent: String="" //선택된이벤트 저장
    @State private var searchName: String = ""
    @ObservedObject var model = EventAddViewModel()
   
    @State private var memo = ""
    @Binding var isLoading:Bool
    
    var body: some View {
        VStack{
            ScrollView{
                ZStack(alignment:.bottomTrailing) {
                    VStack(spacing: 0) {
                        Capsule()
                            // .frame(width: 100, height: 50)
                            // .foregroundColor(Color.primaryColor)
                            // .overlay(
                            //     // Text("# \(dateFormatter.string(from: currentDate))")
                            //         .foregroundColor(.white)
                            //         .font(.headline)
                            // )
                        // Other content specific to this VStack
                        HStack{
                          Button(action: {
                              mode.wrappedValue.dismiss()
                          }) {
                               Image(systemName: "xmark")
                                  .foregroundColor(.primary)
                                  .font(.title)
                                  .padding()
                          }
                            Spacer()
                        }
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
                }
                // catSearchBar(searchName: $searchName)
                //     .onSubmit {
                //         ForEach(searchName.isEmpty ? model.catSearchListData : model.filteredCats(searchName)) { cats in
                //         SearchCatCell(cat: cats)
                //         }
                //         SearchCatView(showConversationView: .constant(false), isEditing: $isEditing, selectedCatArr: model.catSearchListData, choiceCat: $choiceCat)
                //     }
            }
        }
        // .onDisappear{
        //     viewModel.matchUserInterestCatLoad()
        //     isLoading=false
        // }
     
    }
}


private func catSearchBar(searchName: Binding<String>) -> some View {

    @State var searchName:String=""
    return HStack{
        TextField("등록한 고양이 찾아보기", text: $searchName)
            .padding()
            .padding(.horizontal, 32)
            .background(Color(.systemGroupedBackground))
            .cornerRadius(8)
            .overlay(
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(.systemGray2))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
            )
        
    }
}

#Preview {
    EventAddView(viewModel: TakeCareOfCatViewModel(), isLoading: .constant(false))
}
