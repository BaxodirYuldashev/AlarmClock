//
//  Header.swift
//  Date
//
//  Created by macbook on 5/1/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import UIKit

class Header: UITableViewHeaderFooterView {
    
    let label = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(red: 48/255, green: 48/255, blue: 60/255, alpha: 1)
        
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sounds"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 22)
        
        
        NSLayoutConstraint.activate([
            
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            label.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -20),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            ])
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
