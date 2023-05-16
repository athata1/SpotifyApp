//
//  UserProfile.swift
//  Spotify
//
//  Created by Akhil Thata on 5/15/23.
//

import Foundation

struct UserProfile: Codable {
    let country: String
    let display_name: String
    let email:String
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
    let followers: Followers
    let href: String
    let id: String
    let product: String
    let images: [UserImage]
}

struct UserImage: Codable {
    let url: String
}

struct Followers: Codable {
    let total: Int
}
