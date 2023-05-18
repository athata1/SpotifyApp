//
//  RecommendationResponse.swift
//  Spotify
//
//  Created by Akhil Thata on 5/17/23.
//

import Foundation

struct RecommendationsResponse: Codable {
    let tracks: [AudioTrack]
}

