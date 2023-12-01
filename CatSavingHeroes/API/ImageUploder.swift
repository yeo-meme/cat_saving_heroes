//
//  ImageUploder.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/05.
//

import Foundation
import Firebase
import FirebaseStorage

struct ImageUploader {
    static func uploadImage(image: UIImage, folderName: String,uid: String, completion: @escaping(String) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.0001) else { return }

        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/\(folderName)/\(filename)")
        
        print("file path: \(ref)")
        ref.putData(imageData, metadata: nil) { _, error in
            
            if let error = error {
                print("Error uploading image data: \(error.localizedDescription)")
            } else {
                ref.downloadURL { url, error in
                    guard let imageUrl = url?.absoluteString else { return }
                    completion(imageUrl)
                }
            }
        }
    }
}
