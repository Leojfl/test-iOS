//
//  Extencion.swift
//  test app
//
//  Created by Leonardo Flores Lopez on 11/12/20.
//

import UIKit

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
        print(url)
        print(urlString)
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
