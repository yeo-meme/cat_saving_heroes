//
//  AuthViewModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/05.
//

import SwiftUI
import FirebaseFirestore
import Firebase
import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestoreSwift


class AuthViewModel: NSObject, ObservableObject {
    
    @Published var presentNavigationBar = false //네비게이션바
    @Published var userSession:FirebaseAuth.User?
    @Published var currentUser: UserInfo?
    
    @Published var errorMessage = ""
    @Published var showErrorAlert = false
    
    @Published var sessionId = ""
    
    private var tempCurrentUser: Firebase.User?
    var tempCurrentUsername = ""
    static let shared = AuthViewModel()
    @Published var didAuthenticateUser = false
    
    override init() {
        super.init()
        userSession = Auth.auth().currentUser
        sessionId = UserDefaults.standard.string(forKey: "User") ?? ""
        print("session Id : \(sessionId)")
        
        if let user = Auth.auth().currentUser {
                  self.didAuthenticateUser = true
              }
        
    }
    
    func fetchUser() {
        var uid = ""
        do {
            uid = userSession?.uid ?? ""
            print("AuthViewModel:LOGIN 성공시 petch User: \(uid)")
            print("UserDefaults.standard : \(UserDefaults.standard)")
            
            UserDefaults.standard.set(uid, forKey: "User")
            
        } catch {
            print(error.localizedDescription)
        }
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            if let (errorMessage) = error?.localizedDescription {
                self.showErrorAlert = true
                self.errorMessage = errorMessage
                return
            }
            
            guard let user = try? snapshot?.data(as: UserInfo.self) else { return }
            self.currentUser = user
            self.didAuthenticateUser = true
            print("AuthViewModel:LOGIN 패치 성공 여부 : \(self.currentUser)")
        }
    }
    
    func login(withEmail email: String, password: String) {
        self.errorMessage = ""
        
        //auth 사용자 맞는지 확인
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let (errorMessage) = error?.localizedDescription {
                self.showErrorAlert = true
                self.errorMessage = errorMessage
                return
            }
            
            //auth에서 uid 생성 인증된 사용자 :FirebaseAuth.User? 타입으로 반환
            guard let user = result?.user else { return }
            self.userSession = user
            guard let uid = self.userSession?.uid else {return}
            print("AuthViewModel: login userSession : \(uid)")
            
            self.fetchUser()
        }
    }
    
    func profileImageget() {
        
    }
    
    func uploadProfileImage(_ image: UIImage, completion: @escaping(Bool) -> Void) {
        guard let uid = tempCurrentUser?.uid else {return}
        
        ImageUploader.uploadImage(image: image, folderName: FOLDER_PROFILE_IMAGES, uid: uid) { imageUrl in
            let data: [String: Any] = [KEY_PROFILE_IMAGE_URL : imageUrl]
            
            print("data : \(data)")
            COLLECTION_USERS.document(uid).updateData(data) { error in
                if let errorMessage = error?.localizedDescription {
                    self.showErrorAlert = true
                    self.errorMessage = errorMessage
                    print("errror \(errorMessage)")
                    completion(false)
                    return
                }
            }
            
            self.currentUser?.profileImageUrl = imageUrl
            self.userSession = Auth.auth().currentUser
            self.fetchUser()
        }
    }
    
    
    func dateFormatter() -> String {
        let currentTime = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentTimeString = dateFormatter.string(from: currentTime)
        
        return currentTimeString
    }
    
    
    // MARK: - CHANNEL IMAGE UPLOAD
    func uploadChannelImage(_ image: UIImage, completion: @escaping(Bool) -> Void) {
        guard let uid = currentUser?.uid else { return }
        guard let email = currentUser?.email else { return }
        guard let name = currentUser?.name else { return }
        
        let likeCount = 2
        let bookmarkCount = 3
        let commentCount = 0
        let currentTime = Timestamp()
        let likewho = [String]()
        
        // let folder = "hey/somthing"
        // print("폴더 \(folder)")
        
        // MARK: - 사용자별  CHANNEL 분류 콜렉션
        let collection_dc_add = COLLECTION_CHANNELS.document(uid)
        
        // MARK: - CHANNEL IMAGE UPLOAD STORAGE
        ImageUploader.uploadImage(image: image, folderName: FOLDER_CHANNEL_IMAGES,uid: uid) { imageUrl in
            
            let data: [String: Any] = [
                KEY_CHANNEL_IMAGE_URL : imageUrl,
                "uid":uid,
                "email":email,
                "name":name,
                "likeCount":likeCount,
                "bookmarkCount":bookmarkCount,
                "commentCount":commentCount,
                "timestamp": currentTime,
                "likewho" : likewho
            ]
            
            // MARK: - ALL CHANNEL COLLECTION ZIP ADD
            COLLECTION_CHANNELS.addDocument(data: data) {error in
                if let errorMessage = error?.localizedDescription {
                    self.showErrorAlert = true
                    self.errorMessage = errorMessage
                    completion(false)
                    return
                }
            }
            
            self.currentUser?.profileImageUrl = imageUrl
            self.userSession = Auth.auth().currentUser
            self.fetchUser()
            completion(true)
        }
    }
    
    
    func signOut() {
        
        self.didAuthenticateUser = false
        self.currentUser = nil
        self.userSession = nil
        self.tempCurrentUser = nil
        UserDefaults.standard.removeObject(forKey: "User")
        self.sessionId = ""
        try? Auth.auth().signOut()
        print("로그아웃됐으 \(self.userSession)")
    }
    
    
    func register(withEmail email: String, name: String,password: String) {
        self.errorMessage = ""
        var createUid: String = ""
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let (errorMessage) = error?.localizedDescription {
                self.showErrorAlert = true
                self.errorMessage = errorMessage
                return
            }
            
            guard let user = result?.user else { return }
            self.tempCurrentUser = user
            self.tempCurrentUsername = name
            createUid = String(user.uid)
            
            let data: [String: Any] = [KEY_EMAIL: email,
                                    KEY_USERNAME: name,
                                    KEY_PASSWORD: password,
                                         KEY_UID: createUid
            ]
            
            COLLECTION_USERS.document(user.uid).setData(data) { error in
                if let errorMessage = error?.localizedDescription {
                    self.showErrorAlert = true
                    self.errorMessage = errorMessage
                    return
                }
                self.didAuthenticateUser = true
            }
        }
    }
}
