//
//  HeaderViewAppearance.swift
//  Date
//
//  Created by macbook on 5/22/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import UIKit

class HeaderViewAppearance: UITableViewHeaderFooterView {
    
    let alarmTextLbl = UILabel()
    let timeLeftLabel = UILabel()
    var resultHour = 0
    var resultMinute = 0
    var resultSecond = 0
    var hour = ""
    var minut = ""
    var sekund = "60"
    var timer = Timer()
    var defaults = UserDefaults.standard
    var isEnd = false
    var appModel: AppearancePage?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(alarmTextLbl)
        alarmTextLbl.translatesAutoresizingMaskIntoConstraints = false
        alarmTextLbl.textColor = .brown
        alarmTextLbl.font = .systemFont(ofSize: 24, weight: .semibold)
//        alarmTextLbl.text = appModel?.alarmCheck
        
        contentView.addSubview(timeLeftLabel)
        timeLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLeftLabel.textColor = .brown
        timeLeftLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        timeLeftLabel.textAlignment = .right
//        timeLeftLabel.text = appModel?.timer
        
        NSLayoutConstraint.activate([
            
            alarmTextLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            alarmTextLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            alarmTextLbl.rightAnchor.constraint(equalTo: timeLeftLabel.leftAnchor, constant: -20),
            alarmTextLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            timeLeftLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            timeLeftLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            timeLeftLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),

            ])
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showTime() {
        let date = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: date)
        let currentMinut = calendar.component(.minute, from: date)
        let currentSekund = calendar.component(.second, from: date)
        
        if appModel?.hour != "" || appModel?.hour != nil {
            if (Int(appModel?.hour ?? "") ?? 0) < currentHour && (Int(appModel?.minut ?? "") ?? 0) < currentMinut {
                resultHour += 24
                resultMinute += 60
                resultHour = resultHour - abs((Int(appModel?.hour ?? "") ?? 0) - currentHour)
                resultMinute = resultMinute - abs((Int(appModel?.minut ?? "") ?? 0) - currentMinut)
                resultSecond = abs((Int(sekund) ?? 0) - currentSekund)
                
            }
            if (Int(appModel?.hour ?? "") ?? 0) > currentHour && (Int(appModel?.minut ?? "") ?? 0) > currentMinut || (Int(appModel?.hour ?? "") ?? 0) == currentHour && (Int(appModel?.minut ?? "") ?? 0) > currentMinut {
                resultHour = abs((Int(appModel?.hour ?? "") ?? 0) - currentHour)
                resultMinute = abs((Int(appModel?.minut ?? "") ?? 0) - currentMinut-1)
                resultSecond = abs((Int(sekund) ?? 0) - currentSekund)
            }
            if (Int(appModel?.hour ?? "") ?? 0) == currentHour && (Int(appModel?.minut ?? "") ?? 0) == currentMinut {
                resultHour += 24
                resultHour = resultHour - abs((Int(appModel?.hour ?? "") ?? 0) - currentHour)
                resultSecond = abs((Int(sekund) ?? 0) - currentSekund)
            }
            if (Int(appModel?.hour ?? "") ?? 0) < currentHour && (Int(appModel?.minut ?? "") ?? 0) > currentMinut {
                resultHour += 24
                resultHour = resultHour - (abs((Int(appModel?.hour ?? "") ?? 0) - currentHour))
                resultMinute = abs((Int(appModel?.minut ?? "") ?? 0) - currentMinut-1)
                resultSecond = abs((Int(sekund) ?? 0) - currentSekund)
                
            }
            if (Int(appModel?.hour ?? "") ?? 0) > currentHour && (Int(appModel?.minut ?? "") ?? 0) < currentMinut {
                resultMinute += 60
                resultHour = abs((Int(appModel?.hour ?? "") ?? 0) - currentHour-1)
                resultMinute = resultMinute - (abs((Int(appModel?.minut ?? "") ?? 0) - currentMinut-1))
                resultSecond = abs((Int(sekund) ?? 0) - currentSekund)
            }
            if (Int(appModel?.hour ?? "") ?? 0) > currentHour && (Int(appModel?.minut ?? "") ?? 0) == currentMinut {
                resultHour = abs((Int(appModel?.hour ?? "") ?? 0) - currentHour)
                resultMinute = abs((Int(appModel?.minut ?? "") ?? 0) - currentMinut)
                resultSecond = abs((Int(sekund) ?? 0) - currentSekund)
            }
            if (Int(appModel?.hour ?? "") ?? 0) < currentHour && (Int(appModel?.minut ?? "") ?? 0) == currentMinut {
                resultHour += 24
                resultHour = resultHour - abs((Int(appModel?.hour ?? "") ?? 0) - currentHour)
                resultMinute = abs((Int(appModel?.minut ?? "") ?? 0) - currentMinut)
                resultSecond = abs((Int(sekund) ?? 0) - currentSekund)
            }
            if (Int(appModel?.hour ?? "") ?? 0) == currentHour && (Int(appModel?.minut ?? "") ?? 0) < currentMinut {
                resultHour += 23
                resultMinute += 60
                resultHour = resultHour - abs((Int(appModel?.hour ?? "") ?? 0) - currentHour)
                resultMinute = resultMinute - abs((Int(appModel?.minut ?? "") ?? 0) - currentMinut)
                resultSecond = abs((Int(sekund) ?? 0) - currentSekund)
            }
            
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
        
        startTimer()

}
    @objc func startTimer() {
        if appModel?.isOn == true {
            if isEnd == false {
                
                if resultSecond <= 0 {
                    resultMinute -= 1
                    resultSecond = 60
                    
                    if resultMinute < 0 {
                        resultHour -= 1
                        resultMinute = 59
                    }
                    
                    resultSecond = 60
                }
                resultSecond -= 1
                timeLeftLabel.text = (String(format:"- %02i:%02i:%02i", resultHour, resultMinute, resultSecond))
                timeLeftLabel.isHidden = false
                alarmTextLbl.text = "Alarm will ring in:"
                //                defaults.set(mySwitch.isOn, forKey: "save switch2")
            }
        } else {
            if resultSecond <= 0 {
                resultMinute -= 1
                resultSecond = 60
                
                if resultMinute < 0 {
                    resultHour -= 1
                    resultMinute = 59
                }
                
                resultSecond = 60
            }
            resultSecond -= 1
            timeLeftLabel.text = (String(format:"- %02i:%02i:%02i", resultHour, resultMinute, resultSecond))
            
            timeLeftLabel.isHidden = true
            alarmTextLbl.text = "Alarm clock off"
//            defaults.set(mySwitch.isOn, forKey: "save switch2")
        }
        if resultHour == 0 && resultMinute == 0 && resultSecond == 0 && appModel?.isOn == true {
            timeLeftLabel.text = (String(format:"- %02i:%02i:%02i", resultHour, resultMinute, resultSecond))
            isEnd = true
            appModel?.isOn = false
            alarmTextLbl.text = "Alarm clock off"
//            playSound()
//            laterView.isHidden = false
//            cancelView.isHidden = false
        }
    }
}
