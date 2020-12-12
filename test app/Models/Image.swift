//
//  Image.swift
//  test app
//
//  Created by Leonardo Flores Lopez on 12/12/20.
//

import UIKit
import ObjectMapper

class Image: Mappable {
    var medium: String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        medium <- map["medium"]
    }
    

}
