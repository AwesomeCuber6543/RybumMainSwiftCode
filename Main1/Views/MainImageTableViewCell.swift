//
//  MainImageTableViewCell.swift
//  Main1
//
//  Created by yahia salman on 4/28/23.
//

import UIKit

class MainImageTableViewCell: UITableViewCell {

    static let identifier = "MainImageTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
