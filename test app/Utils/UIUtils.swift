//
//  Utils.swift
//  test app
//
//  Created by Leonardo Flores Lopez on 12/12/20.
//
import UIKit

class UIUtils{
   
    public static func showAlert(controller: UIViewController, title: String, message: String, btnOKString: String = "Aceptar"){
    
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btnOKString, style: UIAlertAction.Style.default, handler: nil))
        controller.navigationController?.present(alert, animated: true, completion: nil)
        
    }
    public static func showAlert(controller: UIViewController, title: String, message: String , btnOKString: String = "Aceptar", btnCancelString: String = "Cancelar", handlerOK: @escaping ((UIAlertAction) -> Void)){
    
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btnOKString, style: UIAlertAction.Style.default, handler: handlerOK))
        alert.addAction(UIAlertAction(title: btnCancelString, style: UIAlertAction.Style.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
        
    }
    
}
