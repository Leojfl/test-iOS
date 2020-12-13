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
            tvShowsViewController.handleSelectTvShow = { showId in
                self.showTvShowDetails(showId: showId)
            }
            
            tvShowsViewController.handleDeleteTvShow = { tvShowId, completion in
                self.handleDeleteTvShow(tvShowId: tvShowId, completion: completion)
            }
            
            tvShowsViewController.handleFavoriteTvShow = { tvShow, completion in
                self.handleFavoriteTvShow(tvShow: tvShow, completion: completion)
            }
        }
        
        
        if let favoritesViewController = (vc as? FavoritesViewController) {
            favoritesViewController.handleSelectTvShow = { showId in
                self.showTvShowDetails(showId: showId)
            }
            
            favoritesViewController.handleDeleteTvShow = { tvShowId, completion in
                self.handleDeleteTvShow(tvShowId: tvShowId, completion: completion)
            }
        }
        
        let uiNavegation = UINavigationController(rootViewController: vc)
        UIUtils.setupNavigationBar(uiNavegation.navigationBar)
        
        
        return uiNavegation
    }
    
    private func showTvShowDetails(showId: Int64){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TvShowDetailsViewController") as! TvShowDetailsViewController
        vc.showId = showId
        
        vc.handleDeleteTvShow = { tvShowId, completion in
            self.handleDeleteTvShow(tvShowId: tvShowId, completion: completion)
        }
        
        vc.handleFavoriteTvShow = { tvShow, completion in
            self.handleFavoriteTvShow(tvShow: tvShow, completion: completion)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func handleDeleteTvShow(tvShowId: Int64, completion: @escaping (()-> Void)){
        UIUtils.showAlert(controller: self,
                          title: "¿Estás seguro?",
                          message: "Este show de TV se borrara de mis favoritos") { (uialert) in
            TVShow.deleteFavorite(tvShowId: tvShowId) { (isDelete) in
                if  isDelete {
                    completion()
                } else {
                    UIUtils.showAlert(controller: self,
                                      title: "Oops, algo salió mal!",
                                      message: "Hubo un problema al eliminar este show de TV de tus favoritos")
                    
                }
            }
        }
    }
    
    private func handleFavoriteTvShow(tvShow: TVShow, completion: @escaping (()-> Void)){
        
        TVShow.saveFavorite(tvShow: tvShow) { (isSave) in
            if isSave {
                completion()
            } else {
                UIUtils.showAlert(controller: self,
                                  title: "Oops, algo salió mal!",
                                  message: "Hubo un problema al guardar este show de TV")
                
            }
            
        }
    }
    
    
    
    


}
