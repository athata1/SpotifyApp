//
//  NewReleaseCollectionViewCell.swift
//  Spotify
//
//  Created by Akhil Thata on 5/18/23.
//

import UIKit
import SDWebImage

//struct NewReleasesCellViewModel {
//    let name: String
//    let artwork_url: URL?
//    let numberOfTracks: Int
//    let artistName: String
//}


class NewReleaseCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewReleaseCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let albumNameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 0;
        return label;
    }()
    
    private let numberOfTracksLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = 0;
        return label;
    }()
    
    private let artistNameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0;
        return label;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(numberOfTracksLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.height - 10
        let albumLabelSize = albumNameLabel.sizeThatFits(CGSize(width: contentView.width - imageSize - 10, height: min(80,contentView.height - 10)))
        
        artistNameLabel.sizeToFit()
        numberOfTracksLabel.sizeToFit()

        albumCoverImageView.frame = CGRect(x: 5, y: 5, width: imageSize, height: imageSize)
        
        albumNameLabel.frame = CGRect(x: albumCoverImageView.right + 10, y: 5, width: albumLabelSize.width, height: min(50, albumLabelSize.height))
        
        artistNameLabel.frame = CGRect(x: albumCoverImageView.right + 10, y: albumNameLabel.bottom+5, width: contentView.width - albumCoverImageView.right - 5, height: min(50, albumLabelSize.height))
        
        numberOfTracksLabel.frame = CGRect(x: albumCoverImageView.right + 10, y: albumCoverImageView.bottom - numberOfTracksLabel.height, width: numberOfTracksLabel.width + 10, height: numberOfTracksLabel.height)
        
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumNameLabel.text = nil
        artistNameLabel.text = nil
        numberOfTracksLabel.text = nil
        albumCoverImageView.image = nil
        
    }
    
    func configure(with viewModel: NewReleasesCellViewModel) {
        albumNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        numberOfTracksLabel.text = "Tracks: \(viewModel.numberOfTracks)"
        albumCoverImageView.sd_setImage(with: viewModel.artwork_url, completed: nil)
    }
}
