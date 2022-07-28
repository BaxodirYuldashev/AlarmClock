//
//  LapCell.swift
//  Date
//
//  Created by macbook on 6/2/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import UIKit

class LapCell: UITableViewCell {
    
    let lapLbl = UILabel()
    let lapTimesLbl = UILabel()
    let overallTimesLbl = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(red: 205/255, green: 205/255, blue: 205/255, alpha: 1)
        
        contentView.addSubview(lapLbl)
        lapLbl.translatesAutoresizingMaskIntoConstraints = false
        lapLbl.backgroundColor = .clear
        lapLbl.textAlignment = .center
        
        contentView.addSubview(lapTimesLbl)
        lapTimesLbl.translatesAutoresizingMaskIntoConstraints = false
        lapTimesLbl.backgroundColor = .clear
        lapTimesLbl.textColor = .purple
        lapTimesLbl.textAlignment = .center
        
        contentView.addSubview(overallTimesLbl)
        overallTimesLbl.translatesAutoresizingMaskIntoConstraints = false
        overallTimesLbl.backgroundColor = .clear
        overallTimesLbl.textColor = .red
        overallTimesLbl.textAlignment = .center
        
        NSLayoutConstraint.activate([
            
            lapLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            lapLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            lapLbl.rightAnchor.constraint(equalTo: lapTimesLbl.leftAnchor, constant: -30),
            lapLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            lapTimesLbl.topAnchor.constraint(equalTo: lapLbl.topAnchor),
            lapTimesLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -10),
            lapTimesLbl.rightAnchor.constraint(equalTo: overallTimesLbl.leftAnchor, constant: -20),
            lapTimesLbl.bottomAnchor.constraint(equalTo: lapLbl.bottomAnchor),
            
            overallTimesLbl.topAnchor.constraint(equalTo: lapLbl.topAnchor),
            overallTimesLbl.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            overallTimesLbl.bottomAnchor.constraint(equalTo: lapLbl.bottomAnchor),
            
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
