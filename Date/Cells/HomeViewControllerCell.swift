//
//  SoundCell.swift
//  Date
//
//  Created by macbook on 5/1/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import UIKit

class SoundCell: UITableViewCell {
   
    let showHourLbl = UILabel()
    let showMinutLbl = UILabel()
    let colonLbl = UILabel()
    let mySwitch = UISwitch()
    
    var hour = ""
    var minut = ""
    var sekund = "60"
   
override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(showHourLbl)
    showHourLbl.translatesAutoresizingMaskIntoConstraints = false
    showHourLbl.backgroundColor = .green//UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
    showHourLbl.textColor = .black
    showHourLbl.font = .systemFont(ofSize: 35, weight: .bold)
//    showHourLbl.text = hour
    
    contentView.addSubview(showMinutLbl)
    showMinutLbl.translatesAutoresizingMaskIntoConstraints = false
   showMinutLbl.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
    showMinutLbl.textColor = .black
    showMinutLbl.font = .systemFont(ofSize: 35, weight: .bold)
//    showMinutLbl.text = minut

    contentView.addSubview(colonLbl)
    colonLbl.translatesAutoresizingMaskIntoConstraints = false
    colonLbl.text = ":"
    colonLbl.textColor = .black
    colonLbl.font = .systemFont(ofSize: 35, weight: .bold)
    colonLbl.isHidden = true
    colonLbl.textAlignment = .center
    
    contentView.addSubview(mySwitch)
    mySwitch.translatesAutoresizingMaskIntoConstraints = false

//    if showHourLbl.text == "" {
//        mySwitch.isHidden = true
//    } else {
//        mySwitch.isHidden = false
//        mySwitch.isOn = true
//        colonLbl.isHidden = false
////        timeLeftLabel.isHidden = false
//    }

    NSLayoutConstraint.activate([
        
        showHourLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
        showHourLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25),
        showHourLbl.heightAnchor.constraint(equalToConstant: 50),
        showHourLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
        
        colonLbl.centerYAnchor.constraint(equalTo: showHourLbl.centerYAnchor),
        colonLbl.leftAnchor.constraint(equalTo: showHourLbl.rightAnchor, constant: 3),

        showMinutLbl.topAnchor.constraint(equalTo: showHourLbl.topAnchor),
        showMinutLbl.leftAnchor.constraint(equalTo: colonLbl.rightAnchor, constant: 3),
        showMinutLbl.heightAnchor.constraint(equalToConstant: 50),

        mySwitch.centerYAnchor.constraint(equalTo: showHourLbl.centerYAnchor),
        mySwitch.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),


        ])
}

required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
}

