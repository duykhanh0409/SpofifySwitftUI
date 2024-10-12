//
//  SpotifyHomeView.swift
//  SpotifySwiftUI
//
//  Created by Khanh Nguyen on 12/10/24.
//

import SwiftUI

struct SpotifyHomeView: View {
    
    @State private var currentUser:User? = nil
    @State private var selectedCategory: CategoryList? = nil
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            ScrollView(.vertical) {
                LazyVStack(spacing: 1, pinnedViews: [.sectionHeaders], content: {
                    Section {
                        
                    } header: {
                        header
                    }

                })
                .padding(.top,8)
            }
            .scrollIndicators(.hidden)
            .clipped()
           
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func getData() async{
        do{
            currentUser = try await DatabaseHelper().getUser().first
          
        }catch {
            
        }
    }
    
    private var header: some View {
        HStack(spacing: 16,content: {
            ZStack(content: {
                if let currentUser {
                    ImageLoaderView(urlString: currentUser.image)
                        .frame(width: 30, height: 30)
                        .background(.spotifyWhite)
                        .clipShape(.circle)
                }
            }).frame(width: 35, height: 35)
            
            ScrollView(.horizontal) {
                HStack(spacing: 8, content: {
                    ForEach(CategoryList.allCases, id: \.self) { category in
                        SpofityCategoryCell(title: category.rawValue.capitalized, isSelected: category == selectedCategory)
                        
                    }
                })
            }
            .scrollIndicators(.hidden)
        })
        .padding(.vertical, 24)
        .padding(.leading, 8)
    }
}

#Preview {
    SpotifyHomeView()
}
