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

    var body: some View {
        NavigationView {
                Form {
                    Section(header: Text("Cat Information")) {
                        TextField("Name", text: $catName)
                        TextField("Age", text: $catAge)
                        TextField("Gender", text: $catGender)
                        TextEditor(text: $catMemo)
                    }
                    
                    // Section(header: Text("Cat Photo")) {
                    //     if let image = selectedImage {
                    //         Image(uiImage: image)
                    //             .resizable()
                    //             .aspectRatio(contentMode: .fit)
                    //             .frame(height: 200)
                    //     } else {
                    //         Text("No Photo Selected")
                    //     }
                    //     
                    //     Button("Select Photo") {
                    //         isImagePickerPresented.toggle()
                    //     }
                    //     .sheet(isPresented: $isImagePickerPresented) {
                    //         ImagePicker(selectedImage: $selectedImage)
                    //     }
                    // }
                    
                    Section {
                        Button(action: {
                            // Save cat information and photo here
                        }) {
                            Text("Add Cat")
                        }
                    }
                }
        }
    }
}

