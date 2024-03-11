//
//  AllNewsCollectionViewController.swift
//  MooooveProject
//
//  Created by Vlad Kuzmenko on 09.03.2024.
//

import UIKit



class AllNewsCollectionViewController: UICollectionViewController {

    private let cellIdentifier = "cell"
    private let sectionHeaderIdentifier = "header"
    private var compositionalLayout: UICollectionViewCompositionalLayout!
    private let dataHome = DataForHomeViewContoller()
    private let titleLabel = UILabel()
    private let backButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = self.compositionalLayout
        view.backgroundColor = .white
        collectionView.register(HeaderForSection.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderIdentifier)
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = .clear
        setTitel()
        backButtonTappedSettings()
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
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)) // Ширина элемента равна половине ширины экрана
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10) // Отступы по 10 пикселей с обеих сторон
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.25)) // Высота группы равна половине экрана
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2) // Горизонтальная группа с двумя элементами
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 0
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0) // Отступ сверху первой секции 10 пикселей, между элементами 0 пикселей
            
            return section
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
    //MARK: BAckButton
    //backBarButton
    private func backButtonTappedSettings() {
        navigationItem.hidesBackButton = true
        let barButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = barButton
        backButton.backButtonImageBack()
        backButton.tintColor = .titlePurple
        backButton.backgroundColor = .white
        backButton.layer.borderWidth = 4
        backButton.layer.borderColor = UIColor.border.cgColor
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.heightAnchor.constraint(equalToConstant: 45),
            backButton.widthAnchor.constraint(equalToConstant: 45)])
    }
    
    //MARK: Titel for View
    private func setTitel() {
         titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
         titleLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width / 2, height: 50)
         titleLabel.center.x = view.center.x
         titleLabel.text = "Новини та акції"
         titleLabel.textAlignment = .center
         titleLabel.textColor = .black
         navigationItem.titleView = titleLabel
     }
     

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dataHome.imageArray.count
    }
    
// CollectionView Delegate
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! HomeCollectionViewCell
        cell.imageViewNews.image = dataHome.imageArray[indexPath.row]
        cell.dateLabel.text = dataHome.dateArray[indexPath.row]
        cell.labelInfo.text = dataHome.textInfoForNews[indexPath.row]
        cell.labelInfo.font = UIFont.systemFont(ofSize: 16)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newsViewController = NewsAndActionViewController()
        let item = dataHome.imageArray[indexPath.row]
        let dateText = dataHome.dateArray[indexPath.row]
        let titleInfo = dataHome.textInfoForNews[indexPath.row]
        let details = dataHome.detailNews[indexPath.row]
        newsViewController.myImageView.image = item
        newsViewController.dateLabel.text = dateText
        newsViewController.titleTextLabel.text = titleInfo
        newsViewController.labelDetails.text = details
            newsViewController.modalPresentationStyle = .custom
            present(newsViewController, animated: true)
    }

}
