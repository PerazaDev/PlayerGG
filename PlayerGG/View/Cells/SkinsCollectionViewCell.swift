//
//  SkinsCollectionViewCell.swift
//  PlayerGG
//
//  Created by Daniel Sanchez Peraza on 03/07/22.
//

import UIKit

class SkinsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLb: UILabel!
    var task : URLSessionDataTask!
    @IBOutlet weak var skinImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure (name : String, skin : URL?){
        if let url = skin {
            self.nameLb.text = name
            self.skinImg.image = nil
            self.task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, let newimage = UIImage(data: data) else {return}
                DispatchQueue.main.async {
                    self.skinImg.image = newimage
                }
            }
            self.task.resume()
            
        }
    }
}
