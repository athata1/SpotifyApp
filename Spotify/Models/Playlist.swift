//
//  Playlist.swift
//  Spotify
//
//  Created by Akhil Thata on 5/15/23.
//

import Foundation

struct FeaturedPlaylistResponse: Codable {
    let message: String
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}

struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}

struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
}
