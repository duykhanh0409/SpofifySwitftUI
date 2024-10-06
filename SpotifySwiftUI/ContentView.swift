//
//  ContentView.swift
//  SpotifySwiftUI
//
//  Created by Khanh Nguyen on 5/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var users:[User] = []
    @State private var products:[Product] = []
    var body: some View {
        ScrollView {
            VStack {
                ForEach(users) { user in
                    Text(user.firstName)
                }
            }
            .padding()
            .task {
                await getData()
            }
        }
    }
    
    private func getData() async{
        do{
            users = try await DatabaseHelper().getUser()
            products = try await DatabaseHelper().getProducts()
        }catch {
            
        }
    }
        
}

#Preview {
    ContentView()
}
