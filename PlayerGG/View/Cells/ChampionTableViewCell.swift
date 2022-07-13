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
            self.nameLabel.text = name
            if let url = icon {
                self.championsImg.image = nil
                self.task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, let newimage = UIImage(data: data) else {return}
                    DispatchQueue.main.async {
                        self.championsImg.image = newimage
                    }
                }
                self.task.resume()
                
            }
        
    }
    
}
