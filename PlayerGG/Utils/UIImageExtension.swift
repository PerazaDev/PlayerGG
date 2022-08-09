//
//  UIImageExtension.swift
//  PlayerGG
//
//  Created by Daniel Sanchez Peraza on 03/07/22.
//

import UIKit
extension UIImageView {
    static let spinner = UIActivityIndicatorView()
    func loadImg(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    func showSpinner () {
        self.addSubview(UIImageView.spinner)
        UIImageView.spinner.translatesAutoresizingMaskIntoConstraints = false
        UIImageView.spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        UIImageView.spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        UIImageView.spinner.startAnimating()
    }
    func hideSpinner (){
        UIImageView.spinner.removeFromSuperview()
    }
}
