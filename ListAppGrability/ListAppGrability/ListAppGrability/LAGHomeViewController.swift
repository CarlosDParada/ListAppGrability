//
//  LAGHomeViewController.swift
//  ListAppGrability
//
//  Created by Carlos Parada on 10/9/16.
//  Copyright © 2016 carlosparada. All rights reserved.
//

import UIKit
import CoreData
import Foundation
import Alamofire
import AlamofireImage

class LAGHomeViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    var arrayAppCD : [Application]!
    
    var ImageCache = [String:UIImage]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewMiddleHome: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "LAGCell", bundle: nil), forCellReuseIdentifier: "myLAGCell")
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = viewMiddleHome.bounds
        gradient.colors = [UIColor.whiteColor().CGColor, UIColor.blackColor().CGColor]
        view.layer.insertSublayer(gradient, atIndex: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayAppCD.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 70;
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        tableView.backgroundColor = UIColor.lightGreen
        cell.backgroundColor = UIColor.lightGreen
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : LAGCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("myLAGCell", forIndexPath: indexPath) as! LAGCellTableViewCell
        cell.numberLabel.text = String(indexPath.row + 1)
        cell.nameAppLabel.text = arrayAppCD[indexPath.row].name
        cell.categoryLabel.text = arrayAppCD[indexPath.row].category!.nameCategory
        cell.imageAppView.clipsToBounds = true
        cell.imageAppView.layer.cornerRadius = 8.0
        let placeholderImage = UIImage(named: "load")!
        
        var arrayImage : Array = [UIImage]()
        let setUrlIamges : NSSet = arrayAppCD[indexPath.row].image!
        
        for imageUnique in setUrlIamges {
            let imageM = imageUnique as! Image
            let imageURL = imageM.urlIamge
            let url = NSURL(string: imageURL!)
            cell.imageAppView.setImageWithUrl(url!, placeHolderImage: placeholderImage)
            Alamofire.request(.GET, imageURL!).responseImage { response in
                if let imageDown = response.result.value {
                    arrayImage.append(imageDown)
                }
            }
            
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */
