//
//  ViewController.swift
//  MooooveProject
//
//  Created by Vlad Kuzmenko on 01.03.2024.
//

import UIKit
import CoreImage
import Firebase



final class QRCodeViewController: UIViewController {
    
    private let codeQRImageView = UIImageView()
    private let backgroundQRImageView = UIImageView()
    private let bonusLabel = UILabel()
    private let percentSaleLabel = UILabel()
    private let idLabel = UILabel()
    private let titleLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backGround
        setupViews()
        setupImageViews()
        setupLabels()
        
    }
    
    
    private func setupImageViews(){
        codeQRImageView.frame.size = CGSize(width: 225, height: 225)
        codeQRImageView.center.x = view.center.x
        codeQRImageView.center.y = view.center.y
        codeQRImageView.backgroundColor = .white
        codeQRImageView.layer.cornerRadius = 40
        codeQRImageView.contentMode = .center
        codeQRImageView.clipsToBounds = true
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            if let qrCodeImage = generateQRCodeForUser(uid: uid) {
                codeQRImageView.image = qrCodeImage
                idLabel.text = uid
            }
        }
        view.addSubview(codeQRImageView)
        backgroundQRImageView.frame.size = CGSize(width: view.frame.width, height: view.frame.width)
        backgroundQRImageView.center = view.center
        backgroundQRImageView.layer.cornerRadius = 30
        backgroundQRImageView.clipsToBounds = true
        backgroundQRImageView.contentMode = .scaleAspectFill
        backgroundQRImageView.image = .cut
        view.addSubview(backgroundQRImageView)
        //backgroundQRImageView.addSubview(codeQRImageView)
    }
    
    private func setupViews() {
        let colorLayer1 = CALayer()
        colorLayer1.frame = CGRect(x: 0, y: 0, width: view.bounds.width , height: view.bounds.height / 2)
        colorLayer1.backgroundColor = UIColor.white.cgColor
        view.layer.addSublayer(colorLayer1)
        
        let colorLayer2 = CALayer()
        colorLayer2.frame = CGRect(x: 0, y: view.bounds.height / 2, width: view.bounds.width , height: view.bounds.height / 2)
        colorLayer2.backgroundColor = UIColor.qrBackground.cgColor
        view.layer.addSublayer(colorLayer2)
    }
    
    private func setupLabels() {
        
        // ID label
        
        idLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 16)
        idLabel.textColor = .white
        idLabel.numberOfLines = 1
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundQRImageView.addSubview(idLabel)
        NSLayoutConstraint.activate([
            idLabel.bottomAnchor.constraint(equalTo: codeQRImageView.bottomAnchor, constant: 25),
            idLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        // Title Label
        
        titleLabel.frame.size = CGSize(width: view.frame.width, height: 35)
        titleLabel.text = "Супер картка"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 35)
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        // Percent Sale Label
        
        percentSaleLabel.text = "5%"
        
        percentSaleLabel.setupBack()
        view.addSubview(percentSaleLabel)
        NSLayoutConstraint.activate([
           percentSaleLabel.topAnchor.constraint(greaterThanOrEqualTo:  titleLabel.bottomAnchor, constant: 5),
            percentSaleLabel.heightAnchor.constraint(equalToConstant: 80),
            percentSaleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            percentSaleLabel.bottomAnchor.constraint(equalTo: backgroundQRImageView.topAnchor, constant: -20),
        ])
        //bonus Label
        
        bonusLabel.text = "1000"
        bonusLabel.setupBack()
        view.addSubview(bonusLabel)
        NSLayoutConstraint.activate([
            bonusLabel.topAnchor.constraint(greaterThanOrEqualTo:  titleLabel.bottomAnchor, constant: 5),
            bonusLabel.heightAnchor.constraint(equalToConstant: 80),
            bonusLabel.bottomAnchor.constraint(equalTo: backgroundQRImageView.topAnchor, constant: -20),
            bonusLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            bonusLabel.widthAnchor.constraint(equalTo: percentSaleLabel.widthAnchor),
            bonusLabel.trailingAnchor.constraint(equalTo: percentSaleLabel.leadingAnchor, constant: -16)
        ])
        
        
    }
    
    
    private func generateQRCodeForUser(uid: String) -> UIImage? {
        let data = uid.data(using: .utf8)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 5, y: 5)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    
}






