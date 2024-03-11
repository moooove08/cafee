//
//  UITExtField + Extension.swift
//  MooooveProject
//
//  Created by Vlad Kuzmenko on 05.03.2024.
//

import UIKit

class CustomTextField: UITextField {
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightBounds = super.rightViewRect(forBounds: bounds)
        let padding: CGFloat = 20
        rightBounds.origin.x -= padding
        return rightBounds
    }
}

extension UITextField {
    
    func settingsTextField() {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
        layer.borderWidth = 2
        layer.borderColor = UIColor.border.cgColor
        font = UIFont.systemFont(ofSize: 20)
        backgroundColor = .clear
        textColor = .black
        
    }
    
    func themeChanging() {
            
        let systemBackgroundColor = UIColor { traitCollection in
                    return traitCollection.userInterfaceStyle == .dark ? .darkGray : .white
                }
        let systemTextColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .white : .black
        }
                backgroundColor = systemBackgroundColor
                textColor = systemTextColor
                
            }

    
    
    func addDoneButton() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        doneButton.tintColor = .lightPurple
        toolbar.setItems([doneButton], animated: true)
        inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        resignFirstResponder()
    }
}

extension CustomTextField {
    func setRightView(_ image: UIImage) {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleToFill
        rightView = imageView
        rightViewMode = .always
    }
}

