//
//  AlbumViewController.swift
//  Spotify
//
//  Created by Akhil Thata on 5/20/23.
//

import UIKit

class AlbumViewController: UIViewController {
    
    private var album: Album
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = album.name
        view.backgroundColor = .systemBackground
        
        fetchData()
    }
    
    private func fetchData() {
        APICaller.shared.getAlbumDetails(for: album) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
    }
    
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
