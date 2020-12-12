//
//  Show.swift
//  test app
//
//  Created by Leonardo Flores Lopez on 12/12/20.
//

import UIKit
import ObjectMapper

class Show: Mappable {
    
    var name    : String!
    var image   : Image!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name    <- map["name"]
        image   <- map["image"]
    }
    
    

}
