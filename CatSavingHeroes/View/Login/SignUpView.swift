//
//  SignUpView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/05.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore



struct SignUpView: View {
    
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    //View 컨텍스트에서 제공되는 환경 속성입니다. 이 속성은 현재 뷰가 표시되는 방식과 관련된 정보를 제공
    // 프로퍼티 래퍼는 구조체에서 사용될 때만 사용할 수 있습니다
    @Environment(\.presentationMode) var presentationMode
    // @EnvironmentObject private var userData: UserData
    
    @Binding var isViewPresented :Bool
    
    @State private var email: String = ""
    @State private var password:String = ""
    @State private var name: String = ""
    
    @State private var isCompleteClose = false
    @State private var showAlert = false
    @State private var showingSignUpView = false
    
    
    @State private var phoneNumber = ""
        @State private var verificationCode = ""
        @State private var isCodeSent = false
        @State private var user: User?
        @State private var error: Error?
    
    var body: some View {
        NavigationView{
            VStack {
                NavigationLink(
                    destination: ProfilePhotoSelectorView() ,
                    isActive: $viewModel.didAuthenticateUser,
                    label: {})
                // VStack {
                //             if isCodeSent {
                //                 TextField("인증 코드 입력", text: $verificationCode)
                //                     .padding()
                //                 Button("인증 확인") {
                //                     verifyPhoneNumber()
                //                 }
                //             } else {
                //                 TextField("전화번호 입력", text: $phoneNumber)
                //                     .keyboardType(.numberPad)
                //                     .padding()
                //                 Button("인증 코드 받기") {
                //                     sendVerificationCode()
                //                 }
                //             }
                // 
                //             if let error = error {
                //                 Text("오류: \(error.localizedDescription)")
                //             }
                // 
                //             if let user = user {
                //                 Text("로그인 성공! 사용자 ID: \(user.uid)")
                //             }
                //         }
                
                IntroParagraph(title1: "간편한 회원가입을 통해", title2: "고양이를 돕는 영웅들이 되어보세요")
                    .padding(.horizontal, -10)
                    .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    // HStack{
                    //     TextField("-없이 숫자만 입력해주세요", text: $email)
                    //         .autocapitalization(.none)
                    //         .padding()
                    //         .background(Color(UIColor.tertiarySystemFill))
                    //         .cornerRadius(9)
                    //         .font(.system(size: 24,weight: .bold, design: .default))
                    //     
                    //     Button(action: {
                    //         
                    //     }, label: {
                    //         Text("인증코드 전송")
                    //             .font(.system(size: 24, weight: .bold, design: .default))
                    //             .padding()
                    //             .background(Color.blue)
                    //             .foregroundColor(.white)
                    //             .cornerRadius(9)
                    //     })
                    //     
                    // }
                    
                    TextField("email을 입력해주세요", text: $email)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9)
                        .font(.system(size: 24,weight: .bold, design: .default))
                    
                    
                    SecureField("비밀번호", text:$password)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9)
                        .font(.system(size: 24,weight: .bold, design: .default))
                    
                    TextField("닉네임", text: $name)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9)
                        .font(.system(size: 24, weight: .bold,
                                      design: .default))
                    
                    //: BUTTON 완료
                    Button(action: {
                        if checkSignUpCondition() {
                            viewModel.register(withEmail: email, name: name, password: password)
                        } else {
                            
                        }
                        
                        
                    }) {
                        Text("회원가입 완료")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .padding()
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(9)
                    }//: 회원가입 완료버튼 BUTTON
                }//:VSTACK
                .padding(.horizontal)
                .padding(.vertical, 30)
                
                Spacer()
                
            }//:VSTACK
            .navigationBarTitle("회원가입", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            })
                                {
                Image(systemName: "xmark")
            }
            )
            .accentColor(Color.black)
        }//:NAVIGATIONVEIW
    }
    private func sendVerificationCode() {
           PhoneAuthProvider.provider().verifyPhoneNumber(
               phoneNumber,
               uiDelegate: nil
           ) { verificationID, error in
               if let error = error {
                   self.error = error
                   return
               }
               UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
               self.isCodeSent = true
           }
       }
    
    private func verifyPhoneNumber() {
            let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID ?? "", verificationCode: verificationCode)
            
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    self.error = error
                    return
                }
                
                if let user = result?.user {
                    self.user = user
                    saveUserDataToFirestore(user)
                }
            }
        }

        private func saveUserDataToFirestore(_ user: User) {
            let db = Firestore.firestore()
            let userRef = db.collection("users").document(user.uid)
            let userData = ["phone_number": user.phoneNumber ?? ""]
            
            userRef.setData(userData) { error in
                if let error = error {
                    self.error = error
                }
            }
        }
    
    private func checkSignUpCondition () -> Bool {
        if name.isEmpty ||  email.isEmpty || password.isEmpty {
            return false
        }
        return true
    }
}

// #Preview {
//     SignUpView()
// }
