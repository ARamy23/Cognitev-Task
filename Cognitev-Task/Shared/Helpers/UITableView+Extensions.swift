//
//  UITableView+Extensions.swift
//  Cognitev-Task
//
//  Created by Ahmed Ramy on 11/29/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import UIKit

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 17)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
