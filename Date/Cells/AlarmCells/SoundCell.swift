//
//  SoundCell.swift
//  Date
//
//  Created by macbook on 5/3/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import UIKit

class SoundCell: UITableViewCell {
    
    let soundName = UILabel()
    var checkMark = UIImageView()
  
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(red: 108/255, green: 108/255, blue: 130/255, alpha: 1)
        contentView.addSubview(checkMark)
        checkMark.translatesAutoresizingMaskIntoConstraints = false
        checkMark.image = UIImage(named: "check mark")?.withRenderingMode(.alwaysTemplate)
        checkMark.tintColor = .white
        checkMark.isHidden = true
        
        contentView.addSubview(soundName)
        soundName.translatesAutoresizingMaskIntoConstraints = false
        soundName.backgroundColor = .clear
        soundName.textColor = .black
        soundName.font = .systemFont(ofSize: 20)
        soundName.text = ""
        
        
        NSLayoutConstraint.activate([
            
            checkMark.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            checkMark.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            checkMark.heightAnchor.constraint(equalToConstant: 20),
            checkMark.widthAnchor.constraint(equalToConstant: 20),
            checkMark.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            soundName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            soundName.leftAnchor.constraint(equalTo: checkMark.rightAnchor, constant: 15),
            soundName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            soundName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            

            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

