//
//  Utils.swift
//  test app
//
//  Created by Leonardo Flores Lopez on 12/12/20.
//
import UIKit

class UIUtils{
   
    public static func showAlert(controller: UIViewController, title: String, message: String, btnString: String = "Aceptar"){
     
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btnString, style: UIAlertAction.Style.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
        
    }
    
}
