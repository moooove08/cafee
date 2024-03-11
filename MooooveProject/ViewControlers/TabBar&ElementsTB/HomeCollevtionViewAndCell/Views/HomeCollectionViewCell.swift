//
//  HomeCollectionViewCell.swift
//  MooooveProject
//
//  Created by Vlad Kuzmenko on 08.03.2024.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    let imageViewNews = UIImageView()
     let labelInfo: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    let dateLabel = UILabel()
    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        return blurView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        contentView.addSubview(imageViewNews)
        dateLabel.setDateNews()
        imageViewNews.contentMode = .scaleToFill
        imageViewNews.layer.cornerRadius = 40
        imageViewNews.layer.masksToBounds = true
        imageViewNews.frame = contentView.bounds
        
        imageViewNews.addSubview(blurView)
        imageViewNews.addSubview(labelInfo)
        imageViewNews.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        blurView.translatesAutoresizingMaskIntoConstraints = false
        labelInfo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: imageViewNews.bottomAnchor, constant: -80),
            blurView.bottomAnchor.constraint(equalTo: imageViewNews.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: imageViewNews.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: imageViewNews.trailingAnchor),
            labelInfo.topAnchor.constraint(equalTo: imageViewNews.bottomAnchor, constant: -80),
            labelInfo.bottomAnchor.constraint(equalTo: imageViewNews.bottomAnchor),
            labelInfo.leadingAnchor.constraint(equalTo: imageViewNews.leadingAnchor, constant: 25),
            labelInfo.trailingAnchor.constraint(equalTo: imageViewNews.trailingAnchor, constant: -16),
            dateLabel.topAnchor.constraint(equalTo: imageViewNews.topAnchor, constant: 16),
            dateLabel.heightAnchor.constraint(equalToConstant: 30),
            dateLabel.widthAnchor.constraint(equalToConstant: 80),
            dateLabel.leadingAnchor.constraint(equalTo: imageViewNews.leadingAnchor, constant: 16)])
        
    }
}

