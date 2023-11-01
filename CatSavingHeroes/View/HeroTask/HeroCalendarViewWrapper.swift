//
//  HeroCalendarViewWrapper.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/10.
//

import SwiftUI
import UIKit

//Uikit을 변형해주는 코드
struct HeroCalendarViewWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> HeroCalendarViewController {
        return HeroCalendarViewController()
    }

    func updateUIViewController(_ uiViewController: HeroCalendarViewController, context: Context) {
        // Update the view controller if needed
    }
}

struct HeroCalendarView: View {
    var body: some View {
        ZStack {
            ScrollView {
                HeroCalendarViewWrapper()
            }
            
            VStack {
                Spacer()

                // ["star.fill", "triangle.fill", "square.fill", "circle.fill", "heart.fill"]
                // ["찾음", "밥줌", "인사", "놀이", "아픔"]
                HStack(spacing: 10) {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.purple)
                    Text("찾음 = ")
                        .font(.headline)
                    Image("found")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Image(systemName: "triangle.fill")
                        .foregroundColor(Color.green)
                        .padding(.leading, 30)
                    Text("밥줌 = ")
                        .font(.headline)
                    Image("feeding")
                        .resizable()
                        .frame(width: 20, height: 20)
                        
                    Spacer()
                }
                .padding(10)

                HStack(spacing: 10) {
                    Image(systemName: "square.fill")
                        .foregroundColor(Color.blue)
                    Text("인사 = ")
                        .font(.headline)
                    Image("greeting")
                        .resizable()
                        .frame(width: 20, height: 20)

                    Image(systemName: "circle.fill")
                        .foregroundColor(Color.brown)
                        .padding(.leading, 30)
                    Text("놀이 = ")
                        .font(.headline)
                    Image("play")
                        .resizable()
                        .frame(width: 20, height: 20)

                    Spacer()
                }
                .padding(10)

                HStack(spacing: 10) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(Color.red)
                    Text("아픔 = ")
                        .font(.headline)
                    Image("pain")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Spacer()
                }
                .padding(10)
            }
            .padding()
            .padding(.bottom, 15)
        }
    }
}
