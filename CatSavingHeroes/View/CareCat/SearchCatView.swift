//
//  SearchCatView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/12.
//

import SwiftUI
import RealmSwift


struct SearchCatView: View {
    @State private var searchText = ""
    @State var cats: [Cat] = []

    
    var body: some View {
        NavigationView{
            VStack{
                // SearchBar(text: $searchText)
                
                List(cats){ cat in
                    Text(cat.name)
                }.listStyle(PlainListStyle())
            }.navigationBarTitle("Cat List")
        }
    }
}

#Preview {
    SearchCatView()
}
