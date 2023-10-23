//
//  AddCat.swift
//  SideMenuSwiftUI
//
//  Created by Zeeshan Suleman on 04/03/2023.
//

import SwiftUI
import Charts
import RealmSwift
import MapKit


struct AddCatView: View {
    
    @EnvironmentObject var locationManager: AddressManager
    
    @Binding var presentSideMenu: Bool
    
    @State private var catName = ""
    @State private var catAge = ""
    @State private var catGender = ""
    @State private var catMemo = ""
    @State private var catAddress = ""
    @State private var catLocation = ""
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    
    @State private var catImage: Image?
    @State private var imagePickerPresented = false
    @State private var isIndicatorAnimating = false
    
    let genders = ["남아", "여아"]
    @State private var selectedAge: Int = 0
    let ageRange = 1...30 // 1부터 30까지의 범위
    @EnvironmentObject var viewModel : AuthViewModel
    @ObservedObject var catViewModel: AddCatViewModel
    
   
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    VStack{
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text("고양이를 등록하면")
                                .font(.title3)
                                .bold()
                            
                            Text("내가 등록한 고양이를 관리할 수 있어요")
                                .font(.title3)
                                .bold()
                                .foregroundColor(Color.primaryColor)
                            
                        }
                        .padding(.horizontal, 32)
                        Spacer()
                        
                        Button(action: {
                            imagePickerPresented.toggle()
                        }) {
                            if let catImage = catImage {
                                catImage
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 150, height: 150)
                                    .clipShape(Circle())
                            } else {
                                Text("여기를 누르세요!")
                                    .font(.system(size: 18, weight: .semibold))
                                    .frame(width: 150, height: 150)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(style: StrokeStyle(lineWidth: 2, dash: [5])))
                            }
                        }
                        .padding(.top, 56)
                        .padding(.bottom)
                        .sheet(isPresented: $imagePickerPresented, onDismiss: loadImg,
                               content: {
                            ImagePicker(image: $selectedImage)
                        })
                        
                        
                        VStack{
                            
                            CustomTextField(imageName: "flag.checkered.circle.fill", placeholder: "고양이 이름을 지어주세요", isSecureField: false, text: $catName)
                            // CustomTextField(imageName: "questionmark.key.filled", placeholder: "추정 나이를 입력해주세요", isSecureField: false, text: $cat)
                            // CustomTextField(imageName: "questionmark.key.filled", placeholder: "상세주소없이 발견동까지만 입력해주세요", isSecureField: false, text: $catName)
                            Picker("성별", selection: $catGender) {
                                ForEach(genders, id: \.self) { gender in
                                    Text(gender).tag(gender)
                                }
                            }  .pickerStyle(SegmentedPickerStyle())
                            
                            
                            HStack {
                                 Text("고양이의 나이를 입력해주세요")
                                Spacer()
                                 Picker("나이", selection: $selectedAge) {
                                   ForEach(ageRange, id: \.self) { age in
                                     Text("\(age)")
                                           .foregroundColor(Color.black)
                                   }
                                 }
                               }
                            CustomTextField(imageName: "questionmark.key.filled", placeholder: "필요한 메모", isSecureField: false, text: $catMemo)
                        }.padding(.horizontal, 32)
                        
                        //TEST
                        // Button(action: {
                        //     catViewModel.loadCats()
                        // }, label: {
                        //     VStack{
                        //         Text("불러오기")
                        //         }
                        //     }
                        // )
                  
                    }//:VStack
                }//: ScrollView
                
                Text("* 이름과 사진을 필수로 등록이 필요해요").padding(0)
                CapsuleButton(text: "완료", disabled: catImage == nil || catName == "", isAnimating: isIndicatorAnimating,
                              action: {
                    isIndicatorAnimating = true
                    catAddress = locationManager.currentPlace
                    
                    // 위도와 경도를 문자열로 변환
                    let latitudeString = locationManager.currentGeoLocation?.coordinate.latitude
                    let longitudeString = locationManager.currentGeoLocation?.coordinate.longitude
                    catLocation = "\(latitudeString),\(longitudeString)"
                    
                    catViewModel.catImageUpload(selectedImage!) { success, imageUrl in
                        if success {
                            print("profile 등록완료 ! 반환 : \(String(describing: imageUrl))")
                           
                            
                            if let profileImage = imageUrl {
                                catViewModel.saveCat(name: catName, age: catAge, address: catAddress, gender: catGender, memo: catMemo,profileImage:profileImage,location:catLocation)
                                isIndicatorAnimating = false
                            }
                        } else {
                            print("고양이 사진 등록 않됐음")
                            isIndicatorAnimating = false
                        }
                    }
                })
            }
        }
    }
    
    func loadImg() {
        guard let selectedImage = selectedImage else {return}
        catImage = Image(uiImage: selectedImage)
    }
    
}



#Preview {
    AddCatView(presentSideMenu: Binding.constant(false), catViewModel: AddCatViewModel()
    )
}
