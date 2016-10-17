//
//  LAGCellTableViewCell.swift
//  ListAppGrability
//
//  Created by Carlos Parada on 10/9/16.
//  Copyright © 2016 carlosparada. All rights reserved.
//

import UIKit

class LAGCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageAppView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameAppLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var viewBack: UIView!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewBack.clipsToBounds = true
        self.viewBack.layer.cornerRadius = 10
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected == true {
            
            self.backgroundColor = UIColor.orangeEnable
            
        } else {
            self.backgroundColor = UIColor.lightGreen
            
        }
        
    }
    
}

class LAGCAtegoryCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageCateView: UIImageView!
    @IBOutlet weak var nameCateLabel: UILabel!
    @IBOutlet weak var viewBack: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewBack.clipsToBounds = true
        self.viewBack.layer.cornerRadius = 10
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected == true {
            
            self.backgroundColor = UIColor.orangeEnable
            
        } else {
            self.backgroundColor = UIColor.lightGreen
            
        }
        
    }
    
}

class LAGDetailCell: UITableViewCell {
    var cell: UITableViewCell!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descritionLabel: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.cell.viewBack.clipsToBounds = true
//        self.cell.viewBack.layer.cornerRadius = 10
    }
    
 
    
}
