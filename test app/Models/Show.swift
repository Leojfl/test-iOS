//
//  Show.swift
//  test app
//
//  Created by Leonardo Flores Lopez on 12/12/20.
//

import UIKit
import ObjectMapper

class Show: Mappable {
    
    var id              : Int64    = 0
    var name            : String   = ""
    var imgOriginalUrl  : String   = ""
    var imgMediumUrl    : String   = ""
    var summary         : String   = ""
    var imdd            : String   = ""
    var genres          : [String] = []
    var rating          : Double   = 0.0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        imgOriginalUrl  <- map["image.original"]
        summary         <- map["summary"]
        imdd            <- map["externals.imdb"]
        genres          <- map["genres"]
        rating          <- map["rating.average"]
        imgMediumUrl    <- map["image.medium"]
        name            <- map["name"]
    }
    
    //MARK: WS
    
    public static func getShow(showId: Int64, completion: @escaping (_ data: Show?) -> Void){
        Api.getShow(showId:showId, completion: completion)
    }
    
    
    

}
