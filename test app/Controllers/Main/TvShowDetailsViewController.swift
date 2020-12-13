//
//  TvShowDetailsViewController.swift
//  test app
//
//  Created by Leonardo Flores Lopez on 12/12/20.
//

import UIKit

class TvShowDetailsViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var ivOriginal: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var lblRanking: UILabel!
    @IBOutlet weak var vRanking: UIView!
    @IBOutlet weak var lblGenres: UILabel!
    @IBOutlet weak var btnIMDb: UIButton!
    @IBOutlet weak var btnFavorite: UIButton!
    
    public var showId               : Int64!
    public var handleDeleteTvShow   : ((_ tvShowId: Int64, _ completion: @escaping (()-> Void )) -> Void)!
    public var handleFavoriteTvShow : ((_ tvShow: TVShow, _ completion:  @escaping (()-> Void )) -> Void)!
    
    private var urlIMDb     : String = ""
    private var isFavorite  : Bool   = true
    private var show        : Show!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func onClickBtnIMDb(_ sender: Any) {
        
        if let url = URL(string: urlIMDb) {
            UIApplication.shared.open(url)
        }
    
    }
    
    @objc
    func onClickBtnFavorite(_ sender: Any){
        
        if isFavorite {
            handleDeleteTvShow(showId) {
                self.setupBtnFavorite()
                self.isFavorite = !self.isFavorite
            }
        } else {
            let tvShow = TVShow()
            tvShow.id = show.id
            tvShow.name = show.name
            tvShow.imgMediumUrl = show.imgMediumUrl
            
            handleFavoriteTvShow(tvShow) {
                self.setupBtnDelete()
                self.isFavorite = !self.isFavorite
            }
        }
    }
    

    
    private func setupUI(){
        UIUtils.setupNavigationBar(navigationController!.navigationBar)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        Show.getShow(showId: showId) { (show) in
            
            if show == nil{
                
                UIUtils.showAlert(controller: self,
                                  title:"Oops, algo salió mal!",
                                  message:"Por favor intenta más tarde")
                return
            }
            
            self.show = show
            
        
            self.ivOriginal.loadFrom(urlString: show!.imgOriginalUrl)
            
            if show!.genres.count > 0{
                var generes =  show!.genres.reduce("", { $0+", "+$1 })
                generes = String(generes.dropFirst())
                self.lblGenres.text = generes
            }
            
            if show!.rating != 0.0 {
                self.lblRanking.text = "\(show!.rating)"
            }
            
            self.lblSummary.attributedText = show!.summary.htmlToAttributedString
            
            if show!.imdd != "" {
                self.btnIMDb.isHidden = false
                self.urlIMDb = "\(Constants.getUrlImdb())/\(show!.imdd)"
            }
            
            self.spinner.stopAnimating()
            self.setupBtnDelete()
            
            self.isFavorite = TVShow.isFavorite(tvShowId: show!.id)
            
            if self.isFavorite {
                self.setupBtnDelete()
            }else{
                self.setupBtnFavorite()
            }
            
            self.btnFavorite.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onClickBtnFavorite(_:))))
            self.lblTitle.text = show!.name
        }
        
    }
    
    private func setupBtnDelete(){
        
        self.btnFavorite.setTitle("Delete", for: .normal)
        self.btnFavorite.backgroundColor = .red
        
    }
    
    private func setupBtnFavorite(){
        
        self.btnFavorite.setTitle("Favorite", for: .normal)
        self.btnFavorite.backgroundColor = .green
        
    }
    
    
    
    

    
}
