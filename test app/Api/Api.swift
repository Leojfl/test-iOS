//
//  Api.swift
//  test app
//
//  Created by Leonardo Flores Lopez on 11/12/20.
//
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class Api {
    
    public static func getTvShows(query: String, completion: @escaping (_ data: [TVShow]?) -> Void){
        let url = "\(Constants.getUrl())/search/shows?q=\(query)"
        Api.requestGet(url: url, completion: completion)
    }
    
    public static func getShow(showId: Int64, completion: @escaping (_ data: Show?) -> Void){
        let url = "\(Constants.getUrl())/shows/\(showId)"
        Api.requestGet(url: url, completion: completion)
    }
    
    // MARK: Request functions
    private static func requestGet<T>(url: String, completion: @escaping (_ data: [T]?) -> Void) where T: Mappable {

        AF.request(url, method: .get).responseArray { (response: DataResponse<[T], AFError>) in
            debugPrint("---------------")
            debugPrint("GET METHOD CALL")
            debugPrint(url)
            debugPrint("---------------")
            debugPrint(response)
            if response.error != nil {
                NSLog("API error: \(String(describing: response.error))")
                completion(nil)
            } else {
                completion(response.value!)
            }
        }
    }

    private static func requestGet<T>(url: String, completion: @escaping (_ data: T?) -> Void) where T: Mappable {

        AF.request(url, method: .get).responseObject { (response: DataResponse<T, AFError>) in
            debugPrint("---------------")
            debugPrint("GET METHOD CALL")
            debugPrint(url)
            debugPrint("---------------")
            debugPrint(response)
            if response.error != nil {
                NSLog("API error: \(String(describing: response.error))")
                completion(nil)
            } else {
                completion(response.value!)
            }
        }
    }
    
  
}
