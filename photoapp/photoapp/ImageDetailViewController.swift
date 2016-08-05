//
//  ImageDetailViewController.swift
//  photoapp
//
//  Created by Mark McDonald on 8/2/16.
//  Copyright © 2016 Mark McDonald. All rights reserved.
//

import UIKit
import Social

class ImageDetailViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    
    var detail: UIImage?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("This is the picture")
        print(self.detail)
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.hidesBarsOnTap = true
        self.detailImage.image = self.detail

        // Do any additional setup after loading the view.
        
        
        
        
    }
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        self.detailImage.image = self.detail
//    }
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        self.detailImage.image = self.detail
//
//    }
    
    @IBAction func sharetoTwitter(sender: AnyObject) {
       
        var okTwitter :Bool = SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter)
        
        if okTwitter == false{
        let alert = UIAlertController(title: "Login to Twitter", message: "Please login to your twitter account. Go to Settings > Twitter.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        }
        else{
            let shareToTwitter : SLComposeViewController = SLComposeViewController(forServiceType:SLServiceTypeTwitter)
            shareToTwitter.addImage(self.detailImage.image)
            self.presentViewController(shareToTwitter, animated: true, completion: nil)
        }
    
        
        
    }
//    override func prefersStatusBarHidden() -> Bool {
//        return navigationController?.navigationBarHidden == false
//    }
    
//    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
//        return UIStatusBarAnimation.Slide
//    }


    
  }

    


