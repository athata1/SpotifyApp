//
//  SettingsModels.swift
//  Spotify
//
//  Created by Akhil Thata on 5/16/23.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
