//
//  NavigationView2.swift
//  Date
//
//  Created by macbook on 4/10/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import UIKit

class NavigationView2: UIView {
    
    let leftBtn = UIButton()
    let titleText = UILabel()
    let rightBtn = UIButton()
    let maskLbl = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(leftBtn)
        leftBtn.translatesAutoresizingMaskIntoConstraints = false
        leftBtn.setTitle("Cancel", for: .normal)
        leftBtn.setTitleColor(UIColor(red: 251/255, green: 178/255, blue: 41/255, alpha: 1), for: .normal)
        
        addSubview(titleText)
        titleText.translatesAutoresizingMaskIntoConstraints = false
        titleText.text = "Add Alarm"
        titleText.textColor = .white
        titleText.font = .systemFont(ofSize: 22, weight: .semibold)
        
        addSubview(rightBtn)
        rightBtn.translatesAutoresizingMaskIntoConstraints = false
        rightBtn.setTitle("Save", for: .normal)
        rightBtn.setTitleColor(UIColor(red: 251/255, green: 178/255, blue: 41/255, alpha: 1), for: .normal)
        
        addSubview(maskLbl)
        maskLbl.translatesAutoresizingMaskIntoConstraints = false
        maskLbl.text = "Save"
        maskLbl.textColor = UIColor(red: 251/255, green: 178/255, blue: 41/255, alpha: 0.3)
        maskLbl.backgroundColor = .clear
        maskLbl.isHidden = true
        
        NSLayoutConstraint.activate([
            
            leftBtn.centerYAnchor.constraint(equalTo: rightBtn.centerYAnchor),
            leftBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            leftBtn.heightAnchor.constraint(equalToConstant: 20),
            leftBtn.rightAnchor.constraint(lessThanOrEqualTo: titleText.leftAnchor, constant: -20),
            
            titleText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            titleText.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleText.centerYAnchor.constraint(equalTo: rightBtn.centerYAnchor),
            titleText.rightAnchor.constraint(lessThanOrEqualTo: rightBtn.leftAnchor, constant: -20),
            
            rightBtn.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            rightBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            rightBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            
            maskLbl.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            maskLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            maskLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            
            ])
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
