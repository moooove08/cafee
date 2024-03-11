//
//  NewsAndActionViewController.swift
//  MooooveProject
//
//  Created by Vlad Kuzmenko on 08.03.2024.
//

import UIKit



class NewsAndActionViewController: UIViewController  {
    private var contentView = UIView()
    let myImageView = UIImageView()
    let labelDetails = UILabel()
    let dateLabel = UILabel()
    let titleTextLabel = UILabel()
    let scrollView = UIScrollView()
    let modalView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        addGesture()
        setupingViews()
        setupLabels()
    }
    //MARK: Setup for View
    
    private func setupingViews() {
        // modal View
        let modalHeight = view.bounds.height - view.bounds.height / 4.5
        
        modalView.frame = CGRect(x: 0, y: view.bounds.height / 4.5 , width: view.bounds.width, height: modalHeight)
        modalView.backgroundColor = .white
        
        // blur effect for back
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        
        // scroll View & contentView for sccroll View
        
        scrollView.frame = CGRect(x: 0, y: view.bounds.height / 4.5 , width: view.bounds.width, height: modalView.frame.height)
        scrollView.addSubview(contentView)
        scrollView.contentSize = contentView.bounds.size
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),])
        
        
        //Image View
        myImageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.width )
        myImageView.contentMode = .scaleToFill
        contentView.backgroundColor = .clear
        view.addSubview(modalView)
        view.addSubview(blurView)
        view.addSubview(scrollView)
        contentView.addSubview(myImageView)
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            myImageView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 400),
            myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            myImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)])
        
    }
    //MARK: All Labels
    private func setupLabels() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(titleTextLabel)
        contentView.addSubview(labelDetails)
        dateLabel.setDateNews()
        titleTextLabel.setTitleLabelForNews()
        labelDetails.setTextNews()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 20),
            dateLabel.heightAnchor.constraint(equalToConstant: 30),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dateLabel.widthAnchor.constraint(equalToConstant: 80)])
        
        titleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            titleTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        labelDetails.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelDetails.topAnchor.constraint(equalTo: titleTextLabel.bottomAnchor, constant: 20),
            labelDetails.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            labelDetails.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            contentView.bottomAnchor.constraint(equalTo: labelDetails.bottomAnchor)
        ])
    }
    
    //MARK:  Add gesture for back to previous scene
    private func addGesture() {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        gesture.direction = .down
        view.addGestureRecognizer(gesture)
    }
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.state == .ended {
            dismiss(animated: true, completion: nil)
        }
    }
    
    
}
