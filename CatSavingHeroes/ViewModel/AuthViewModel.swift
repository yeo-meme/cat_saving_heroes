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
import RealmSwift
import Alamofire

class AuthViewModel: NSObject, ObservableObject {
    
    @Published var presentNavigationBar = false //네비게이션바
    @Published var userSession:FirebaseAuth.User?
    @Published var currentUser: FireStoreUser?
    
    @Published var errorMessage = ""
    @Published var showErrorAlert = false
    
    @Published var sessionId = ""
    
    private var tempCurrentUser: Firebase.User?
    var tempCurrentUsername = ""
    static let shared = AuthViewModel()
    @Published var didAuthenticateUser = false
    @Published var didLoginState = false //메인변경ㅂㅍ
    
    
    override init() {
        super.init()
        userSession = Auth.auth().currentUser
        sessionId = UserDefaults.standard.string(forKey: "User") ?? ""
        print("session Id : \(sessionId)")
        
        self.allRoadUserInfoAPI()
        // if let user = Auth.auth().currentUser {
        //           self.didAuthenticateUser = true
        //       }
        
        //리얼엠 마이그레이션
        let config = Realm.Configuration(
            schemaVersion: 0, // 스키마 버전을 0으로 설정
            deleteRealmIfMigrationNeeded: true // 마이그레이션이 필요한 경우 Realm 삭제
        )
        Realm.Configuration.defaultConfiguration = config
        
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
            
            guard let user = try? snapshot?.data(as: FireStoreUser.self) else { return }
            self.currentUser = user
            self.didAuthenticateUser = true
            self.didLoginState = true
            
            //로그인창 기록
            UserDefaults.standard.set(user.email,forKey: "email")
            UserDefaults.standard.set(user.password,forKey: "password")
            
            print("AuthViewModel:LOGIN 패치 성공 여부 : \(self.currentUser)")
        }
    }
    
    func login(withEmail email: String, password: String) {
        self.errorMessage = ""
        
        //auth 사용자 맞는지 확인
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let (errorMessage) = error?.localizedDescription {
                print("로그인 오류 : \(error?.localizedDescription)")
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
    
    func allRoadUserInfoAPI() {
        AF.request(USER_INFO_ALL_ROAD, method: .post,  encoding: JSONEncoding.default)
            .responseDecodable(of: UserInfo.self) { response in
                switch response.result {
                case .success(let userInfo):
                    // 성공적으로 데이터를 받았을 때
                    print("allRoadUserInfoAPI POST DEBUG : \(userInfo)")
                case .failure(let error):
                    // 요청 또는 응답이 실패했을 때
                    print("allRoadUserInfoAPI failed with error: \(error)")
                }
            }
    }
    
    // func uploadProfileImage(_ image: UIImage, completion: @escaping(Bool) -> Void) {
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = tempCurrentUser?.uid else {return}
        
        ImageUploader.uploadImage(image: image, folderName: FOLDER_PROFILE_IMAGES, uid: uid) { imageUrl in
            let data: [String: Any] = [KEY_PROFILE_IMAGE_URL : imageUrl]
            
            print("data : \(data)")
            COLLECTION_USERS.document(uid).updateData(data) { error in
                if let errorMessage = error?.localizedDescription {
                    self.showErrorAlert = true
                    self.errorMessage = errorMessage
                    print("errror \(errorMessage)")
                    // completion(false)
                    return
                }
            }
            
            self.currentUser?.profileImageUrl = imageUrl
            self.userSession = Auth.auth().currentUser
            self.fetchUser()
            self.addUserInfoCallData()
        }
    }
    
    
    func addUserInfoCallData(){
        guard let uid = tempCurrentUser?.uid else {return}
        print("AuthViewModel: addUserInfoAPI LOGIN 성공시 petch User: \(uid)")
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            if let (errorMessage) = error?.localizedDescription {
                self.showErrorAlert = true
                self.errorMessage = errorMessage
                return
            }
            
            guard let user = try? snapshot?.data(as: FireStoreUser.self) else { return }
            self.currentUser = user
            // self.didAuthenticateUser = true
            // self.didLoginState = true
            
            // print("AuthViewModel:LOGIN 패치 성공 여부 : \(self.currentUser)")
            // Firebase에서 사용자 정보를 가져온 후에 아래 코드를 실행
              if let userName = self.currentUser?.name, let userEmail = self.currentUser?.email, let userId = self.currentUser?.id {
                  print("API에 넣을 데이터: 이름: \(userName), 이메일: \(userEmail), ID: \(userId)")
                  
       
                  // 이곳에서 API 호출 또는 다른 작업을 수행
                  
                  let jsonData = [
                      "user_uuid": userId,
                      "user_email": userEmail,
                      "user_name": userName,
                      "track_uuids":[],
                      "see_cat_ids":[],
                      "interest_cat_ids":[],
                      "care_cat_ids":[],
                  ] as [String : Any] // 데이터를 JSON 형식으로 준비
                  self.uploadingUserInfo(jsonData: jsonData)
              }
        }
        
        
        
    }
    
    func uploadingUserInfo(jsonData:[String:Any]){
        do {
            AF.request(USER_INFO_ADD, method: .post, parameters: jsonData, encoding: JSONEncoding.default)
                .responseDecodable(of: UserInfo.self) { response in
                    switch response.result {
                    case .success(let userInfo):
                        // 성공적으로 데이터를 받았을 때
                        print("UserInfo POST DEBUG : \(userInfo)")
                    case .failure(let error):
                        // 요청 또는 응답이 실패했을 때
                        print("Request failed with error: \(error)")
                    }
                }
        } catch {
            print("디코딩 에러: \(error)")
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
        self.didLoginState = false
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
                print("오류냐내용 : \(error?.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.tempCurrentUser = user
            self.tempCurrentUsername = name
            
            // createUid = String(user.uid)
            
            let data: [String: Any] = [KEY_EMAIL: email,
                                    KEY_USERNAME: name,
                                    KEY_PASSWORD: password,
                                         KEY_UID: createUid,
                                      KEY_STATUS: Status.available.rawValue
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
