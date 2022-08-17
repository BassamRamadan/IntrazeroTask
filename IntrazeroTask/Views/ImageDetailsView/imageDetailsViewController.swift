//
//  imageViewController.swift
//  IntrazeroTask
//
//  Created by Bassam on 8/15/22.
//

import UIKit
import DBImageColorPicker

class imageDetailsViewController: UIViewController {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var container: UIView!
    
    var imageInfo: imageModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.sd_setImage(with: URL(string: imageInfo?.downloadURL ?? "")) { (image1, erroe, cacheType, url) in
            self.container.backgroundColor = DBImageColorPicker(from: image1!, with: .default)?.backgroundColor
        }
    }
}
