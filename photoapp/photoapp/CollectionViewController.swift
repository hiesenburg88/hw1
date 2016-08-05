//
//  CollectionViewController.swift
//  photoapp
//
//  Created by Mark McDonald on 8/2/16.
//  Copyright © 2016 Mark McDonald. All rights reserved.
//

import UIKit
import Foundation
import ImageIO
import SystemConfiguration

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let leftandrightpaddings: CGFloat = 32.0
    let numberofitemsperrow: CGFloat = 3.0
    let heightadjustment: CGFloat = 30.0
    var images = [String]()
    var pictures = [UIImage]()
    var outputs = [String]()
    var alblum = [UIImage]()
    var theImage = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = (CGRectGetWidth(collectionView!.frame) - leftandrightpaddings) / numberofitemsperrow
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSizeMake(width, width + heightadjustment)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.registerClass(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        
         downloadURLs("https://stachesandglasses.appspot.com/user/mhmcdonald/json/")
        print("outputs 2: ")
        print(outputs)
        var snaps = [UIImage]()
        
        var sizeofOutputs = outputs.count - 1
        print("this is the size of the array")
        print(sizeofOutputs)
        for i in 0...sizeofOutputs{
            let stringURL = outputs[i]
            ImageLoader.sharedLoader.imageForUrl(stringURL, completionHandler:{(image: UIImage?, url: String) in
                snaps.append(image!)
            })
        print(snaps)

        }
            
            
            
            
        print("processing outputs...: ")
//        processArray(outputs)

    }
    
    

    func downloadURLs(urlString: String) -> [String]
    {
        if Reachability.isConnectedToNetwork() == true {
        if let url = NSURL(string: urlString){
            var images = [String]()
            
            let jsonData = try!(NSData(contentsOfURL: url, options: NSDataReadingOptions.DataReadingMappedIfSafe))
            
            if let jsonDictionary = SharedNetworking.parseJSONFromData(jsonData) {
                let espDictionaries = jsonDictionary["results"] as! [[String : String]]
                let arraySize = espDictionaries.count - 1
                for i in 0...arraySize{
                    var prefix = "https://stachesandglasses.appspot.com/"
                    let imageLink = espDictionaries[i]["image_url"]!;
                    prefix += imageLink
                    images.append(prefix)
                }
                
                outputs = images;
                
                }
            }
                }
        if Reachability.isConnectedToNetwork() == false {
            print("Internet connection FAILED")
            var alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }

        return images
        }
    
    //from treehouse: https://teamtreehouse.com/community/does-anyone-know-how-to-show-an-image-from-url-with-swift
    

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.outputs.count
    }
    private struct Storyboard
    {
        static let CellIdentifier = "ImageCell"
    }
    
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath) as! ImageCollectionViewCell
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true


        let stringURL = outputs[indexPath.item]
        ImageLoader.sharedLoader.imageForUrl(stringURL, completionHandler:{(image: UIImage?, url: String) in
           cell.imageViewCell.image = image
           cell.picture = image!
            print(cell.picture)
            })
        
        return cell
    }
    
    
    //MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("showDetail", sender: ImageCollectionViewCell.self)
        
    }
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showDetail")
        {
            let cell = ImageCollectionViewCell.self;
            if let cell = sender as? ImageCollectionViewCell{
                let imageDetailViewContoller = segue.destinationViewController as! ImageDetailViewController
//                 imageDetailViewContoller.detailImage.image = cell.imageViewCell.image!
                imageDetailViewContoller.detail = cell.picture
                //            imageDetailViewContoller.detail = cell.imageViewCell.image!

            }
            
        }
    }

    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

    @IBAction func selectImageFromPhotoLibrary(sender: UIBarButtonItem) {
        /* Hide the keyboard. This code ensures that if the user taps the image view while typing in the text field, the keyboard is dismissed properly. */
//        nameTextField.resignFirstResponder()
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
       
        let alertController = UIAlertController(title: nil, message: "Would you like to select an image from your Camera Roll or take a new photo with your camera?", preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            // ...
        }
        alertController.addAction(cancelAction)
        
        let cameraRoll = UIAlertAction(title: "Select from Camera Roll", style: .Default) { (action) in
            let imagePickerController = UIImagePickerController()
            /* Only allow photos to be picked, not taken. This sets the image picker controller's source (where it can get pictures) */
            imagePickerController.sourceType = .PhotoLibrary
            // Make sure ViewController is notified when the user picks an image.
            imagePickerController.delegate = self
            self.presentViewController(imagePickerController, animated: true, completion: nil)
        }
        alertController.addAction(cameraRoll)
        
        let newPhoto = UIAlertAction(title: "Take new Photo", style: .Default) { (action) in
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                let picker = UIImagePickerController()
                picker.allowsEditing = false
                picker.sourceType = UIImagePickerControllerSourceType.Camera
                picker.cameraCaptureMode = .Photo
                self.presentViewController(picker, animated: true, completion: nil)
            } else {
                let alertVC = UIAlertController(
                    title: "No Camera",
                    message: "Sorry, this device has no camera",
                    preferredStyle: .Alert)
                let okAction = UIAlertAction(
                    title: "OK",
                    style:.Default,
                    handler: nil)
                alertVC.addAction(okAction)
                self.presentViewController(alertVC,
                                      animated: true,
                                      completion: nil)
            }
        }
        alertController.addAction(newPhoto)
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }

        
        

    }
    
    /// Resize an image based on a scale factor
    func resize(image: UIImage, scale: CGFloat) -> UIImage {
        let size = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(scale,scale))
        let hasAlpha = true
        
        // Automatically use scale factor of main screen
        let scale: CGFloat = 0.0
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
    
    

    
    func uploadRequest(user: NSString, image: UIImage, caption: NSString){
        
        let boundary = generateBoundaryString()
        let scaledImage = resize(image, scale: 1.0)
        let imageJPEGData = UIImageJPEGRepresentation(scaledImage,0.1)
        
        guard let imageData = imageJPEGData else {return}
        
        // Create the URL, the user should be unique
        let url = NSURL(string: "https://stachesandglasses.appspot.com/post/\(user)/")
        
        // Create the request
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Set the type of the data being sent
        let mimetype = "image/jpeg"
        // This is not necessary
        let fileName = "test.png"
        
        // Create data for the body
        let body = NSMutableData()
        body.appendData("\r\n--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        // Caption data
        body.appendData("Content-Disposition:form-data; name=\"caption\"\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("CaptionText\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        // Image data
        body.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("Content-Disposition:form-data; name=\"image\"; filename=\"\(fileName)\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("Content-Type: \(mimetype)\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(imageData)
        body.appendData("\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        // Trailing boundary
        body.appendData("--\(boundary)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        // Set the body in the request
        request.HTTPBody = body
        
        // Create a data task
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            // Need more robust errory handling here
            // 200 response is successful post
            print(response)
            print(error)
            
            // The data returned is the update JSON list of all the images
            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(dataString)
        }
        
        task.resume()
    }
    
    /// A unique string that signifies breaks in the posted data
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }

//    
//    func addAndGetIndexForNewItem() -&gt; Int {
//    
////    let fruit = Fruit(name: "SugarApple", group: "Morning")
//    //read this: http://rshankar.com/uicollectionview-demo-in-swift/
//    let count = outputs.count
//    let index = count &gt; 0 ? count - 1 : count
//    fruits.insert(fruit, atIndex: index)
//    
//    return index
//    }
//    
//    cell.imageViewCell.image
//    
    //MARK: - Delegates
    //What to do when the picker returns with a photo
    func imagePickerController(
        picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
       let uChicagoID = "mhmcdonald"
        let captionForPic = "nope"
        uploadRequest(uChicagoID, image: chosenImage, caption: captionForPic);
        //        let index = dataSource.addAndGetIndexForNewItem()
//        let indexPath = NSIndexPath(forItem: index, inSection: 0)
//        collectionView!.insertItemsAtIndexPaths(12)

//        self.imageViewCell.contentMode = .ScaleAspectFit //3
//        self.imageViewCell.image = chosenImage //4
        dismissViewControllerAnimated(true, completion: nil) //5
    }
    //What to do if the image picker cancels.
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true,
                                      completion: nil)
    }
}


