//
//  User.swift
//  SpotifySwiftUI
//
//  Created by Khanh Nguyen on 6/10/24.
//

import Foundation

/// User
struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}

// MARK: - User
struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName, maidenName: String
    let age: Int
    let email, phone, username, password: String
    let birthDate: String
    let image: String
    let bloodGroup: String
    let eyeColor: String
    let ip: String
 
}
