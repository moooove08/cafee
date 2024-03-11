//
//  UILabel + Extension.swift
//  MooooveProject
//
//  Created by Vlad Kuzmenko on 04.03.2024.
//

import UIKit

extension UILabel {
    func setupBack() {
        layer.masksToBounds = true
        textAlignment = .center
        layer.cornerRadius = 35
        layer.borderWidth = 1
        layer.borderColor = UIColor.border.cgColor
        backgroundColor = .backgroundBonusPercent
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.boldSystemFont(ofSize: 40)
        textColor = .titleBonusPercent
    }
    func setTitelsForTableViewController() {
        var phone = ""
        var name = ""
        numberOfLines = 0
        backgroundColor = .clear
        textAlignment = .center
        if let number = UserDefaults.standard.object(forKey: "phoneNumber"), let savedValue = UserDefaults.standard.object(forKey: "name") as? String {
            phone = number as? String ?? ""
            name =  savedValue
        }
        text = "\(name)\n\n\(phone)"
        let attributedString = NSMutableAttributedString(string: text ?? "")
        let range1 = (attributedString.string as NSString).range(of: name)
        let range2 = (attributedString.string as NSString).range(of: phone)
        attributedString.addAttributes([.foregroundColor: UIColor.black, .font: UIFont.boldSystemFont(ofSize: 30)], range: range1)
        attributedString.addAttributes([.foregroundColor: UIColor.titleGray, .font: UIFont.boldSystemFont(ofSize: 22)], range: range2)
        attributedText = attributedString
    }
    func setLabelForBonus() {
        text = "Доступно бонусів"
        textColor = .white
        font = UIFont.systemFont(ofSize: 16)
        textAlignment = .left
    }
    func setCashBackInfoLabel() {
        textAlignment = .left
        numberOfLines = 0
        let firstPart = "Рівень кешбеку"
        let seconPart = "Супер"
        text = "\(firstPart)\n\(seconPart)"
        let attributedString = NSMutableAttributedString(string: text ?? "")
        let range1 = (attributedString.string as NSString).range(of: firstPart)
        let range2 = (attributedString.string as NSString).range(of: seconPart)
        attributedString.addAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 16)], range: range1)
        attributedString.addAttributes([.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 20)], range: range2)
        attributedText = attributedString
    }
    func setCashBackPersent() {
        text = "5%"
        backgroundColor = .qrBackground
        textAlignment = .center
        textColor = .white
        font = UIFont.systemFont(ofSize: 22)
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
    func setLabelForBonusCount() {
        text = "1000"
        textColor = .white
        font = UIFont.boldSystemFont(ofSize: 40)
        textAlignment = .left
    }
    func setDateNews() {
        backgroundColor = .qrBackground
        textAlignment = .center
        textColor = .white
        font = UIFont.systemFont(ofSize: 14)
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
    func setTitleLabelForNews() {
        textColor = .qrBackground
        font = UIFont.boldSystemFont(ofSize: 40)
        numberOfLines = 0
        textAlignment = .left
    }
    func setTextNews() {
        numberOfLines = 0
        textColor = .qrBackground
        font = UIFont.systemFont(ofSize: 20)
        textAlignment = .left
    }
    func setLabelForDevelop() {
        text = "©2023 Merry Berry\n App Developed by Vlad Kuzmenko\n Test Version"
        textColor = .titleGray
        font = UIFont.boldSystemFont(ofSize: 14)
        textAlignment = .center
        numberOfLines = 0
    }
}
