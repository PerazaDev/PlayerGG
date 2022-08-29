//
//  UIImageExtension.swift
//  PlayerGG
//
//  Created by Daniel Sanchez Peraza on 03/07/22.
//

import UIKit
extension UIImageView {
    static let spinner = UIActivityIndicatorView()
    func loadImg(url: URL, completion: @escaping ()->Void = {}) {
        //self.image = nil
        self.showLoading()
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        self?.stopLoading()
                        completion()
                    }
                }
            }
        }
    }

}
