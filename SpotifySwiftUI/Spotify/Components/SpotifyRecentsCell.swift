//
//  SpotifyRecentsCell.swift
//  SpotifySwiftUI
//
//  Created by Khanh Nguyen on 13/10/24.
//

import SwiftUI

struct SpotifyRecentsCell: View {
    var imageName: String = Constants.romdomImage
    var title: String = "khanh nguyen"
    var body: some View {
        HStack(spacing: 16, content: {
           ImageLoaderView(urlString: imageName)
                .frame(width: 55, height: 55)
            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .lineLimit(2)
               
        })
        .padding(.trailing,8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .themeColors(isSelected: false)
        .cornerRadius(6)
    }
}

#Preview {
    ZStack(content: {
        Color.black.ignoresSafeArea()
       
        
        VStack{
            HStack{
                SpotifyRecentsCell()
                SpotifyRecentsCell()
            }
            HStack{
                SpotifyRecentsCell()
                SpotifyRecentsCell()
            }
            
            HStack{
                SpotifyRecentsCell()
                SpotifyRecentsCell()
            }
        }
    })
}
