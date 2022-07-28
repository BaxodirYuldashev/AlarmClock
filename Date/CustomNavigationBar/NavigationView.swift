//
//  NavigationView.swift
//  Date
//
//  Created by macbook on 4/10/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import UIKit

class NavigationView: UIView {
    
    let plusBtn = UIButton()
    let editBtn = UIButton()
    let title = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(plusBtn)
        plusBtn.translatesAutoresizingMaskIntoConstraints = false
        plusBtn.setImage(UIImage(named: "plus")?.withRenderingMode(.alwaysTemplate), for: .normal)
        plusBtn.tintColor = UIColor(red: 250/255, green: 148/255, blue: 39/255, alpha: 1)
        
        addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Alarm Clock"
        title.backgroundColor = .clear
        title.textColor = .white
        title.font = .systemFont(ofSize: 22, weight: .semibold)
        
        addSubview(editBtn)
        editBtn.translatesAutoresizingMaskIntoConstraints = false
        editBtn.setImage(UIImage(named: "remove basket")?.withRenderingMode(.alwaysTemplate), for: .normal)
        editBtn.backgroundColor = .clear
        editBtn.tintColor = UIColor(red: 250/255, green: 148/255, blue: 39/255, alpha: 1)
        
        NSLayoutConstraint.activate([
            
            plusBtn.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            plusBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            plusBtn.heightAnchor.constraint(equalToConstant: 23),
            plusBtn.widthAnchor.constraint(equalTo: plusBtn.heightAnchor),
            plusBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            
            title.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            
            editBtn.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            editBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            editBtn.heightAnchor.constraint(equalToConstant: 23),
            editBtn.widthAnchor.constraint(equalTo: editBtn.heightAnchor),
            editBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),


            
            ])
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
