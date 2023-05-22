//
//  AlbumDetailsResponse.swift
//  Spotify
//
//  Created by Akhil Thata on 5/20/23.
//

import Foundation

struct AlbumDetailsResponse: Codable {
    let album_type: String
    let artists: [Artist]
    let available_markets: [String]
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let label: String
    let name: String
    let popularity: Int
    let tracks: TracksResponse
}

struct TracksResponse: Codable {
    let items: [AudioTrack]
}

//struct AudioTrack: Codable {
//    let album: Album
//    let artists: [Artist]
//    let available_markets: [String]
//    let disc_number: Int
//    let duration_ms: Int
//    let explicit: Bool
//    let external_urls: [String: String]
//    let id: String
//    let name: String
//    let popularity: Int
//
//}

//{
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/track/7ro0hRteUMfnOioTFI5TG1";
//                };
//                href = "https://api.spotify.com/v1/tracks/7ro0hRteUMfnOioTFI5TG1";
//                id = 7ro0hRteUMfnOioTFI5TG1;
//                "is_local" = 0;
//                name = "WHERE SHE GOES";
//                "preview_url" = "https://p.scdn.co/mp3-preview/b9b7e4c982b33ee23c4867f7a3025e3598c35760?cid=34ce4c4ccbe44b53b5c6e9b2830c4a5b";
//                "track_number" = 1;
//                type = track;
//                uri = "spotify:track:7ro0hRteUMfnOioTFI5TG1";
//            }
//        );
//        limit = 50;
//        next = "<null>";
//        offset = 0;
//        previous = "<null>";
//        total = 1;
//    };
//    type = album;
//    uri = "spotify:album:5gCcb5fsSb6w5K8SyJrgtB";
//}
