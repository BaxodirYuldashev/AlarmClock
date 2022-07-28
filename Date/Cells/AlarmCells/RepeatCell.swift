//
//  RepeatCell.swift
//  Date
//
//  Created by macbook on 5/6/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import UIKit

class RepeatCell: UITableViewCell {
    
    let day = UILabel()
    var checkMark = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(red: 108/255, green: 108/255, blue: 130/255, alpha: 1)
        
        contentView.addSubview(day)
        day.translatesAutoresizingMaskIntoConstraints = false
        day.backgroundColor = .clear
        day.textColor = .black
        day.font = .systemFont(ofSize: 20)
        
        contentView.addSubview(checkMark)
        checkMark.translatesAutoresizingMaskIntoConstraints = false
        checkMark.image = UIImage(named: "check mark")?.withRenderingMode(.alwaysTemplate)
        checkMark.tintColor = .white
        checkMark.isHidden = true
        
        NSLayoutConstraint.activate([
            
            day.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            day.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            day.rightAnchor.constraint(equalTo: checkMark.leftAnchor, constant: -10),
            day.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            checkMark.topAnchor.constraint(equalTo: day.topAnchor),
            checkMark.heightAnchor.constraint(equalToConstant: 20),
            checkMark.widthAnchor.constraint(equalToConstant: 20),
            checkMark.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            
      
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

