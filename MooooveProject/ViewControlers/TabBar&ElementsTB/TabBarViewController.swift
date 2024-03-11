//
//  TabBarVC.swift
//  MooooveProject
//
//  Created by Vlad Kuzmenko on 01.03.2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        createViewControllers()
        setTabBarAppearance()
        setupElementsOfTabBar()
    }
    
    
    private func createViewControllers() {
        let homeVC = UINavigationController(rootViewController: HomeCollectionView())
        let qrCodeVC = QRCodeViewController()
        let detailsVC =  UINavigationController(rootViewController: DetailsPointViewController())
        viewControllers = [
            generateVC(for: homeVC, title: "Головна"),
            generateVC(for: qrCodeVC, title: "" ),
            generateVC(for: detailsVC, title: "Кафе")]
    }
    
    
    private func generateVC(for vc: UIViewController,  title: String) -> UIViewController {
        vc.tabBarItem.title = title
        return vc
    }
    
    func setTabBarAppearance() {
        //first layer
        
        let positionOnX: CGFloat = 0
        let positionOnY: CGFloat = tabBar.bounds.minY
        let height:CGFloat = 200
        let roundLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(x: positionOnX,y: positionOnY  ,width: view.frame.width, height: height),
            cornerRadius: 30)
        roundLayer.path = bezierPath.cgPath
        roundLayer.fillColor = UIColor.white.cgColor
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        // second layer
        let heightCentralCircle: CGFloat = 60
        let widthCentralCircle: CGFloat = 60
        let centerPosition: CGFloat = tabBar.center.x - heightCentralCircle / 2
        let positionY: CGFloat = -15
        let roundLayer2 = CAShapeLayer()
        let bezierPath2 = UIBezierPath(
            roundedRect: CGRect(x: centerPosition, y: positionY, width: widthCentralCircle, height: heightCentralCircle),
            cornerRadius: 19)
        roundLayer2.path = bezierPath2.cgPath
        tabBar.layer.insertSublayer(roundLayer2, at: 1)
        roundLayer2.fillColor = UIColor.circle.cgColor
        
        
    }
    
    private func setupElementsOfTabBar()  {
        let titleInset = UIOffset(horizontal: 0, vertical: 2)
        tabBar.tintColor = .lightPurple
        tabBar.unselectedItemTintColor = .tabbarTint
        tabBar.itemPositioning = .centered
        tabBar.itemWidth = tabBar.bounds.width / 2
        UITabBarItem.appearance().titlePositionAdjustment = titleInset
        
        if let items = tabBar.items {
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0), .foregroundColor: UIColor.titleGray]
            items[0].image = .tabbarItenHome
            items[0].selectedImage = .tabbarItemHomefull
            items[0].setTitleTextAttributes([.foregroundColor: UIColor.titlePurple], for: .selected)
            items[0].setTitleTextAttributes(attributes, for: .normal)
            items[0].imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -3, right: 0)
            items[1].image = .tabbarItemQrcode.withRenderingMode(.alwaysOriginal)
            items[1].selectedImage = .tabbarItemQrcode.withRenderingMode(.alwaysOriginal)
            items[1].imageInsets = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
            items[2].image = .tabbarItemCafe.withRenderingMode(.alwaysOriginal)
            items[2].selectedImage = .tabbarItemSelectedCafe.withRenderingMode(.alwaysOriginal)
            items[2].setTitleTextAttributes([.foregroundColor: UIColor.titlePurple], for: .selected)
            items[2].setTitleTextAttributes(attributes, for: .normal)
            items[2].imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -3, right: 0)
        }
        
    }
}
