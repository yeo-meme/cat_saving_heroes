//
//  UserViewModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/31.
//

import Foundation
import Firebase
import FirebaseStorage

class UserViewModel: ObservableObject {
    @Published var user: UserInfo
    @Published var showErrorAlert = false
    @Published var erroMessage = ""
    
    init(_ user: UserInfo) {
        self.user = user
    }
}
