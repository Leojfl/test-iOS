//
//  Extencion.swift
//  test app
//
//  Created by Leonardo Flores Lopez on 11/12/20.
//

import UIKit
import RealmSwift


extension UITableView {
    
    /// Allow to add a message when UITableView doesn't have items
    func setEmptyMessage(_ message: String) {
        if self.visibleCells.isEmpty {
            let messageLbl = UILabel(frame: CGRect(
                x: 0,
                y: 0,
                width: self.bounds.size.width,
                height: self.bounds.size.height
            ))
            
            messageLbl.text = message
            messageLbl.textColor = .black
            messageLbl.numberOfLines = 0
            messageLbl.textAlignment = .center
            messageLbl.sizeToFit()
            
            self.backgroundView = messageLbl
            self.separatorStyle = .none
        }
    }
    
    func resetBackground() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
    func reloadData(_ emptyMessage: String, withAutoHeight: Bool = false) {
        reloadData()
        
        if visibleCells.isEmpty {
            setEmptyMessage(emptyMessage)
        } else {
            resetBackground()
        }
    }
}
extension UIImageView {
    func loadFrom(urlString: String) {
        let url: URL? = URL(string: urlString)
        if url == nil {
            self.image = UIImage()
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}

extension UIViewController {
    
    func setupStatusBarAndNavigationBar(){
        navigationController?.setNavigationBarHidden(true, animated: true)
        if #available(iOS 11.0, *) {
            UIUtils.setupStatusBar(color: UIColor(named: "Purple")!)
        } else {
            UIUtils.setupStatusBar(color: #colorLiteral(red: 0.4791333079, green: 0.2467545271, blue: 0.9959545732, alpha: 1))
        }
    }
}
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
