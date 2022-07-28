//
//  RepeatViewController.swift
//  Date
//
//  Created by macbook on 4/14/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import UIKit

class RepeatViewController: UIViewController {
    
    let customView = NavigationView2()
    let tableView = UITableView()
    var model = Model()
    var defaults = UserDefaults.standard
    var weekdaysArr = [String]()
    var basic: BasicModel2?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weekdaysArr = defaults.array(forKey: "save days of the week") as? [String] ?? [String]()
        
        view.backgroundColor = UIColor(red: 48/255, green: 48/255, blue: 60/255, alpha: 1)
        
        view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = UIColor(red: 68/255, green: 68/255, blue: 90/255, alpha: 1)
        customView.leftBtn.addTarget(self, action: #selector(backClicked(_:)), for: .touchUpInside)
        customView.rightBtn.isHidden = true
        customView.leftBtn.setTitle("Back", for: .normal)
        customView.titleText.text = "Select day"
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RepeatCell.self, forCellReuseIdentifier: "RepeatCell")
        tableView.register(Header.self, forHeaderFooterViewReuseIdentifier: "Header")
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        
        NSLayoutConstraint.activate([
            
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leftAnchor.constraint(equalTo: view.leftAnchor),
            customView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            tableView.topAnchor.constraint(equalTo: customView.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            ])
    }
    @objc func backClicked(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    
}

extension RepeatViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as! Header
        headerView.label.text = "Weekdays"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.repeatArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepeatCell") as! RepeatCell
        cell.selectionStyle = .none
        
        cell.day.text = model.repeatArr[indexPath.row].day
        
        if model.repeatArr[indexPath.row].isCheck == true || weekdaysArr.contains(where: {$0 == model.repeatArr[indexPath.row].day}) == true{
            cell.checkMark.isHidden = false
            defaults.set(model.repeatArr[indexPath.row].day, forKey: "save days")

        } else {
            weekdaysArr = weekdaysArr.filter{$0 != model.repeatArr[indexPath.row].day ?? ""}
            defaults.set(weekdaysArr, forKey: "save days of the week")
            cell.checkMark.isHidden = true
        }
        
        
        if indexPath.row == 0 {
            cell.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
        }
        if indexPath.row == model.repeatArr.count-1 {
            cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       model.repeatArr[indexPath.row].isCheck = !(model.repeatArr[indexPath.row].isCheck ?? false)
        
        if weekdaysArr.contains(where: {$0 == model.repeatArr[indexPath.row].day}) == false {
            weekdaysArr.append(model.repeatArr[indexPath.row].day ?? "")
            defaults.set(weekdaysArr, forKey: "save days of the week")

        } else {
            weekdaysArr = weekdaysArr.filter{$0 != model.repeatArr[indexPath.row].day ?? ""}
            defaults.set(weekdaysArr, forKey: "save days of the week")
            model.repeatArr[indexPath.row].isCheck = false
        }
        

        tableView.reloadData()
    }
    
    
}
