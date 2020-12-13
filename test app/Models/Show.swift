//
//  Show.swift
//  test app
//
//  Created by Leonardo Flores Lopez on 12/12/20.
//

import UIKit
import ObjectMapper

class Show: Mappable {
    
    var id         : Int64  = 0
    var imgOriginal: String = ""
    var summary    : String = ""
    var imdd       : String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        imgOriginal <- map["image.original"]
        summary     <- map["summary"]
        imdd        <- map["externals.imdb"]
    }
    
    

}
