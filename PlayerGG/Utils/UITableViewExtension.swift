//
//  UITableViewExtension.swift
//  PlayerGG
//
//  Created by Daniel Sanchez Peraza on 03/07/22.
//
import UIKit
extension UITableView {

    func setEmptyMessage(_ message: String, _ fontTextStyle: UIFont.TextStyle = .body, _ numberOfLines: Int = 0, _ alignment: NSTextAlignment = .center) {
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
    
        messageLabel.text = message
        messageLabel.textColor = isDarkMode ? .lightGray : .darkGray
        messageLabel.numberOfLines = numberOfLines
        messageLabel.textAlignment = alignment
        messageLabel.backgroundColor = UIColor(cgColor: .init(gray: 15, alpha: 08))
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
        self.separatorStyle = .none
        
    }

}
