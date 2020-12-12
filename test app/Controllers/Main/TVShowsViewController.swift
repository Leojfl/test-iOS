//
//  TVShowsViewController.swift
//  test app
//
//  Created by Leonardo Flores Lopez on 11/12/20.
//

import UIKit

class TVShowsViewController: UIViewController {
    
    
    @IBOutlet weak var tableTVshows: UITableView!
    
    private var tvShows:[TVShow] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    private func setupUI(){
        
        tableTVshows.dataSource = self
        tableTVshows.delegate = self
        tableTVshows.reloadData("No se encontraron shows para ver")
        tableTVshows.register(UINib(nibName: "TVShowTableViewCell", bundle: nil), forCellReuseIdentifier: "TVShowTableViewCell")
        
        TVShow.getTVShows{ tvShows in
            if tvShows == nil {
                UIUtils.showAlert(controller: self, title:"Oops, algo salió mal!”", message:"por favorintenta más tarde")
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

        return tableViewCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
