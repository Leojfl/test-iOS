//
//  TVShowsViewController.swift
//  test app
//
//  Created by Leonardo Flores Lopez on 11/12/20.
//

import UIKit

class TVShowsViewController: UIViewController {
    
    
    @IBOutlet weak var tableTVshows: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    
    private var tvShows:[TVShow] = []
    
    public var handleSelectTvShow   : ((_ tvShowId:Int64)-> Void)!
    public var handleDeleteTvShow   : ((_ tvShowId: Int64, _ completion: @escaping (()-> Void )) -> Void)!
    public var handleFavoriteTvShow : ((_ tvShow: TVShow, _ completion:  @escaping (()-> Void )) -> Void)!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    private func setupUI() {
        
        setupStatusBarAndNavigationBar()
        lblTitle.text = title
        setupTableShows()
        getTVShows()
        tableTVshows.reloadData("No se encontraron shows para ver")
    }
    
    private func setupTableShows() {
        tableTVshows.dataSource = self
        tableTVshows.delegate = self
        tableTVshows.tableFooterView = UIView()
        tableTVshows.reloadData("No se encontraron shows para ver")
        tableTVshows.register(UINib(nibName: "TVShowTableViewCell", bundle: nil), forCellReuseIdentifier: "TVShowTableViewCell")
    }
    
    private func getTVShows(){
        TVShow.getTVShows{ tvShows in
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
            
            handleDeleteTvShow(tvShows[indexPath.row].id){
                tableView.reloadRows(at: [indexPath], with: .right)
            }
            
            break
        case .insert:
            handleFavoriteTvShow(tvShows[indexPath.row]){
                tableView.reloadRows(at: [indexPath], with: .right)
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
        
        if TVShow.isFavorite(tvShowId: self.tvShows[indexPath.row].id) {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleSelectTvShow?(self.tvShows[indexPath.row].id)
    }
    
}
