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
    @State private var productRow:[ProductRow] = []
    
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
                                .padding(.horizontal,16)
                            if let product = productList.first {
                                newReleaseSection(product: product)
                                    .padding(.horizontal,16)
                            }
                            listRows
                           
                            
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
            
            var rows: [ProductRow] = []
            let allBrands = Set(productList.map({$0.brand}))
            
            for brand in allBrands {
                guard let brand = brand else {return}
                rows.append(ProductRow(title: brand.capitalized, products: productList))
            }
            
            productRow = rows
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
                HStack(alignment:.top, spacing: 16, content: {
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
                    .asButton(.press) {
                        
                    }
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
    
    private var listRows: some View {
        ForEach(productRow) { row in
            VStack(spacing:8){
                Text(row.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.spotifyWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal,16)
                    
                ScrollView(.horizontal) {
                    HStack{
                        ForEach(row.products){ product in
                            ImageTitleRowCell(imageSize: 120, imageName: product.firstImage, title: product.title )
                                .asButton(.press) {
                                    
                                }
                        }
                    }
                    .padding(.horizontal,16)
                }
            }
        }
    }
}

#Preview {
    SpotifyHomeView()
}
