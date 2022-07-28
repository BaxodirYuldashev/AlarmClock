//
//  AlarmViewController.swift
//  Date
//
//  Created by macbook on 4/10/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {
    
   let customView = NavigationView2()
    let startTime = UIDatePicker()
    let showHourLbl = UILabel()
    let showMinutLbl = UILabel()
    let backView = UIView()
    let tableView = UITableView()
    var hour = ""
    var minut = ""
    var day = ""
    var month = ""
    var year = ""

    var defaults = UserDefaults.standard
    var model = Model()
    var weekdaysArr = [[String]]()
    
    var alarmArr = [BasicModel2]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor(red: 48/255, green: 48/255, blue: 60/255, alpha: 1)
        
        view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = UIColor(red: 68/255, green: 68/255, blue: 90/255, alpha: 1)
        customView.leftBtn.addTarget(self, action: #selector(backClicked(_:)), for: .touchUpInside)
        customView.rightBtn.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        if hour == "" {
            customView.maskLbl.isHidden = false
            customView.rightBtn.isHidden = true
        }
        
        view.addSubview(backView)
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.backgroundColor = UIColor(red: 108/255, green: 108/255, blue: 130/255, alpha: 1)
        backView.layer.cornerRadius = 10
        
        view.addSubview(startTime)
        startTime.translatesAutoresizingMaskIntoConstraints = false
        startTime.datePickerMode = UIDatePicker.Mode.time
        startTime.backgroundColor = .clear
        startTime.setValue(UIColor.white, forKey:"textColor")
        startTime.addTarget(self, action: #selector(startTimeDiveChanged(_ :)), for: .valueChanged)
        startTime.locale = Locale.init(identifier: "en_gb")
        let myDate = Calendar.current.date(bySettingHour: Int(hour) ?? 0, minute: Int(minut) ?? 0, second: 0, of: Date())
        if hour != "" {
            startTime.date = myDate ?? Date()
        }
        
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.register(BasicCell.self, forCellReuseIdentifier: "BasicCell")
        

        NSLayoutConstraint.activate([
            
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leftAnchor.constraint(equalTo: view.leftAnchor),
            customView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            startTime.topAnchor.constraint(equalTo: customView.bottomAnchor, constant: 30),
            startTime.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            startTime.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            startTime.heightAnchor.constraint(equalToConstant: 200),
        
            backView.centerYAnchor.constraint(equalTo: startTime.centerYAnchor),
            backView.centerXAnchor.constraint(equalTo: startTime.centerXAnchor),
            backView.heightAnchor.constraint(equalToConstant: 35),
            backView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            backView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
            tableView.topAnchor.constraint(equalTo: startTime.bottomAnchor, constant: 15),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            tableView.heightAnchor.constraint(equalToConstant: 220)
            
            ])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    @objc func startTimeDiveChanged(_ sender: UIDatePicker) {
        
        let hourFormatter = DateFormatter()
        hourFormatter.locale = Locale(identifier: "en-gb")
        hourFormatter.dateFormat = "HH"
        hour = hourFormatter.string(from: sender.date)

        let minutFormatter = DateFormatter()
        minutFormatter.locale = Locale(identifier: "en-gb")
        minutFormatter.dateFormat = "mm"
        minut = minutFormatter.string(from: sender.date)
        
        let currentHour = Calendar.current.component(.hour, from: Date())
        let currentMinut = Calendar.current.component(.minute, from: Date())
        let currentDay = Calendar.current.component(.day, from: Date())
        
        if Int(hour) ?? 0 < currentHour || Int(hour) ?? 0 == currentHour && Int(minut) ?? 0 < currentMinut || Int(hour) ?? 0 == currentHour && Int(minut) ?? 0 == currentMinut {
            day = String(currentDay + 1)
        } else {
            day = "\(currentDay)"
        }
        
        
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateStyle = .short
        monthFormatter.dateFormat = "MM"
        month = monthFormatter.string(from: sender.date)
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateStyle = .short
        yearFormatter.dateFormat = "yyyy"
        year = yearFormatter.string(from: sender.date)
        
        customView.rightBtn.isHidden = false
        customView.maskLbl.isHidden = true

    }
    

    @objc func backClicked(_ sender: UIButton){
        
        HomeViewController.isShow = false
        navigationController?.popViewController(animated: true)
    }
    
    @objc func btnClicked(_ sender: UIButton){
        defaults.set(hour, forKey: "save hour")
        defaults.set(minut, forKey: "save minut")
        defaults.set(day, forKey: "day")
        defaults.set(month, forKey: "month")
        defaults.set(year, forKey: "year")

        navigationController?.popViewController(animated: true)

    }
}

extension AlarmViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.optionsArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell") as! BasicCell

        if indexPath.row == 0 {
            cell.titleLabel.text = model.optionsArr[indexPath.row].title ?? ""
            
            if defaults.array(forKey: "save days of the week")?.count == 1 {
              cell.desc.text = defaults.string(forKey: "save days")
                }
            else if defaults.array(forKey: "save days of the week")?.count == 0 || defaults.array(forKey: "save days of the week")?.count == nil {
                cell.desc.text = "No selected day"
            }
             else {
                cell.desc.text = "Weekdays"
            }
        }
        
       if indexPath.row == 1 {
        cell.titleLabel.text = model.optionsArr[indexPath.row].title ?? ""
        
            cell.desc.text = defaults.string(forKey: "save note")
        cell.desc.numberOfLines = 0
        
        }
        

        if indexPath.row == 2 {
            cell.titleLabel.text = model.optionsArr[indexPath.row].title ?? ""
            cell.desc.text = defaults.string(forKey: "save musicName") ?? ""
        }
        
        
        if indexPath.row == 0 {
            cell.layer.cornerRadius = 12
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            cell.layer.masksToBounds = true
        }
        if indexPath.row == 3 {
            cell.layer.cornerRadius = 12
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            cell.layer.masksToBounds = true
        }
        
        if indexPath.row == 3 {
            cell.titleLabel.text = model.optionsArr[indexPath.row].title ?? ""
            cell.rightIcon.isHidden = true
            cell.mySwitch.isHidden = false
            cell.mySwitch.isOn = defaults.bool(forKey: "isRepeat")
        }
    
        cell.selectionStyle = .none
        cell.mySwitch.addTarget(self, action: #selector(snoozeChanged), for: .valueChanged)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = RepeatViewController()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 1 {
            let vc = LabelViewController()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 2 {
            let vc = SoundViewController()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func snoozeChanged(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: "isRepeat")
    }
}

