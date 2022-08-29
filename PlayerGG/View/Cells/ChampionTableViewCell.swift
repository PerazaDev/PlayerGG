//
//  ChampionTableViewCell.swift
//  PlayerGG
//
//  Created by Daniel Sanchez Peraza on 02/07/22.
//

import UIKit

class ChampionTableViewCell: UITableViewCell {
    var task : URLSessionDataTask!
    @IBOutlet weak var championsImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell (name :String, icon : URL?){
       
        self.championsImg.layer.cornerRadius = self.championsImg.layer.bounds.height/2
        if let url = icon {
            
            self.nameLabel.text = name
            DispatchQueue.main.async {
                self.championsImg.loadImg(url: url)
            }
        }
    }
}
