//
//  Constants.swift
//  test app
//
//  Created by Leonardo Flores  on 11/12/20.
//

class Constants {
    
    private static let production: Bool = false
    
    
    private static let urlDev : String = "http://api.tvmaze.com"
    private static let urlProd: String = "http://api.tvmaze.com"
    public static func getUrl() -> String {
        if production {
            return urlDev
        }
        return urlProd
    }
    
    
    
}
