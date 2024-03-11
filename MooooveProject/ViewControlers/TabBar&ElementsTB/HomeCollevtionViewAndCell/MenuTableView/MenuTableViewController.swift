//
//  MenuTableViewController.swift
//  MooooveProject
//
//  Created by Vlad Kuzmenko on 09.03.2024.
//

import UIKit

class MenuTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let identifier = "cell"
    let tableView = UITableView()
    let scrollView = UIScrollView()
    let contentView = UIView()
    let backButton = UIButton()
    var callButton = UIButton()
    var writeTelegram = UIButton()
    let stackViewForButtons = UIStackView()
    let developerLabel = UILabel()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .clear
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
       
        tableScrollViewSettings()
        backButtonTappedSettings()
        setCallButton()
        setWriteToTlegrammButton()
        settingStackViewForButons()
        createButtonsForStackView()
        setDeveloperLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addVerticalGradientLayer(topColor: UIColor.white, bottomColor: .backGround)
        
    }
    
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
    //MARK: BackButton
    
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
    //MARK: TableView & ScrollView settings
    private func tableScrollViewSettings() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        scrollView.frame = view.bounds
        scrollView.backgroundColor = .clear
        contentView.frame = view.bounds
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.contentSize = contentView.bounds.size
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)])
        contentView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 700)
        ])
    }
   //MARK: Callbutton
    private func setCallButton() {
        callButton = {
            let button = UIButton(type: .system)
            button.setTitle("Поздзвонити нам", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            button.addTarget( self, action: #selector(callButtonTapped), for: .touchUpInside)
            button.frame.size = CGSize(width: 350, height: 70)
            button.layer.cornerRadius = button.frame.height / 2
            button.layer.masksToBounds = true
            button.layer.borderWidth = 5
            button.layer.borderColor = UIColor.buttonBorder.cgColor
            button.backgroundColor = .buttonTint
            button.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(button)
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 40),
                button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                button.heightAnchor.constraint(equalToConstant: 70),
                button.widthAnchor.constraint(equalToConstant: 350)
            ])
            
            return button
        }()
    }
    //MARK: Telegramm button
    private func setWriteToTlegrammButton() {
        writeTelegram = {
            let button = UIButton(type: .system)
            button.setTitle("Написати нам в телеграм", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            button.addTarget( self, action: #selector(callButtonTapped), for: .touchUpInside)
            button.frame.size = CGSize(width: 350, height: 70)
            button.layer.cornerRadius = button.frame.height / 2
            button.layer.masksToBounds = true
            button.layer.borderWidth = 3
            button.layer.borderColor = UIColor.border.cgColor
            button.backgroundColor = .clear
            button.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(button)
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: callButton.bottomAnchor, constant: 5),
                button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                button.heightAnchor.constraint(equalToConstant: 70),
                button.widthAnchor.constraint(equalToConstant: 350)
            ])
            
            return button
        }()
    }
    
    //MARK: StackView settings
    
    func settingStackViewForButons() {
       
        stackViewForButtons.axis = .horizontal
        stackViewForButtons.spacing = 8
        
        stackViewForButtons.alignment = .center
        stackViewForButtons.distribution =  .equalCentering
        contentView.addSubview(stackViewForButtons)
        
        
        stackViewForButtons.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewForButtons.topAnchor.constraint(equalTo: writeTelegram.bottomAnchor, constant: 20),
            stackViewForButtons.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            stackViewForButtons.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            stackViewForButtons.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewForButtons.heightAnchor.constraint(equalToConstant: 60),
            
        ])
    }
    //MARK: Create Buttons for StackView social
    func createButtonsForStackView() {
        for i in 1...3 {
            let button = UIButton(type: .system)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            button.layer.cornerRadius = 30
            button.layer.masksToBounds = true
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.border.cgColor
            if i == 1 {
                button.setImage(.facebook, for: .normal)
            } else if i == 2 {
                button.setImage(.insta, for: .normal)
            } else {
                button.setImage(.tiktok, for: .normal)
            }
            button.tintColor = .titlePurple
            stackViewForButtons.addArrangedSubview(button)
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: 60),
                button.widthAnchor.constraint(equalToConstant: 60)
            ])
        }
    }
    @objc func buttonTapped(_ button: UIButton) {
        
    }
    @objc func callButtonTapped() {
        
    }
    
    //MARK: Developer label
    private func setDeveloperLabel() {
        developerLabel.setLabelForDevelop()
        contentView.addSubview(developerLabel)
        developerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            developerLabel.topAnchor.constraint(equalTo: stackViewForButtons.bottomAnchor, constant: 20),
            developerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            developerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            developerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            developerLabel.heightAnchor.constraint(equalToConstant: 100),
            contentView.bottomAnchor.constraint(equalTo: developerLabel.bottomAnchor, constant: 50)
        ])
    }
    
    

    // MARK: - Table view DataSource & Delegate

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let additionalImageView = UIImageView()
        additionalImageView.frame = CGRect(x:  350, y: 0, width: 20, height: 20)
        additionalImageView.center.y = cell.contentView.center.y
        // Настройте положение и размер нового imageView. Например:
        cell.textLabel?.font = UIFont.systemFont(ofSize: 19)
        cell.textLabel?.text = CellName().buttonsNames[indexPath.row]
         cell.imageView?.tintColor = .black
         cell.backgroundColor = .clear
         cell.textLabel?.textColor = .black
         if indexPath.row <= 5 &&  indexPath.row != 2 {
             additionalImageView.image = .rightarrow
             cell.contentView.addSubview(additionalImageView)
         }
         switch indexPath.row {
         case 0: cell.imageView?.image = UIImage(systemName: "square.and.pencil")
         case 1: cell.imageView?.image = UIImage(systemName: "message")
         case 2: cell.imageView?.image = UIImage(systemName: "bolt")
             let switchKey = UISwitch(frame: CGRect(x: 320, y: 0, width: 50, height: 30))
             switchKey.center.y = cell.contentView.center.y
             cell.contentView.addSubview(switchKey)
         case 3: cell.imageView?.image = UIImage(systemName: "clock")
         case 4: cell.imageView?.image = UIImage(systemName: "network")
         case 5: cell.imageView?.image = UIImage(systemName: "hand.thumbsup.fill")
         case 6: cell.imageView?.image = UIImage(systemName: "rectangle.portrait.and.arrow.forward")
         case 7: cell.imageView?.image = UIImage(systemName: "trash")
             cell.imageView?.tintColor = .red
             cell.textLabel?.textColor = .red
             
         default:
             break
         }
         return cell
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        100
    }
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleForRow = UILabel()
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100)
        titleForRow.setTitelsForTableViewController()
        titleForRow.frame = CGRect(x: 0, y: -20, width: headerView.frame.width, height: headerView.frame.height)
        headerView.addSubview(titleForRow)
        return headerView
    }
    
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let editController = EditPersonalDataViewController()
            editController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(editController, animated: true)
        case 6:
            UserDefaults.standard.removeObject(forKey: "isLoggedIn")
            let newScene = UINavigationController(rootViewController: PhoneNumberViewController())
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(newScene)
        default:
            break
        }
    }

}
