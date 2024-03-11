//
//  HomeCollectionViewCell.swift
//  MooooveProject
//
//  Created by Vlad Kuzmenko on 08.03.2024.
//

import UIKit

class BonusCollectionViewCell: UICollectionViewCell {
   
    let imageViewBomus = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImageViewBonus()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    private func setupImageViewBonus() {
        
        let labelBonuCount = UILabel()
        let labelInfoBonus = UILabel()
        let cashBackPercent = UILabel()
        let cashBackInfoText = UILabel()
        labelBonuCount.setLabelForBonusCount()
        labelInfoBonus.setLabelForBonus()
        cashBackPercent.setCashBackPersent()
        cashBackInfoText.setCashBackInfoLabel()
        labelBonuCount.frame = CGRect(x: 30, y: 40, width: 150 , height: 50)
        labelInfoBonus.frame =  CGRect(x: 30, y: 100, width: 150 , height: 16)
        cashBackInfoText.frame = CGRect(x: 100, y: 160, width: 200 , height: 44)
        cashBackPercent.frame = CGRect(x: 30, y: 160, width: 60 , height: 44)
        
        imageViewBomus.contentMode = .scaleToFill
        imageViewBomus.layer.cornerRadius = 20
        imageViewBomus.layer.masksToBounds = true
        imageViewBomus.frame = contentView.bounds
        imageViewBomus.addSubview(cashBackInfoText)
        imageViewBomus.addSubview(cashBackPercent)
        imageViewBomus.addSubview(labelInfoBonus)
        imageViewBomus.addSubview(labelBonuCount)
        contentView.addSubview(imageViewBomus)
    }
}

