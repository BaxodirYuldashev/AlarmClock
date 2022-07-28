//
//  TimerViewController.swift
//  Date
//
//  Created by macbook on 6/5/22.
//  Copyright © 2022 macbook. All rights reserved.
//


import UIKit

class TimerViewController: UIViewController {
    
    let customView = NavigationView2()
    let picker = UIPickerView()
    let hourLbl = UILabel()
    let minutLbl = UILabel()
    let secondLbl = UILabel()
    let startBtn = UIButton(type: .system)
    let maskLbl = UILabel()
    
    var hour:Int = 0
    var minutes:Int = 0
    var seconds:Int = 0
    var timerModel = TimerModel(hour: 0, minut: 0, second: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)//UIColor(red: 58/255, green: 58/255, blue: 80/255, alpha: 1)
        
        view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = UIColor(red: 68/255, green: 68/255, blue: 90/255, alpha: 1)
        customView.leftBtn.isHidden = true
        customView.rightBtn.isHidden = true
        customView.titleText.text = "Timer"
        
        view.addSubview(hourLbl)
        hourLbl.translatesAutoresizingMaskIntoConstraints = false
        hourLbl.backgroundColor = .clear
        hourLbl.text = "Hours"
        hourLbl.font = .systemFont(ofSize: 24, weight: .semibold)
        hourLbl.textColor = .black
        hourLbl.textAlignment = .center
        
        view.addSubview(minutLbl)
        minutLbl.translatesAutoresizingMaskIntoConstraints = false
        minutLbl.backgroundColor = .clear
        minutLbl.text = "Minutes"
        minutLbl.font = .systemFont(ofSize: 24, weight: .semibold)
        minutLbl.textColor = .black
        minutLbl.textAlignment = .center
        
        view.addSubview(secondLbl)
        secondLbl.translatesAutoresizingMaskIntoConstraints = false
        secondLbl.backgroundColor = .clear
        secondLbl.text = "Seconds"
        secondLbl.font = .systemFont(ofSize: 24, weight: .semibold)
        secondLbl.textColor = .black
        secondLbl.textAlignment = .center
        
        view.addSubview(picker)
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = .clear
        picker.delegate = self
        picker.dataSource = self
        
        view.addSubview(startBtn)
        startBtn.translatesAutoresizingMaskIntoConstraints = false
        startBtn.backgroundColor = UIColor(red: 51/255, green: 86/255, blue: 181/255, alpha: 1)
        startBtn.setTitle("Start", for: .normal)
        startBtn.setTitleColor(.white, for: .normal)
        startBtn.layer.cornerRadius = 25
        startBtn.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        startBtn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        startBtn.isHidden = true
        
        view.addSubview(maskLbl)
        maskLbl.translatesAutoresizingMaskIntoConstraints = false
        maskLbl.backgroundColor = UIColor(red: 51/255, green: 86/255, blue: 181/255, alpha: 0.3)
        maskLbl.text = "Start"
        maskLbl.textColor = .white
        maskLbl.textAlignment = .center
        maskLbl.layer.cornerRadius = 25
        maskLbl.clipsToBounds = true
        maskLbl.font = .systemFont(ofSize: 20, weight: .medium)
        maskLbl.isHidden = false
    
        
        NSLayoutConstraint.activate([
            
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leftAnchor.constraint(equalTo: view.leftAnchor),
            customView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            hourLbl.topAnchor.constraint(equalTo: customView.bottomAnchor, constant: 30),
            hourLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 45),
            
            minutLbl.topAnchor.constraint(equalTo: hourLbl.topAnchor),
            minutLbl.leftAnchor.constraint(equalTo: hourLbl.rightAnchor, constant: 20),
            
            secondLbl.topAnchor.constraint(equalTo: hourLbl.topAnchor),
            secondLbl.leftAnchor.constraint(equalTo: minutLbl.rightAnchor, constant: 20),
            secondLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            
            picker.topAnchor.constraint(equalTo: hourLbl.bottomAnchor, constant: 20),
            picker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            picker.heightAnchor.constraint(equalToConstant: 100),
            
            startBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            startBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startBtn.heightAnchor.constraint(equalToConstant: 50),
            startBtn.widthAnchor.constraint(equalToConstant: 120),
            
            maskLbl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            maskLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            maskLbl.heightAnchor.constraint(equalToConstant: 50),
            maskLbl.widthAnchor.constraint(equalToConstant: 120),
            
            ])
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        HomeViewController.isShow = false
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    @objc func btnClicked (_ sender: UIButton) {
        let vc = TimerAnimationController()
        
        if hour < 10 {
            vc.hourLabel.text = "0\(hour)"
            timerModel.hour = hour
        } else {
            vc.hourLabel.text = "\(hour)"
            timerModel.hour = hour
        }
        
        if minutes < 10 {
            vc.minutLabel.text = "0\(minutes)"
            timerModel.minut = minutes
        } else {
            vc.minutLabel.text = "\(minutes)"
            timerModel.minut = minutes
        }
        
        if seconds < 10 {
            vc.secondLabel.text = "0\(seconds)"
            timerModel.second = seconds
        } else {
            vc.secondLabel.text = "\(seconds)"
            timerModel.second = seconds
        }
        vc.extraSecond = seconds
        vc.timerModel = timerModel
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension TimerViewController:UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 25
        case 1,2:
            return 60
            
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width/3.2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            if row < 10 {
                return "0\(row)"
            }
            return "\(row)"
        case 1:
            if row < 10 {
                return "0\(row)"
            }
            return "\(row)"
        case 2:
            if row < 10 {
                return "0\(row)"
            }
            return "\(row)"
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hour = row
        case 1:
            minutes = row
        case 2:
            seconds = row
        default:
            break;
        }
        if hour == 0 && minutes == 0 && seconds == 0 {
            maskLbl.isHidden = false
            startBtn.isHidden = true
        } else {
            maskLbl.isHidden = true
            startBtn.isHidden = false
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    

}
