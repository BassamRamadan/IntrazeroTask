//
//  imageCell.swift
//  IntrazeroTask
//
//  Created by Bassam on 8/11/22.
//
import UIKit

class imageCell: UICollectionViewCell {
    @IBOutlet var image: UIImageView!
    @IBOutlet var author: UILabel!
    
    func addImageGradient(){
        let width = image.frame.width
        let height = image.frame.height
        
        let sHeight:CGFloat = 120
        let shadow = UIColor.black.withAlphaComponent(0.8).cgColor
        
        let bottomImageGradient = CAGradientLayer()
        bottomImageGradient.frame = CGRect(x: 0, y: height - sHeight, width: width, height: sHeight)
        bottomImageGradient.colors = [UIColor.clear.cgColor, shadow]
        image.layer.insertSublayer(bottomImageGradient, at: 0)
    }
}
