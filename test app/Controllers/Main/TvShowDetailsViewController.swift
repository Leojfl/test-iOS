//
//  TvShowDetailsViewController.swift
//  test app
//
//  Created by Leonardo Flores Lopez on 12/12/20.
//

import UIKit

class TvShowDetailsViewController: UIViewController {

    public var tvShowId: Int64!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIUtils.setupNavigationBar(navigationController!.navigationBar)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
