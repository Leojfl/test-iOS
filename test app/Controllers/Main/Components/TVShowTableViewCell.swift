//
//  TVShowTableViewCell.swift
//  test app
//
//  Created by Leonardo Flores Lopez on 11/12/20.
//

import UIKit

class TVShowTableViewCell: UITableViewCell {

    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    public func setupUI(tvShow: TVShow){
        
        lblTitle.text = tvShow.show.name
        ivImage.loadFrom(urlString: tvShow.show.image.medium)
        
        
    }
    
}
