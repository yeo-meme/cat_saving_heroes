//
//  AddCat.swift
//  SideMenuSwiftUI
//
//  Created by Zeeshan Suleman on 04/03/2023.
//

import SwiftUI
import Charts

struct AddCatView: View {
    @State private var catName = ""
    @State private var catAge = ""
    @State private var catGender = ""
    @State private var catMemo = ""
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    
    @State private var catImage: Image?
    @State private var imagePickerPresented = false
    @State private var isIndicatorAnimating = false
    
    let genders = ["남아", "여아"]
    @State private var selectedAge: Int = 0
        let ageRange = 1...30 // 1부터 30까지의 범위

    var body: some View {
        NavigationView {
                ScrollView{
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
                            
                            
                            
                            Section(header: Text("필요한 메모를 남겨보세요")) {
                                
                                TextEditor(text: $catMemo)
                            }
                            .frame(height: 100)
                            
                        }
                        .frame(height: 300)
                        .scrollDisabled(true)
                    }//: ScrollView
                        
                        CapsuleButton(text: "완료", disabled: catImage == nil, isAnimating: isIndicatorAnimating,
                                      action: {
                            isIndicatorAnimating = true
                            // viewModel.uploadProfileImage(selectedImage!) { success in
                            //     if success {
                            //     } else {
                            //     }
                            // }
                        })
                    }
                
        }
    }
    
    func loadImg() {
        guard let selectedImage = selectedImage else {return}
        catImage = Image(uiImage: selectedImage)
    }

}

