//
//  CategoryPlaylistResponse.swift
//  Spotify
//
//  Created by Akhil Thata on 5/25/23.
//

import Foundation

struct CategoryPlaylistResponse: Codable {
    let playlists: CategoryPlaylist
}

struct CategoryPlaylist: Codable {
    let items: [Playlist?]
}
