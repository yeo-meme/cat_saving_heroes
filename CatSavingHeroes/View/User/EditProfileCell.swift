//
//  EditProfileCell.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/31.
//

import SwiftUI
import Kingfisher

struct EditProfileCell: View {
    @ObservedObject var viewModel: EditProfileViewModel
    @Binding var showImagePicker: Bool
    @Binding var selectedImage: UIImage?
    @State var profileImage: Image?

    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .center) {
                Button {
                    showImagePicker.toggle()
                    print("showImagePicker : \(showImagePicker)")
                } label: {
                    if let profileImage = profileImage {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                    } else {
                        KFImage(URL(string: viewModel.user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                    }
                }.sheet(isPresented: $showImagePicker, onDismiss: loadImage) { ImagePicker(image: $selectedImage) }
            }.padding(32)
        }
    }

    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
        print("selectedImage : \(selectedImage) , profileImage: \(profileImage)")
    }
}

// #Preview {
//     EditProfileCell()
// }
