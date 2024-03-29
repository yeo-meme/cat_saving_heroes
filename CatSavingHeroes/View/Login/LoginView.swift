//
//  LoginView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/05.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isIndicatorAnimating = false
    // @EnvironmentObject private var userData: UserData
    
    @State private var email:String = ""
    @State private var password:String = ""
    @State private var isLoggedIn : Bool = false
    
    @State private var isEmailEditing: Bool = false
    @State private var isPwEditing: Bool = false
    
    @State private var showingSignUpView: Bool = false
    @State private var isViewPresented = false
    
    @State private var textFieldValue: String = ""
    
    var body: some View {
        NavigationView {
            VStack{
                VStack(alignment: .leading, spacing: 30){
                    Spacer()
                    
                    HStack {
                       Spacer()
                        Image("main_cat")
                            .resizable()
                            .frame(width: 200, height: 100)
                             // .padding(.bottom, 20)
                        Spacer()
                    }
            
                    IntroParagraph(title1: "냐옹.", title2: "Welcome Back")
                    
                    // IntroParagraph(title1: "냐옹", title2: "고양이의 안전을 위해 당신 누구인지 밝혀라")
                    
                    
                    TextField("email",text: $email, onEditingChanged: { editing in isEmailEditing = editing }
                    )
                    .padding()
                    .autocapitalization(.none)
                    .background(Color(UIColor.black))
                    .foregroundColor(.white)
                    .overlay(
                        Text("email")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(isEmailEditing ? .black : .white )
                            .opacity(email.isEmpty ? 1 : 0)
                            .font(.system(size: 24, weight: .bold,
                                          design: .default))
                            .padding(.leading,20)
                    )
                    .cornerRadius(9)
                    .padding(.trailing, 32)
                    .padding(.leading, 32)
                    
                    
                    TextField("6자리 이상 비밀번호", text: $password, onEditingChanged: {editing in
                        isPwEditing = editing})
                    .padding()
                    .autocapitalization(.none)
                    .background(Color(UIColor.black))
                    .foregroundColor(.white)
                    .overlay(
                        Text("비밀번호")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(isPwEditing ? .black : .white)
                            .opacity(password.isEmpty ? 1 : 0)
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .padding(.leading, 20)
                    )
                    .cornerRadius(9)
                    .padding(.trailing, 32)
                    .padding(.leading, 32)
                    
                    
                    VStack(spacing: 20){
                            // Button(action: {
                            //     viewModel.login(withEmail: email, password: password)
                            //     UserDefaults.standard.set(password, forKey: "password")
                            //     UserDefaults.standard.set(email, forKey: "email")
                            // })
                            // {
                            //     Text("로그인")
                            // }
                            // .frame(width: 100, height: 70)
                         
                            
                            CapsuleButton(text: "Sign In",
                                          disabled: email.count < 5 || password.count < 5,
                                          isAnimating: isIndicatorAnimating && viewModel.errorMessage == "",
                                          action: {
                                                isIndicatorAnimating = true
                                                viewModel.login(withEmail: email, password: password)
                                          })
                            
                            
                            // CapsuleButton(text: "log In",
                            //               disabled: email.count < 5 || password.count < 6,
                            //               isAnimating: isIndicatorAnimating && viewModel.errorMessage == "",
                            //               action: {
                            //                     isIndicatorAnimating = true
                            //                     viewModel.login(withEmail: email, password: password)
                            //               })
                            
                            
                            // Button(action: {
                            //     // userData.isLoggedIn = false
                            //     self.showingSignUpView.toggle()
                            //     
                            // }) {
                            //     Text("회원가입")
                            // }
                            // .frame(width: 100, height: 70)
                            
                        // 
                        // .frame(maxWidth: .infinity)
                        // .foregroundColor(.black)
                    }
                    Spacer()
                    
                }//:VSTACK
                // .padding(.top, -70)
                
                Spacer()
                
                NavigationLink(
                    destination: SignUpView()
                        .navigationBarBackButtonHidden(true),
                    label: {
                        HStack {
                            Text("Don't have an account?").font(.system(size: 14))
                            Text("Sign Up").font(.system(size: 14, weight: .semibold))
                        }
                    }).padding(.bottom, 32)
                
            }//: VStack
            // .sheet(isPresented: $showingSignUpView) {
            //     SignUpView(isViewPresented: $isViewPresented).environment(\.managedObjectContext, self.managedObjectContext)
            // }
            .onAppear{
                if let savedUserID = UserDefaults.standard.string(forKey: "email") {
                    email = savedUserID
                }
                if let savedPassword = UserDefaults.standard.string(forKey: "password") {
                    password = savedPassword
                }
            }
        }
    }//: BODY VIEW
    }

#Preview {
    LoginView()
}
