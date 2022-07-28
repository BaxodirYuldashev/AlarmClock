//
//  LapHeader.swift
//  Date
//
//  Created by macbook on 6/2/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import UIKit

class LapHeader: UITableViewHeaderFooterView {
    
    let lapLbl = UILabel()
    let lapTimesLbl = UILabel()
    let overallTimesLbl = UILabel()
    let lineView = UIView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(lapLbl)
        lapLbl.translatesAutoresizingMaskIntoConstraints = false
        lapLbl.backgroundColor = .clear
        lapLbl.text = "Lap"
        lapLbl.font = .systemFont(ofSize: 16, weight: .semibold)
        lapLbl.textAlignment = .center
        
        contentView.addSubview(lapTimesLbl)
        lapTimesLbl.translatesAutoresizingMaskIntoConstraints = false
        lapTimesLbl.backgroundColor = .clear
        lapTimesLbl.text = "Lap Times"
        lapTimesLbl.font = .systemFont(ofSize: 16, weight: .semibold)
        lapTimesLbl.textAlignment = .center
        
        contentView.addSubview(overallTimesLbl)
        overallTimesLbl.translatesAutoresizingMaskIntoConstraints = false
        overallTimesLbl.backgroundColor = .clear
        overallTimesLbl.text = "Overall Times"
        overallTimesLbl.font = .systemFont(ofSize: 16, weight: .semibold)
        overallTimesLbl.textAlignment = .center
        
        contentView.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = UIColor(red: 68/255, green: 68/255, blue: 89/255, alpha: 1)
        
        NSLayoutConstraint.activate([
            
            lapLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            lapLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            lapLbl.rightAnchor.constraint(equalTo: lapTimesLbl.leftAnchor, constant: -20),
            lapLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            lapTimesLbl.topAnchor.constraint(equalTo: lapLbl.topAnchor),
            lapTimesLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -10),
            lapTimesLbl.rightAnchor.constraint(equalTo: overallTimesLbl.leftAnchor, constant: -20),
            lapTimesLbl.bottomAnchor.constraint(equalTo: lapLbl.bottomAnchor),
            
            overallTimesLbl.topAnchor.constraint(equalTo: lapLbl.topAnchor),
            overallTimesLbl.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            overallTimesLbl.bottomAnchor.constraint(equalTo: lapLbl.bottomAnchor),
            
            lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lineView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            lineView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 3),
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
