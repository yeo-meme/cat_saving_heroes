//
//  StatusSelectorView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/31.
//

import SwiftUI

struct StatusSelectorView: View {
    @ObservedObject var viewModel: EditProfileViewModel
    @Environment(\.presentationMode) var mode
    
    init(_ viewModel: EditProfileViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 32){
                    VStack(alignment: .leading) {
                        Text("최근 상태")
                            .font(.system(size: 14))
                            .padding(.leading)
                            .foregroundColor(Color(.systemGray2))
                        
                        StatusCell(status: viewModel.user.status, isSelected: false)
                    }
                    .padding(.top, 32)

                    
                    VStack(alignment: .leading) {
                        Text("상태를 선택하세요")
                            .font(.system(size: 14))
                            .padding(.leading)
                            .foregroundColor(Color(.systemGray2))
                        
                        VStack(spacing: 1) {
                            CustomDivider(leadingSpace: 0)
                            
                            ForEach(Status.allCases, id: \.self) { status in
                                Button(action: {
                                    viewModel.selectedStatus = status
                                    mode.wrappedValue.dismiss()
                                }, label: {
                                    StatusCell(status: status,
                                               isSelected: viewModel.user.status == status)
                                })
                            }
                        }
                        
                    }
                    .padding(.top)
                }
            }
        }
        .showErrorMessage(showAlert: $viewModel.showErrorAlert, message: viewModel.errorMessage)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("상태 변경")
    }
}


