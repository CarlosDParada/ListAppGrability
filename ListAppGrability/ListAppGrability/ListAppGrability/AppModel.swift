//
//  AppModel.swift
//  ListAppGrability
//
//  Created by Carlos Parada on 5/10/16.
//  Copyright © 2016 carlosparada. All rights reserved.
//

import UIKit
import ObjectMapper

class AppModel: Mappable {
    var name: String?
    var imageURL: String?
    
    init(name: String, imageURL: String) {
        self.name = name
        self.imageURL = imageURL
    }
    
    // MARK: Mappable
    required init?(map: Map) {
        // subClasses must call the constructor of the base class
        // super.init(map)
        //self.init()
    }
    
    func mapping(map: Map) {
        name <- map["im:name.label"]
        imageURL  <- map["im:image.label"]
    }
}
