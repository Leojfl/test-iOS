//
//  TVShow.swift
//  test app
//
//  Created by Leonardo Flores Lopez on 11/12/20.
//

import UIKit
import ObjectMapper

class TVShow: Mappable {
    
    var score   : Double!
    var show    : Show!
    
    required init?(map: Map) {
       
    }
    
    func mapping(map: Map) {
        score <- map["score"]
        show  <- map["show"]
    }
    
    
    //MARK: WS
    
    public static func getTVShows(query: String = "terror", completion: @escaping (_ data: [TVShow]?) -> Void){
        Api.getTvShows(query:query, completion: completion)
    }
    
    
    //MARK: DB
    

}
