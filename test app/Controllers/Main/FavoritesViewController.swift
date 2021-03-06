//
//  FavoritesViewController.swift
//  test app
//
//  Created by Leonardo Flores Lopez on 11/12/20.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableFavorites: UITableView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    public var handleSelectTvShow   : ((_ tvShowId:Int64)-> Void)!
    public var handleDeleteTvShow   : ((_ tvShowId: Int64, _ completion: @escaping (()-> Void )) -> Void)!
    
    private var favorites:[TVShow] = []
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    
    private func setupUI() {
        lblTitle.text = title
        setupStatusBarAndNavigationBar()
        setupTableFavorites()
    }
    
    private func setupTableFavorites() {
        tableFavorites.dataSource = self
        tableFavorites.delegate = self
        tableFavorites.tableFooterView = UIView()
        tableFavorites.reloadData("Sin favoritos")
        tableFavorites.register(UINib(nibName: "TVShowTableViewCell", bundle: nil), forCellReuseIdentifier: "TVShowTableViewCell")
    }
    
    private func getFavorites(){
        TVShow.getFavorites { (favorites) in
            self.favorites = favorites
            self.tableFavorites.reloadData("Sin favoritos")
        }
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "TVShowTableViewCell", for: indexPath) as! TVShowTableViewCell
        tableViewCell.setupUI(tvShow: self.favorites[indexPath.row])
        tableViewCell.accessoryType = .disclosureIndicator
        
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        handleDeleteTvShow(self.favorites[indexPath.row].id){
            self.favorites.remove(at: indexPath.row)
            self.tableFavorites.deleteRows(at: [indexPath], with: .automatic)
        }

    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let deleteButton = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            self.tableFavorites.dataSource?.tableView!(self.tableFavorites, commit: UITableViewCell.EditingStyle.delete, forRowAt: indexPath)
            return
        }

        deleteButton.backgroundColor = UIColor.red

        return [deleteButton]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleSelectTvShow?(self.favorites[indexPath.row].id)
    }
    
    
}
