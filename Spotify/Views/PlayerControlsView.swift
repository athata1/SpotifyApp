//
//  PlayerControlsView.swift
//  Spotify
//
//  Created by Akhil Thata on 5/30/23.
//

import Foundation
import UIKit

protocol PlayerControlsViewDelegate: AnyObject {
    func playerControlsViewDidTapPlayPause(_ playerControlsView: PlayerControlsView);
    func playerControlsViewDidTapForward(_ playerControlsView: PlayerControlsView);
    func playerControlsViewDidTapBackwards(_ playerControlsView: PlayerControlsView);
    func didSlideVolumeSlider(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float)
}

struct PlayerControlsViewViewModel {
    let title: String?
    let subtitle: String?
}

final class PlayerControlsView: UIView {
    
    weak var delegate: PlayerControlsViewDelegate?
    
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        return slider
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "This is my Song"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Taylor Swift (feat. Artists)"
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private var isPlaying: Bool = true
    
    let backButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(
            UIImage(
                systemName: "backward.fill",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 34,
                    weight: .regular
                )
            ),
            for: .normal
        )
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(
            UIImage(
                systemName: "forward.fill",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 34,
                    weight: .regular
                )
            ),
            for: .normal
        )
        return button
    }()
    
    let playPauseButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(
            UIImage(
                systemName: "pause",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 34,
                    weight: .regular
                )
            ),
            for: .normal
        )
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        

        addSubview(nameLabel)
        addSubview(subtitleLabel)
        addSubview(volumeSlider)
        
        addSubview(backButton)
        addSubview(nextButton)
        addSubview(playPauseButton)
        
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        volumeSlider.addTarget(self, action: #selector(didSlideSlider), for: .valueChanged)

        
        clipsToBounds = true
    }
    
    @objc func didSlideSlider() {
        delegate?.didSlideVolumeSlider(self, didSlideSlider: volumeSlider.value)
    }
    
    @objc func didTapBack() {
        delegate?.playerControlsViewDidTapBackwards(self)
    }
    
    @objc func didTapNext() {
        print("Tapping next")
        delegate?.playerControlsViewDidTapForward(self)
    }
    
    @objc func didTapPlayPause() {
        delegate?.playerControlsViewDidTapPlayPause(self)
        
        isPlaying = !isPlaying
        
        let play = UIImage(systemName: "play.fill",withConfiguration: UIImage.SymbolConfiguration(pointSize: 34,weight: .regular))
        let pause = UIImage(systemName: "pause",withConfiguration: UIImage.SymbolConfiguration(pointSize: 34,weight: .regular))

        playPauseButton.setImage(isPlaying ? pause : play, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        subtitleLabel.frame = CGRect(x: 0, y: nameLabel.bottom + 10, width: width, height: 50)
        
        volumeSlider.frame = CGRect(x: 10, y: subtitleLabel.bottom + 20, width: width - 20, height: 44)
        
        
        let buttonSize: CGFloat = 60
        playPauseButton.frame = CGRect(x: width/2 - buttonSize/2, y: volumeSlider.bottom + 30, width: buttonSize, height: buttonSize)
        
        backButton.frame = CGRect(x: playPauseButton.left - 80, y: playPauseButton.top, width: buttonSize, height: buttonSize)
        nextButton.frame = CGRect(x: playPauseButton.right + 80 - buttonSize, y: playPauseButton.top, width: buttonSize, height: buttonSize)


    }
    
    func configure(with viewModel: PlayerControlsViewViewModel) {
        nameLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
}
