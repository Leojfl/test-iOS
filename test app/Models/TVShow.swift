//
//  TVShow.swift
//  test app
//
//  Created by Leonardo Flores Lopez on 11/12/20.
//

import UIKit
import ObjectMapper
import RealmSwift

class TVShow:Object, Mappable {
    

    @objc dynamic var id            : Int64  = 0
    @objc dynamic var name          : String = ""
    @objc dynamic var imgMediumUrl  : String = ""
    
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
     
    func mapping(map: Map) {
        id              <- map["show.id"]
        name            <- map["show.name"]
        imgMediumUrl    <- map["show.image.medium"]
    }
    
    
    //MARK: WS
    
    public static func getTVShows(query: String = "terror", completion: @escaping (_ data: [TVShow]?) -> Void){
        Api.getTvShows(query:query, completion: completion)
    }
    
    //MARK: DB
    
    public static func isFavorite(tvShow: TVShow) -> Bool {
        let realm = try! Realm()
        let favoriteShow = realm.objects(TVShow.self).filter("id == \(tvShow.id)").first
        let isFavorite = favoriteShow != nil
        return isFavorite
    }
    
    public static func saveFavorite(tvShow: TVShow, completion: @escaping (_ result: Bool) -> Void) {
        let realm = try! Realm()
        let favoriteShow = realm.objects(TVShow.self).filter("id == \(tvShow.id)").first
        if favoriteShow != nil {
            completion(true)
            return
        }
        
        do {
            try realm.write {
                realm.add(tvShow)
            }
            completion(true)
            return
        } catch {
            NSLog("DB error: \(String(describing: error))")
        }
        completion(false)
        return
    }
    
    
    public static func deleteFavorite(tvShow: TVShow, completion: @escaping (_ result: Bool) -> Void) {
        let realm = try! Realm()
        let favoriteShow = realm.objects(TVShow.self).filter("id == \(tvShow.id)").first
        if favoriteShow == nil {
            completion(true)
            return
        }
        
        do {
            try realm.write {
                realm.delete(favoriteShow!)
            }
            completion(true)
            return
        } catch {
            NSLog("DB error: \(String(describing: error))")
        }
        completion(false)
        return
    }
}
