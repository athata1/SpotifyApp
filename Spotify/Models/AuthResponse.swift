//
//  AuthResponse.swift
//  Spotify
//
//  Created by Akhil Thata on 5/15/23.
//

import Foundation

struct AuthResponse: Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String?
    let token_type: String
}
