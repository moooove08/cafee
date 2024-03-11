//
//  Extension.swift
//  MooooveProject
//
//  Created by Vlad Kuzmenko on 01.03.2024.
//

import UIKit

extension UIImage {
    func scaledToFitHeight(_ height: CGFloat) -> UIImage? {
        let scale = height / size.height
        let newWidth = size.width * scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: height), false, scale)
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}


    func createFilledImage(from image: UIImage, with color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        color.setFill()
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        UIRectFill(rect)
        image.draw(in: rect, blendMode: .destinationIn, alpha: 1.0)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }




