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
    
    
    @IBOutlet weak var viewApplication: UIView!
    @IBOutlet weak var appButton: UIButton!
    @IBOutlet weak var indAppView: UIView!
    @IBOutlet weak var viewCategory: UIView!
    @IBOutlet weak var cateButton: UIButton!
    @IBOutlet weak var indCateView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkStateTableView()
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
    func checkStateTableView() -> Void {
        if self.stateTableView == false {
            viewCategory.layer.cornerRadius = 10.0
            viewCategory.layer.borderWidth = 0.0
            viewCategory.layer.borderColor = UIColor.clearColor().CGColor
            viewCategory.backgroundColor = UIColor.greyDisable
            cateButton.setTitleColor(UIColor.mediumBlue, forState: UIControlState.Normal)
            indCateView.backgroundColor = UIColor.mediumBlue
            
            viewApplication.layer.cornerRadius = 10.0
            viewApplication.layer.borderWidth = 2.0
            viewApplication.layer.borderColor = UIColor.whiteColor().CGColor
            viewApplication.backgroundColor = UIColor.clearColor()
            appButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            //indAppView.backgroundColor = UIColor.clearColor()
            
            
            
            
            
        }else{
            viewCategory.layer.cornerRadius = 10.0
            viewCategory.layer.borderWidth = 2.0
            viewCategory.layer.borderColor = UIColor.whiteColor().CGColor
            viewCategory.backgroundColor = UIColor.clearColor()
            cateButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            indCateView.backgroundColor = UIColor.clearColor()
            
            viewApplication.layer.cornerRadius = 10.0
            viewApplication.layer.borderWidth = 0.0
            viewApplication.layer.borderColor = UIColor.clearColor().CGColor
            viewApplication.backgroundColor = UIColor.greyDisable
            appButton.setTitleColor(UIColor.mediumBlue, forState: UIControlState.Normal)
           // indAppView.backgroundColor = UIColor.mediumBlue
            
        
        }
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
            cell.imageCateView.image = UIImage(named: "\(arrayCategoryCD[indexPath.row].nameCategory!)")
            
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
            self.checkStateTableView()
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
         self.checkStateTableView()
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
