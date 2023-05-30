//
//  Artist.swift
//  Spotify
//
//  Created by Akhil Thata on 5/15/23.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let images: [APIImage]?
    let external_urls: [String: String]
}
