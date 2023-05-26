//
//  GenreCollectionViewCell.swift
//  Spotify
//
//  Created by Akhil Thata on 5/25/23.
//

import UIKit
import SDWebImage
class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "GenreCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        return imageView
    }()
    
    private let genreTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let colors: [UIColor] = [
        .systemPink,
        .systemBlue,
        .systemPurple,
        .systemGreen,
        .systemRed,
        .systemYellow,
        .darkGray,
        .systemMint,
        .systemTeal
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(genreTitleLabel)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        genreTitleLabel.text = nil
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
    }
    
    func configure(with viewModel: CategoryCollectionViewCellViewModel) {
        genreTitleLabel.text = viewModel.name
        imageView.sd_setImage(with: viewModel.artworkUrl)
        contentView.backgroundColor = colors.randomElement()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        genreTitleLabel.frame = CGRect(x: 10, y: contentView.height/2, width: contentView.width - 20, height: contentView.height/2)
        
        imageView.frame = CGRect(x: contentView.width - contentView.height/2 - 10, y: 10, width: contentView.height/2, height: contentView.height/2)
    }
}
