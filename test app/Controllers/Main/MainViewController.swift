//
//  MainViewController.swift
//  test app
//
//  Created by Leonardo Flores Lopez on 11/12/20.
//

import UIKit

class MainViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    private func setupUI(){
        
        delegate = self
        
        let vcTvShows = makeNavegationController(vienController: "TVShowsViewController",
                                                 title: "TV Shows")
        
        let vcFavorites = makeNavegationController(vienController: "FavoritesViewController",
                                                   title: "Favorites Shows")
        
        viewControllers = [
             vcTvShows,
            vcFavorites
        ]
        
    }
    
    private func makeNavegationController(storiboard: String = "Main", vienController: String, title: String) -> UINavigationController {
        
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let vc = storyboard.instantiateViewController(withIdentifier: vienController)
        vc.title = title
        
        
        if let tvShowsViewController = (vc as? TVShowsViewController) {
            tvShowsViewController.handleSelectTvShow = { tvShowId in
                self.showTvShowDetails(tvShowId: tvShowId)
            }
        }
        
        
        if let favoritesViewController = (vc as? FavoritesViewController) {
            favoritesViewController.handleSelectTvShow = { tvShowId in
                self.showTvShowDetails(tvShowId: tvShowId)
            }
        }
        
        
        
        
        let uiNavegation = UINavigationController(rootViewController: vc)
        UIUtils.setupNavigationBar(uiNavegation.navigationBar)
        
        
        return uiNavegation
    }
    
    private func showTvShowDetails(tvShowId: Int64){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TvShowDetailsViewController") as! TvShowDetailsViewController
        vc.tvShowId = tvShowId
        navigationController?.pushViewController(vc, animated: true)
    }
    
    


}
