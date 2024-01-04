//
//  EmptyTestView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/12/18.
//

import SwiftUI
import RealmSwift
import MapKit
import Alamofire

struct EventAddView: View {
    
    let curretnDate: Data = Data()
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MM.dd"
        return formatter
    }()
    
    var body: some View {
        VStack{
            ScrollView{
              catSearchBar
            }
        }
    }
}

@ViewBuilder
private var catSearchBar: some View {

    @State var searchName:String=""
    HStack{
        TextField("등록한 고양이 찾아보기", text: $searchName)
            .padding()
            .padding(.horizontal, 32)
            .background(Color(.systemGroupedBackground))
            .cornerRadius(8)
            .overlay(
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(.systemGray2))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
            )
        
    }
}

#Preview {
    EventAddView()
}
