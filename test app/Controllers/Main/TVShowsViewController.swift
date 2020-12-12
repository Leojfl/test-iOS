//
//  TVShowsViewController.swift
//  test app
//
//  Created by Leonardo Flores Lopez on 11/12/20.
//

import UIKit

class TVShowsViewController: UIViewController {
    
    
    @IBOutlet weak var tableTVshows: UITableView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    private var tvShows:[TVShow] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    private func setupUI() {
        setupTableShows()
        getTVShows()
    }
    
    private func setupTableShows() {
        tableTVshows.dataSource = self
        tableTVshows.delegate = self
        tableTVshows.reloadData("No se encontraron shows para ver")
        tableTVshows.register(UINib(nibName: "TVShowTableViewCell", bundle: nil), forCellReuseIdentifier: "TVShowTableViewCell")
    }
    
    private func getTVShows(){
        TVShow.getTVShows{ tvShows in
            self.spinner.stopAnimating()
            if tvShows == nil {
                UIUtils.showAlert(controller: self,
                                  title:"Oops, algo salió mal!",
                                  message:"por favor intenta más tarde")
                return
            }
            self.tvShows = tvShows!
            self.tableTVshows.reloadData("No se encontraron shows para ver")
        }
    }
    
    public func showSpinner(){
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        
    }

}

extension TVShowsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tvShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "TVShowTableViewCell", for: indexPath) as! TVShowTableViewCell
        tableViewCell.setupUI(tvShow: self.tvShows[indexPath.row])
        tableViewCell.accessoryType = .disclosureIndicator
        
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        switch editingStyle {
        case .delete:
            UIUtils.showAlert(controller: self,
                              title: "¿Estas seguro?",
                              message: "Este show de TV se borrara de mis favoritos") { (uialert) in
                
                self.showSpinner()
                TVShow.deleteFavorite(tvShow: self.tvShows[indexPath.row]) { (isDelete) in
                    self.spinner.stopAnimating()
                    if  isDelete {
                        tableView.reloadRows(at: [indexPath], with: .right)
                    } else {
                        UIUtils.showAlert(controller: self,
                                          title: "Oops, algo salió mal!",
                                          message: "Hubo un problema al eliminar este show de TV de tus favoritos")
                        
                    }
                }
            }
            
            break
        case .insert:
            
            if editingStyle == .insert{
                self.showSpinner()
                
                TVShow.saveFavorite(tvShow: tvShows[indexPath.row]) { (isSave) in
                    
                    self.spinner.stopAnimating()
                
                    if isSave {
                        tableView.reloadRows(at: [indexPath], with: .right)
                    } else {
                        UIUtils.showAlert(controller: self,
                                          title: "Oops, algo salió mal!",
                                          message: "Hubo un problema al guardar este show de TV")
                        
                    }
                    
                }
            }
            break
        default:
            print("No option \(editingStyle)")
        }
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        var text = "Favorite"
        var type = UITableViewCell.EditingStyle.insert
        var backgroundColor = UIColor.green
        
        if TVShow.isFavorite(tvShow: self.tvShows[indexPath.row]) {
            text = "Delete"
            type = UITableViewCell.EditingStyle.delete
            backgroundColor = UIColor.red
        }

        let actionButton = UITableViewRowAction(style: .default, title: text) { (action, indexPath) in
          self.tableTVshows.dataSource?.tableView!(self.tableTVshows, commit: type, forRowAt: indexPath)
          return
        }
        
        actionButton.backgroundColor = backgroundColor
        
        return [actionButton]
    }
    
    
}
