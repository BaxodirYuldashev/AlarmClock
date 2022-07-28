//
//  BasicCell.swift
//  Date
//
//  Created by macbook on 4/14/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import UIKit

class BasicCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let desc = UILabel()
    let rightIcon = UIImageView()
    let mySwitch = UISwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(red: 108/255, green: 108/255, blue: 130/255, alpha: 1)
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 18)
        
        
        contentView.addSubview(desc)
        desc.translatesAutoresizingMaskIntoConstraints = false
        desc.backgroundColor = .clear
        desc.textColor = .white
        desc.numberOfLines = 0
        
        contentView.addSubview(rightIcon)
        rightIcon.translatesAutoresizingMaskIntoConstraints = false
        rightIcon.image = UIImage(named: "right arrow")?.withRenderingMode(.alwaysTemplate)
        rightIcon.tintColor = .white
        
        contentView.addSubview(mySwitch)
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
        mySwitch.isHidden = true
        mySwitch.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        
        NSLayoutConstraint.activate([
            
            titleLabel.centerYAnchor.constraint(equalTo: desc.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(lessThanOrEqualTo: desc.leftAnchor, constant: -10),
            
            desc.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            desc.rightAnchor.constraint(equalTo: rightIcon.leftAnchor, constant: -10),
            desc.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            rightIcon.centerYAnchor.constraint(equalTo: desc.centerYAnchor),
            rightIcon.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            rightIcon.heightAnchor.constraint(equalToConstant: 15),
            rightIcon.widthAnchor.constraint(equalTo: rightIcon.heightAnchor),
            
            mySwitch.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mySwitch.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            mySwitch.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
