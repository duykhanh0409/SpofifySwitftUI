//
//  ImageLoaderView.swift
//  SpotifySwiftUI
//
//  Created by Khanh Nguyen on 6/10/24.
//

import SwiftUI
import SDWebImageSwiftUI


struct ImageLoaderView: View {
    var urlString: String = Constants.romdomImage
    var resizingModel: ContentMode = .fill
    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay(content: {
                WebImage(url: URL(string: urlString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: resizingModel)
                .allowsHitTesting(false)
            })
    }
        
}

#Preview {
    ImageLoaderView()
        .cornerRadius(30)
        .padding(40)
        .padding(.vertical,60)
}
