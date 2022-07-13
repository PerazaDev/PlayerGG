//
//  CustomUIImageView.swift
//  PlayerGG
//
//  Created by Daniel Sanchez Peraza on 08/07/22.
//

import UIKit
class CustomUIImageView : UIImageView {
    var task : URLSessionDataTask!
    
    func imageFromURL (url : URL){
        image = nil
      
        task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let newimage = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                self.image = newimage
            }
        }
        task.resume()
    }
}
