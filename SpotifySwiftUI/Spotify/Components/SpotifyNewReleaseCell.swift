//
//  SpotifyNewReleaseCell.swift
//  SpotifySwiftUI
//
//  Created by Khanh Nguyen on 13/10/24.
//

import SwiftUI

struct SpotifyNewReleaseCell: View {
    var imageName:String  = Constants.romdomImage
    var headLine: String? = "some Artist"
    var subheadLine: String? = "some Artist"
    var title: String? = "Some playlist"
    var subTitle: String? = "Single - title"
    
    var onAddToPlaylistPressed: (()->Void)? = nil
    var onPlayPressed:(()->Void)? = nil
    
    var body: some View {
        VStack(spacing: 16, content: {
            HStack(content: {
                ImageLoaderView(urlString: imageName)
                    .frame(width: 50, height: 50)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                VStack(alignment: .leading,spacing: 2, content: {
                    if let headLine {
                        Text(headLine)
                            .foregroundStyle(.spotifyLightGray)
                            .font(.callout)
                    }
                    
                    if let subheadLine {
                        Text(subheadLine)
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(.spotifyWhite)
                            .font(.callout)
                    }
                })
                .frame(maxWidth: .infinity, alignment: .leading)
            })
            
            HStack {
                ImageLoaderView(urlString: imageName)
                    .frame(width: 140, height: 140)

                VStack(alignment: .leading,spacing: 32, content: {
                    VStack(alignment:.leading, spacing: 2, content: {
                        if let title {
                            Text(title)
                                .fontWeight(.semibold)
                                .foregroundStyle(.spotifyWhite)
                        }
                        
                        if let subTitle {
                            Text(subTitle)
                                .foregroundStyle(.spotifyLightGray)
                        }
                    })
                    .font(.callout)
                    
                    HStack(spacing: 0){
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.spotifyLightGray)
                            .font(.title3)
                            .padding(4)
                            .background(Color.black.opacity(0.001))
                            .onTapGesture {
                                onAddToPlaylistPressed?()
                            }
                            .offset(x: -4)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "play.circle.fill")
                            .foregroundStyle(.spotifyWhite)
                            .font(.title2)
                    }
                    .padding(.bottom,8)
                    
                })
                .padding(.trailing,16)
            }
            .themeColors(isSelected: false)
            .cornerRadius(8)
            .onTapGesture {
                onPlayPressed?()
            }
        })
    }
}

#Preview {
    ZStack(content: {
        Color.black.ignoresSafeArea()
        
        SpotifyNewReleaseCell()
            .padding()
    })
}
