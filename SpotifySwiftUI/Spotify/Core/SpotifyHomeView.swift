//
//  SpotifyHomeView.swift
//  SpotifySwiftUI
//
//  Created by Khanh Nguyen on 12/10/24.
//

import SwiftUI

struct SpotifyHomeView: View {
    
    @State private var currentUser:User? = nil
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            HStack(content: {
                if let currentUser {
                    ImageLoaderView(urlString: currentUser.image)
                        .frame(width: 30, height: 30)
                        .background(.spotifyWhite)
                        .clipShape(.circle)
                }
                ScrollView(.horizontal) {
                    HStack(spacing: 8, content: {
                        ForEach(0..<20) { _ in
                            Rectangle()
                                .fill(Color.red)
                                .frame(width: 10, height: 10)
                        }
                    })
                }
                .scrollIndicators(.hidden)
            })
        }
        .task {
            await getData()
        }
    }
    
    private func getData() async{
        do{
            currentUser = try await DatabaseHelper().getUser().first
          
        }catch {
            
        }
    }
}

#Preview {
    SpotifyHomeView()
}
