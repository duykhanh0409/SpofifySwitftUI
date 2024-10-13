//
//  SpotifyHomeView.swift
//  SpotifySwiftUI
//
//  Created by Khanh Nguyen on 12/10/24.
//

import SwiftUI
import SwiftfulUI

struct SpotifyHomeView: View {
    
    @State private var currentUser:User? = nil
    @State private var selectedCategory: CategoryList? = nil
    @State private var productList:[Product] = []
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            ScrollView(.vertical) {
                LazyVStack(spacing: 1,
                           pinnedViews: [.sectionHeaders],
                           content: {
                    Section {
                        VStack{
                            recentsSection
                            if let product = productList.first {
                                newReleaseSection(product: product)
                            }
                           
                        }
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
            productList = try await Array(DatabaseHelper().getProducts().prefix(8))
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
                            .onTapGesture {
                                selectedCategory = category
                            }
                        
                    }
                })
            }
            .scrollIndicators(.hidden)
        })
        .padding(.vertical, 24)
        .padding(.leading, 8)
    }
    
    private var recentsSection: some View {
        NonLazyVGrid(columns:2, alignment: .center, spacing: 10, items: productList) { product in
            if let product {
                SpotifyRecentsCell(imageName: product.firstImage, title: product.title)
            }
        }
    }
    
    private func newReleaseSection(product: Product)-> some View {
        SpotifyNewReleaseCell(
            imageName: product.firstImage,
            headLine: product.brand,
            subheadLine: product.category.rawValue,
            title: product.title,
            subTitle: product.description,
            onAddToPlaylistPressed: {
                
            },
            onPlayPressed: {
                
            }
        )
    }
}

#Preview {
    SpotifyHomeView()
}
