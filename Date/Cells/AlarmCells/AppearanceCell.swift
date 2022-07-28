//
//  AppearanceCell.swift
//  Date
//
//  Created by macbook on 5/22/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import UIKit

class AppearanceCell: UITableViewCell  {
    
    let showHourLbl = UILabel()
    let colonLbl = UILabel()
    let showMinutLbl = UILabel()
    let showDayLbl = UILabel()
    let showMonthLbl = UILabel()
    let showYearLbl = UILabel()
    let mySwitch = UISwitch()
    let defaults = UserDefaults.standard
    var noteLabel = UILabel()
    let weekdaysView = UIView()
    let mondayLbl = UILabel()
    let tuesLbl = UILabel()
    let wedLbl = UILabel()
    let thursLbl = UILabel()
    let friLbl = UILabel()
    let satLbl = UILabel()
    let sunLbl = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)//UIColor(red: 108/255, green: 108/255, blue: 129/255, alpha: 1)
        
        contentView.addSubview(showHourLbl)
        showHourLbl.translatesAutoresizingMaskIntoConstraints = false
        showHourLbl.backgroundColor = .clear
        showHourLbl.textColor = .white
        showHourLbl.font = .systemFont(ofSize: 35, weight: .bold)
        
        contentView.addSubview(colonLbl)
        colonLbl.translatesAutoresizingMaskIntoConstraints = false
        colonLbl.backgroundColor = .clear
        colonLbl.textColor = .white
        colonLbl.font = .systemFont(ofSize: 35, weight: .bold)
        
        contentView.addSubview(showMinutLbl)
        showMinutLbl.translatesAutoresizingMaskIntoConstraints = false
        showMinutLbl.backgroundColor = .clear
        showMinutLbl.textColor = .white
        showMinutLbl.font = .systemFont(ofSize: 35, weight: .bold)
        
        contentView.addSubview(showDayLbl)
        showDayLbl.translatesAutoresizingMaskIntoConstraints = false
        showDayLbl.backgroundColor = .clear
        showDayLbl.textColor = .white
        showDayLbl.font = .systemFont(ofSize: 16, weight: .bold)
        
        contentView.addSubview(showMonthLbl)
        showMonthLbl.translatesAutoresizingMaskIntoConstraints = false
        showMonthLbl.backgroundColor = .clear
        showMonthLbl.textColor = .white
        showMonthLbl.font = .systemFont(ofSize: 16, weight: .bold)
        
        contentView.addSubview(showYearLbl)
        showYearLbl.translatesAutoresizingMaskIntoConstraints = false
        showYearLbl.backgroundColor = .clear
        showYearLbl.textColor = .white
        showYearLbl.font = .systemFont(ofSize: 16, weight: .bold)
        
        contentView.addSubview(noteLabel)
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        noteLabel.backgroundColor = .clear
        noteLabel.textColor = .white
        noteLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        noteLabel.numberOfLines = 0
        
        contentView.addSubview(mySwitch)
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
//        mySwitch.isHidden = true
        
        contentView.addSubview(weekdaysView)
        weekdaysView.translatesAutoresizingMaskIntoConstraints = false
        weekdaysView.backgroundColor = .clear
        
        weekdaysView.addSubview(mondayLbl)
        mondayLbl.translatesAutoresizingMaskIntoConstraints = false
        mondayLbl.textColor = .gray
        mondayLbl.font = .systemFont(ofSize: 14, weight: .semibold)
        mondayLbl.text = "Mon"
        
        weekdaysView.addSubview(tuesLbl)
        tuesLbl.translatesAutoresizingMaskIntoConstraints = false
        tuesLbl.textColor = .gray
        tuesLbl.font = .systemFont(ofSize: 14, weight: .semibold)
        tuesLbl.text = "Tue"
        
        weekdaysView.addSubview(wedLbl)
        wedLbl.translatesAutoresizingMaskIntoConstraints = false
        wedLbl.textColor = .gray
        wedLbl.font = .systemFont(ofSize: 14, weight: .semibold)
        wedLbl.text = "Wed"
        
        weekdaysView.addSubview(thursLbl)
        thursLbl.translatesAutoresizingMaskIntoConstraints = false
        thursLbl.textColor = .gray
        thursLbl.font = .systemFont(ofSize: 14, weight: .semibold)
        thursLbl.text = "Thu"
        
        weekdaysView.addSubview(friLbl)
        friLbl.translatesAutoresizingMaskIntoConstraints = false
        friLbl.textColor = .gray
        friLbl.font = .systemFont(ofSize: 14, weight: .semibold)
        friLbl.text = "Fri"
        
        weekdaysView.addSubview(satLbl)
        satLbl.translatesAutoresizingMaskIntoConstraints = false
        satLbl.textColor = .gray
        satLbl.font = .systemFont(ofSize: 14, weight: .semibold)
        satLbl.text = "Sat"
        
        weekdaysView.addSubview(sunLbl)
        sunLbl.translatesAutoresizingMaskIntoConstraints = false
        sunLbl.textColor = .gray
        sunLbl.font = .systemFont(ofSize: 14, weight: .semibold)
        sunLbl.text = "Sun"
        
        
        NSLayoutConstraint.activate([
            
        showHourLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
        showHourLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
        showHourLbl.rightAnchor.constraint(equalTo: colonLbl.leftAnchor, constant: -5),
        
        colonLbl.centerYAnchor.constraint(equalTo: showHourLbl.centerYAnchor),
        colonLbl.leftAnchor.constraint(equalTo: showHourLbl.rightAnchor, constant: 5),
        colonLbl.rightAnchor.constraint(equalTo: showMinutLbl.leftAnchor, constant: -5),
        
        showMinutLbl.topAnchor.constraint(equalTo: showHourLbl.topAnchor),
        showMinutLbl.leftAnchor.constraint(equalTo: colonLbl.rightAnchor, constant: 5),
         showMinutLbl.bottomAnchor.constraint(equalTo: showHourLbl.bottomAnchor),
         
         showDayLbl.leftAnchor.constraint(equalTo: showMinutLbl.rightAnchor, constant: 50),
         showDayLbl.centerYAnchor.constraint(equalTo: showHourLbl.centerYAnchor, constant: 5),
         
         showMonthLbl.topAnchor.constraint(equalTo: showDayLbl.topAnchor),
         showMonthLbl.leftAnchor.constraint(equalTo: showDayLbl.rightAnchor, constant: 5),
         
         showYearLbl.topAnchor.constraint(equalTo: showDayLbl.topAnchor),
         showYearLbl.leftAnchor.constraint(equalTo: showMonthLbl.rightAnchor, constant: 5),
         showYearLbl.rightAnchor.constraint(lessThanOrEqualTo: mySwitch.leftAnchor, constant: -10),
         
        mySwitch.topAnchor.constraint(equalTo: showHourLbl.topAnchor, constant: 5),
        mySwitch.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
        mySwitch.bottomAnchor.constraint(equalTo: showHourLbl.bottomAnchor),
        
        weekdaysView.topAnchor.constraint(equalTo: mySwitch.bottomAnchor, constant: 10),
        weekdaysView.leftAnchor.constraint(equalTo: showDayLbl.leftAnchor),
        weekdaysView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
        weekdaysView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        
        mondayLbl.topAnchor.constraint(equalTo: weekdaysView.topAnchor, constant: 10),
        mondayLbl.leftAnchor.constraint(equalTo: weekdaysView.leftAnchor),
        mondayLbl.bottomAnchor.constraint(equalTo: weekdaysView.bottomAnchor, constant: -10),
        
        tuesLbl.topAnchor.constraint(equalTo: mondayLbl.topAnchor),
        tuesLbl.leftAnchor.constraint(equalTo: mondayLbl.rightAnchor, constant: 5),
        tuesLbl.bottomAnchor.constraint(equalTo: mondayLbl.bottomAnchor),
        
        wedLbl.topAnchor.constraint(equalTo: mondayLbl.topAnchor),
        wedLbl.leftAnchor.constraint(equalTo: tuesLbl.rightAnchor, constant: 5),
        wedLbl.bottomAnchor.constraint(equalTo: mondayLbl.bottomAnchor),
        
        thursLbl.topAnchor.constraint(equalTo: mondayLbl.topAnchor),
        thursLbl.leftAnchor.constraint(equalTo: wedLbl.rightAnchor, constant: 5),
        thursLbl.bottomAnchor.constraint(equalTo: mondayLbl.bottomAnchor),
        
        friLbl.topAnchor.constraint(equalTo: mondayLbl.topAnchor),
        friLbl.leftAnchor.constraint(equalTo: thursLbl.rightAnchor, constant: 5),
        friLbl.bottomAnchor.constraint(equalTo: mondayLbl.bottomAnchor),
        
        satLbl.topAnchor.constraint(equalTo: mondayLbl.topAnchor),
        satLbl.leftAnchor.constraint(equalTo: friLbl.rightAnchor, constant: 5),
        satLbl.bottomAnchor.constraint(equalTo: mondayLbl.bottomAnchor),
        
        sunLbl.topAnchor.constraint(equalTo: mondayLbl.topAnchor),
        sunLbl.leftAnchor.constraint(equalTo: satLbl.rightAnchor, constant: 5),
        sunLbl.rightAnchor.constraint(lessThanOrEqualTo: weekdaysView.rightAnchor),
        sunLbl.bottomAnchor.constraint(equalTo: weekdaysView.bottomAnchor, constant: -10),
        
        noteLabel.topAnchor.constraint(equalTo: weekdaysView.topAnchor),
        noteLabel.leftAnchor.constraint(equalTo: showHourLbl.leftAnchor),
        noteLabel.rightAnchor.constraint(lessThanOrEqualTo: weekdaysView.leftAnchor, constant: -20),
        noteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            ])
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
}
