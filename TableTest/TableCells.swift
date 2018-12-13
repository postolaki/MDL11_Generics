//
//  TableCells.swift
//  TableTest
//
//  Created by Igors Nemenonoks on 27/08/2017.
//  Copyright © 2017 Chili. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell, ConfigurableCell {
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!

    private var configurator: CellConfigurator!
    
    func configure(data: User, configurator: CellConfigurator) {
        self.configurator = configurator
        avatarView.image = UIImage(named: data.imageName)
        userNameLabel.text = data.name
    }
    
    @IBAction func onFollowTap(_ sender: Any) {
        configurator.actionProxy?.invoke(action: .custom(.followUser), cell: self, configurator: configurator)
    }
}


class MessageCell: UITableViewCell, ConfigurableCell {
    @IBOutlet weak var messageLabel: UILabel!

    func configure(data message: String, configurator: CellConfigurator) {
        messageLabel.text = message
    }
}


class ImageCell: UITableViewCell, ConfigurableCell {
    @IBOutlet weak var pictureView: UIImageView!
    
    private var configurator: CellConfigurator!

    func configure(data url: URL, configurator: CellConfigurator) {
        self.configurator = configurator
        if let data = try? Data(contentsOf: url) {
            self.pictureView.image = UIImage(data: data)
        }
    }
    
    @IBAction func didPressButton(_ sender: UIButton) {
        configurator.actionProxy?.invoke(action: .custom(.simpleButton), cell: self, configurator: configurator)
    }
}

class WarningCell: UITableViewCell, ConfigurableCell {
    @IBOutlet weak var messageLabel: UILabel!
    
    func configure(data message: String, configurator: CellConfigurator) {
        messageLabel.text = message
    }
}
