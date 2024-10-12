//
//  SpofityCategoryCell.swift
//  SpotifySwiftUI
//
//  Created by Khanh Nguyen on 12/10/24.
//

import SwiftUI

struct SpofityCategoryCell: View {
    var title:String = "Music"
    var isSelected: Bool = false
    var body: some View {
        Text(title)
            .font(.callout)
            .padding(.vertical,8)
            .padding(.horizontal,10)
            .background(isSelected ? .spotifyGreen : .spotifyDarkGray)
            .foregroundColor(isSelected ? .spotifyBlack : .spotifyWhite)
            .cornerRadius(16)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack(content: {
            SpofityCategoryCell(title: "Title gose here")
            SpofityCategoryCell(title: "Title gose here", isSelected: true)
            SpofityCategoryCell(title: "Title gose here", isSelected: false)
        })
    }
}
