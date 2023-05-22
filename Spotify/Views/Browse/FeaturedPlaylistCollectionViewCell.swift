//
//  FeaturedPlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by Akhil Thata on 5/18/23.
//

import UIKit

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturedPlaylistCollectionViewCell"
    
    private let playlistCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let playlistNameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0;
        label.textAlignment = .center
        return label;
    }()
    
    private let creatorNameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.numberOfLines = 0;
        label.textAlignment = .center
        return label;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(playlistCoverImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(creatorNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize = contentView.height * 0.5
        playlistCoverImageView.frame = CGRect(x: (contentView.width - imageSize)/2, y: 3, width: imageSize, height: imageSize)
        playlistCoverImageView.layer.masksToBounds = true
        playlistCoverImageView.layer.cornerRadius = 8
        
        playlistNameLabel.sizeToFit()
        playlistNameLabel.frame = CGRect(x: 3, y: playlistCoverImageView.bottom + 3, width: contentView.width - 6, height: playlistNameLabel.height + 10)
        
        creatorNameLabel.sizeToFit()
        creatorNameLabel.frame = CGRect(x: 3, y: playlistNameLabel.bottom + 3, width: contentView.width - 6, height: creatorNameLabel.height)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playlistNameLabel.text = nil
        creatorNameLabel.text = nil
        playlistCoverImageView.image = nil
        
    }
    
    func configure(with viewModel: FeaturedPlaylistCellViewModel) {
        playlistNameLabel.text = viewModel.name
        creatorNameLabel.text = viewModel.creatorName
        playlistCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}
