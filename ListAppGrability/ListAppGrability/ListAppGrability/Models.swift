//
//  AppModel.swift
//  ListAppGrability
//
//  Created by Carlos Parada on 5/10/16.
//  Copyright © 2016 carlosparada. All rights reserved.
//

import UIKit
import ObjectMapper
import AlamofireObjectMapper


class ResponseModel: Mappable {
    var author : String?
    var authorURL : String?
    var entry : [AppModel]?
    var updated : String?
    var rights : String?
    var tittle : String?
    var iconURL : String?
    var link : [LinkModel]?
    var idResponse : String?
    
    required init?(_ map: Map) {
        // subClasses must call the constructor of the base class
        // super.init(map)
        
    }
    
    func mapping(map: Map) {
        author <- map["feed.author.name.label"]
        authorURL <- map ["feed.author.uri.label"]
        entry <- map ["feed.entry"]
        updated <- map["feed.updated.label"]
        rights <- map ["feeed.rights.label"]
        tittle <- map ["feed.title.label"]
        iconURL <-  map["feed.icon.label"]
        link <- map["feed.link"]
        idResponse <- map["feed.id.label"]
    
    }
    

}
/*
 .link
    .attributes
        .rel
        .type
        .href
 */
class LinkModel: Mappable {
    
    var rel : String?
    var type : String?
    var href : String?
    // MARK: Mappable
    required init?(_ map: Map) {
        // subClasses must call the constructor of the base class
        // super.init(map)
        //self.init()
    }
    
    func mapping(map: Map) {
        rel <- map["attributes.rel"]
        type <- map["attributes.type"]
        href <- map["attributes.href"]

    
    }
}

class AppModel: Mappable {
    var name: String?
    var images: [ImageModel]? //Array
    var summary : String?
    var price : Float!
    var currency : String?
    var contentType : String?
    var rights : String?
    var title: String?
    var linkHref: String?
    var idUrl: String?
    var idId : String?
    var idBundle : String?
    var artist :  ArtistModel?
    var category : CategoryModel?
    var releaseDate : String?
 
    init(name: String, images: [ImageModel] ,summary : String , price : Float , currency : String , contentType : String , rights : String , title : String , linkHref : String , idUrl : String , idId : String , idBundle : String , artist :ArtistModel ,category: CategoryModel ,releaseDate : String ) {
        self.name = name
        self.images = images
        self.summary = summary
        self.price = price
        self.currency = currency
        self.contentType   = contentType
        self.rights = rights
        self.title =  title
        self.linkHref = linkHref
        self.idUrl = idUrl
        self.idId = idId
        self.idBundle = idBundle
        self.artist = artist
        self.category = category
        self.releaseDate  = releaseDate
    }
    
    // MARK: Mappable
    required init?(_ map: Map) {
        // subClasses must call the constructor of the base class
        // super.init(map)
        //self.init()
    }
    
    func mapping(map: Map) {
        name <- map["im:name.label"]
        images  <- map["im:image"]
        summary <- map["summary.label"]
        price <- map["im:price.attributes.amount"]
        currency <- map["im:price.attributes.currency"]
        contentType <- map["im:contentType.attributes.term"]
        rights <- map["rights.label"]
        title <- map["title.label"]
        linkHref <- map["link.attributes.href"]
        idUrl <- map["id.label"]
        idId <- map["id.attributes.im:id"]
        idBundle <- map["id.attributes.im:bundleId"]
        artist <- map["im:artist"]
        category <- map["category"]
        releaseDate <- map["im:releaseDate.attributes.label"]
        
    }
}

class ImageModel: Mappable {
    var imageURL : String?
    var height : Int?
    // MARK: Mappable
    required init?(_ map: Map) {
        // subClasses must call the constructor of the base class
        // super.init(map)
        //self.init()
    }
    
    func mapping(map: Map) {
        imageURL <- map["label"]
        height  <- map["attributes.height"]
    }
}
/*
 .im:artist
    .label
    .attributes
        .href
 */
class ArtistModel: Mappable {
    var nameArtist : String?
    var urlArtist : String?
    
    init(nameArtist: String, urlArtist: String) {
        self.nameArtist = nameArtist
        self.urlArtist = urlArtist
    }
    
    // MARK: Mappable
    required init?(_ map: Map) {
        // subClasses must call the constructor of the base class
        // super.init(map)
        //self.init()
    }
    
    func mapping(map: Map) {
        nameArtist <- map["label"]
        urlArtist  <- map["attributes.href"]
    }
}
/*
 .category
    .attributes
        .im:id
        .term
        .scheme
        .label
 */
class CategoryModel: Mappable {
    
    var idCategory : String?
    var term : String?
    var scheme : String?
    var nameCategory : String?
    
    // MARK: Mappable
    required init?(_ map: Map) {
        // subClasses must call the constructor of the base class
        // super.init(map)
        //self.init()
    }
    
    func mapping(map: Map) {
        idCategory <- map["attributes.im:id"]
        term  <- map["attributes.term"]
        scheme <- map["attributes.scheme"]
        nameCategory <- map["attributes.label"]
    }
    
}
/*
Author
 .name
    .label
 .uri
    .label
 
Entry
 .in:name
    .label
 .im:image
    .label
    .attributes
        .height
 .summary
    .label
 .im:price
    .label
    .attributes
        .amount
        .currency
 .im:contentType
    .attributes
        .term
        .label
 .rights
    .label
 .title
    .label
 .link
    .attributes
        .rel
        .type
        .href
 .id
    .label
    .attributes
        .im:id
        .im:bundleId
 .im:artist
    .label
    .attributes
        .href
 .category
    .attributes
        .im:id
        .term
        .scheme
        .label
 .im:releaseDate
    .label
    .attributes
        .label
 
updated
 .label
rights
 .label
title
 .label
icon
 .label
link
 .attributes
    .rel
    .type
    .href
id
 .label

 
class AppleResponse : Mappable{
    var <#name#> = <#value#>
}    
*/


