//
//  UIButton + Extension.swift
//  MooooveProject
//
//  Created by Vlad Kuzmenko on 07.03.2024.
//

import UIKit
extension UIButton {
    
     func backButtonImageBack() {
        backgroundColor = .whiteButtonBack
        setImage(.leftArrow.withRenderingMode(.alwaysTemplate), for: .normal)
        tintColor = .white
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
    func setBarMenuButton() {
        backgroundColor = .white
        layer.borderWidth = 2
        layer.borderColor = UIColor.border.cgColor
        setImage(.purpleLines.withRenderingMode(.alwaysOriginal), for: .normal)
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
    func setTitelSectionButton() {
        backgroundColor = .white
        layer.borderWidth = 3
        layer.borderColor = UIColor.borderColorSecondary.cgColor
        layer.cornerRadius = 18
        layer.masksToBounds = true
        setTitle("Дивитись усі", for: .normal)
        frame = CGRect(x: 230, y: 0, width: 140, height: 36)
        setTitleColor(.sectionTitleGray, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }

}
