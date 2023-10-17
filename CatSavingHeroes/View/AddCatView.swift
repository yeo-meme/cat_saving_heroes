//
//  AddCat.swift
//  SideMenuSwiftUI
//
//  Created by Zeeshan Suleman on 04/03/2023.
//

import SwiftUI
import Charts
import RealmSwift


struct AddCatView: View {
    @Binding var presentSideMenu: Bool
    
    @State private var catName = ""
    @State private var catAge = ""
    @State private var catGender = ""
    @State private var catMemo = ""
    @State private var catAddress = ""
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
                            HStack{ Spacer() }
                            
                            Text("이름도 알아듣는 고양이들 있어요!")
                                .font(.title2)
                                .bold()
                            
                            Text("당신이 지어주세요 멋진이름을!")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.purple)
                            
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
                        
                        
                        Form {
                            Section(header: Text("기본 정보")) {
                                TextField("이름", text: $catName)
                                TextField("Age", text: $catAge)
                                TextField("발견동네", text: $catAddress)
                                Picker("성별", selection: $catGender) {
                                    ForEach(genders, id: \.self) { gender in
                                        Text(gender).tag(gender)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                Picker("나이", selection: $selectedAge) {
                                    ForEach(ageRange, id: \.self) { age in
                                        Text("\(age)").tag(age)
                                    }
                                }
                                .pickerStyle(.automatic)
                            }
                            Button(action: {
                                catViewModel.loadCats()
                            }, label: {
                                VStack{
                                    Text("불러오기")
                                    }
                                }
                            )
                            Section(header: Text("필요한 메모를 남겨보세요")) {
                                TextEditor(text: $catMemo)
                            }
                            .frame(height: 100)
                        }
                        .frame(height: 300)
                        // .scrollDisabled(true)
                    }//:VStack
                }//: ScrollView
                
                CapsuleButton(text: "완료", disabled: catImage == nil, isAnimating: isIndicatorAnimating,
                              action: {
                    // isIndicatorAnimating = true
                    // RealmHelper.shared.createCat(name: catName, age: catAge, gender: catGender, memo: catMemo)
                    catViewModel.catImageUpload(selectedImage!) { success, imageUrl in
                        if success {
                            print("profile 등록완료 ! 반환 : \(String(describing: imageUrl))")
                            
                            if let profileImage = imageUrl {
                                catViewModel.saveCat(name: catName, age: catAge, address: catAddress, gender: catGender, memo: catMemo,profileImage:profileImage)
                            }
                        } else {
                            print("고양이 사진 등록 않됐음")
                        }
                    }
                })
            }
            .navigationBarItems(leading: Text("냥추가"),
                trailing: NavigationMenuView(presentSideMenu: $presentSideMenu))
          
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
