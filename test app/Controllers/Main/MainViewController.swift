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
    
    
    private func setupUI(){
        delegate = self
        
        let vcTvShows = makeNavegationController(vienController: "TVShowsViewController",
                                                 title: "TV show")
        
        let vcFavorites = makeNavegationController(vienController: "FavoritesViewController",
                                                   title: "Favoritos")
        
        viewControllers = [ vcTvShows ,  vcFavorites ]
        
    }
    
    private func makeNavegationController(storiboard: String = "Main", vienController: String, title: String) -> UINavigationController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let vc = storyboard.instantiateViewController(withIdentifier: vienController)
        vc.title = title

        return UINavigationController(rootViewController: vc)
    }
    
    


}
