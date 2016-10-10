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
    
    var arrayCategoryCD : [Category]!
    var arrayDirtCategoryCD : [Category]!
    
    var stateTableView : Bool = false
    var listInTableView : String = "Cate"
    
    var ImageCache = [String:UIImage]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewMiddleHome: UIView!
    
    
    @IBOutlet weak var appButton: UIButton!
    @IBOutlet weak var cateButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "LAGCell", bundle: nil), forCellReuseIdentifier: "myLAGCell")
        self.tableView.registerNib(UINib(nibName: "LAGCategoryCell", bundle: nil), forCellReuseIdentifier: "myLAGCategoryCell")
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = viewMiddleHome.bounds
        gradient.colors = [UIColor.whiteColor().CGColor, UIColor.blackColor().CGColor]
        view.layer.insertSublayer(gradient, atIndex: 0)
        print("Array Dirt \(arrayDirtCategoryCD.count)")
        arrayCategoryCD = arrayDirtCategoryCD.filterDuplicates {
            $0.idCategory == $1.idCategory && $0.nameCategory == $1.nameCategory
        }
        print("Array Clean \(arrayCategoryCD.count)")
        
        appButton.addTarget(self, action: #selector(LAGHomeViewController.showApp(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cateButton.addTarget(self, action: #selector(LAGHomeViewController.showCate(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        //then make a action method :
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.stateTableView == true {
            return self.arrayAppCD.count
        }else{
            return self.arrayCategoryCD.count
        }
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        if self.stateTableView == true {
            return 72
        }else{
            return 72
        }
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        tableView.backgroundColor = UIColor.lightGreen
        cell.backgroundColor = UIColor.lightGreen
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if self.stateTableView == true {
            let cell : LAGCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("myLAGCell", forIndexPath: indexPath) as! LAGCellTableViewCell
            cell.numberLabel.text = String(indexPath.row + 1)
            cell.nameAppLabel.text = arrayAppCD[indexPath.row].name
            cell.categoryLabel.text = arrayAppCD[indexPath.row].category!.nameCategory
            cell.imageAppView.clipsToBounds = true
            cell.imageAppView.layer.cornerRadius = 10.0
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
        }else{
            let cell : LAGCAtegoryCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("myLAGCategoryCell", forIndexPath: indexPath) as! LAGCAtegoryCellTableViewCell
            cell.nameCateLabel.text = arrayCategoryCD[indexPath.row].nameCategory
            
            
            return cell
        }
        
       
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func showApp(sender:UIButton!) {
        if self.stateTableView == false && self.listInTableView == "Cate"{
            self.stateTableView = true
            self.listInTableView = "App"
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }else{
//            self.stateTableView = true
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                self.tableView.reloadData()
//            })
        }
    }
    func showCate(sender:UIButton!) {
        if self.stateTableView == true && self.listInTableView == "App"{
            self.stateTableView = false
            self.listInTableView = "Cate"
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }else{
           //
        }
    }
    
}

extension Array {
    
    func filterDuplicates(@noescape includeElement: (lhs:Element, rhs:Element) -> Bool) -> [Element]{
        var results = [Element]()
        
        forEach { (element) in
            let existingElements = results.filter {
                return includeElement(lhs: element, rhs: $0)
            }
            if existingElements.count == 0 {
                results.append(element)
            }
        }
        
        return results
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
