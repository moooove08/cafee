//
//  HomeCollectionView.swift
//  MooooveProject
//
//  Created by Vlad Kuzmenko on 01.03.2024.
//

import UIKit
import Firebase

class HomeCollectionView: UICollectionViewController {
    
    private var compositionalLayout: UICollectionViewCompositionalLayout!
    private let cellIdentifier = "cell"
    private let bonusCellIdentifier = "cellBonus"
    private let sectionHeaderIdentifier = "header"
    private var labelTextBarItem = UILabel()
    private let rigtBarButton = UIButton()
    private let newsLabel = UILabel()
    private let data = DataForHomeViewContoller()
    private let dataBase = Database.database().reference()
    private let currentUser = Auth.auth().currentUser
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = self.compositionalLayout
        
        collectionView.register(HeaderForSection.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderIdentifier)
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(BonusCollectionViewCell.self, forCellWithReuseIdentifier: bonusCellIdentifier)
        collectionView.backgroundColor = .clear
        labelsSettings()
        menuButton()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addVerticalGradientLayer(topColor: UIColor.white, bottomColor: .backGround)
        labelsSettings()
    }
    init() {
        // Call super.init first
        super.init(collectionViewLayout: UICollectionViewLayout())
        // Initialize compositionalLayout after super.init
        self.compositionalLayout = createLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UICollectionViewCompositionalLayout
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            // Размер элемента (изображения)
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)) // Ширина элемента равна ширине экрана
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 16, bottom: 16, trailing: 16) // Отступы по 20 пикселей с обеих сторон
                
                // Группа, содержащая только один элемент
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3333)) // Высота группы равна трети экрана
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                // Секция с группой элементов
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0) // Отступ сверху первой секции 50 пикселей, между секциями 20 пикселей
                return section
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)) // Ширина элемента равна ширине экрана
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20) // Отступы по 20 пикселей с обеих сторон
                
                // Группа, содержащая только один элемент
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(0.3333)) // Высота группы равна трети экрана
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                // Секция с группой элементов
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous // Горизонтальная прокрутка для секции
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0) // Отступ сверху первой секции 50 пикселей, между секциями 20 пикселей
                // Добавление заголовка секции
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [sectionHeader]
                
                return section
            }
        }
    }
    //MARK: labels settings
    private func labelsSettings() {
        // Welcome Label
        var name: String = ""
        if let savedValue = UserDefaults.standard.object(forKey: "name") as? String {
           name = savedValue
        }
        let text = "Вітаю, \(name)"
        let barItem = UIBarButtonItem(customView: labelTextBarItem)
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: 6))
        attributedString.addAttribute(.foregroundColor, value: UIColor.titleforPhoneNumber, range: NSRange(location: 7, length: name.count ))
        labelTextBarItem.attributedText = attributedString
        labelTextBarItem.font = UIFont.boldSystemFont(ofSize: 30)
        labelTextBarItem.textAlignment = .center
        labelTextBarItem.numberOfLines = 0
        navigationItem.leftBarButtonItem = barItem
    }
  //MARK: menuButton
    private func menuButton() {
        let barButton = UIBarButtonItem(customView: rigtBarButton)
        navigationItem.rightBarButtonItem = barButton
        rigtBarButton.setBarMenuButton()
        rigtBarButton.addTarget(self, action: #selector(rightBarButtonTupped), for: .touchUpInside)
        rigtBarButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rigtBarButton.heightAnchor.constraint(equalToConstant: 45),
            rigtBarButton.widthAnchor.constraint(equalToConstant: 45)])
    }
    
    @objc func rightBarButtonTupped() {
        let menuViewController = MenuTableViewController()
        navigationController?.pushViewController(menuViewController, animated: true)
    }
    @objc func allNewsWatching() {
        let allNewsViewController = AllNewsCollectionViewController()
        navigationController?.pushViewController(allNewsViewController, animated: true)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2 // Возвращает количество секций (1 секция в данном случае)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1 : return data.imageArray.count
        default:
            return 5
        }
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Unexpected kind")
        }
        let title = "Новини та акції"
        let button = UIButton(type: .system)
        button.setTitelSectionButton()
        button.addTarget(self, action: #selector(allNewsWatching), for: .touchUpInside)
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeaderIdentifier, for: indexPath) as! HeaderForSection
        headerView.titleLabel.text = title
        headerView.addSubview(button)
        
        return headerView
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: bonusCellIdentifier, for: indexPath) as? BonusCollectionViewCell {
                cell.imageViewBomus.image = data.bonusIMG
                return cell
            }
            } else if indexPath.section == 1 {
                collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? HomeCollectionViewCell {
                    cell.imageViewNews.image = data.imageArray[indexPath.row]
                    cell.dateLabel.text = data.dateArray[indexPath.row]
                    cell.labelInfo.text = data.textInfoForNews[indexPath.row]
                    return cell
                }
            }
        
        return UICollectionViewCell()
    }
    // MARK: UICollectionViewDelegate
    
   
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0 : if let tabBarController = self.tabBarController {
            tabBarController.selectedIndex = 1
        }
        case 1 : let newsViewController = NewsAndActionViewController()
            let item = data.imageArray[indexPath.row]
            let dateText = data.dateArray[indexPath.row]
            let titleInfo = data.textInfoForNews[indexPath.row]
            let details = data.detailNews[indexPath.row]
            newsViewController.myImageView.image = item
            newsViewController.dateLabel.text = dateText
            newsViewController.titleTextLabel.text = titleInfo
            newsViewController.labelDetails.text = details
            newsViewController.modalPresentationStyle = .custom
            present(newsViewController, animated: true)
            
        default: break
        }
    }
    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}

