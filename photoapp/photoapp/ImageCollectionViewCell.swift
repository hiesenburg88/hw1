//
//  ImageCollectionViewCell.swift
//  photoapp
//
//  Created by Mark McDonald on 8/3/16.
//  Copyright © 2016 Mark McDonald. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewCell: UIImageView!
    var picture : UIImage = UIImage()
 
    
    
    func updateUI()
    {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 3.0
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blackColor().CGColor    }


}
