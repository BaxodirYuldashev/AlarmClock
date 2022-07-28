//
//  HomeViewController.swift
//  Date
//
//  Created by macbook on 4/3/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import UIKit

import AVFoundation

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let customView = NavigationView()
    let topBackView = UIView()
    var showHourLbl = UILabel()
    var showMinutLbl = UILabel()
    var colonLbl = UILabel()
    let alarmTextLbl = UILabel()
    let timeLeftLabel = UILabel()
    

    let tableView = UITableView()
    var defaults = UserDefaults.standard
    
    
    var alarmArr = [BasicModel2](){
        didSet{
            tableView.reloadData()
        }
    }
    var firstOnAlarm: BasicModel2?
    
    var weekArr = [String]()
    
    var hour = ""
    var minut = ""
    var sekund = "60"
    var day = ""
    var month = ""
    var year = ""
    var note = ""
    var music = ""
    var musicName = ""
    var isOn = Bool()
    var weekdaysArr = [String]()
    var timer = Timer()
    var resultHour = 0
    var resultMinute = 0
    var resultSecond = 0
    var isEnd = false
    var index = Int()
    static var isShow = false
    var isEdit = false
    var isRepeat = false
    
    let backgroundImage = UIImageView()
    let hourLabel = UILabel()
    let noteLabel = UILabel()
    let snoozeBtn = UIButton(type: .system)
    let dismissView = UIView()
    let subDismissLabel = UILabel()
    
 var player: AVAudioPlayer?
    
    

    func playSound() {
        let path = Bundle.main.path(forResource: alarmArr[0].music, ofType: nil)
        let url = URL(fileURLWithPath: path ?? "")

        do {
            player = try? AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("couldn't load the file")
        }
    }
    
    func stopSound() {

        player?.stop()
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        
        view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = UIColor(red: 68/255, green: 68/255, blue: 90/255, alpha: 1)
        customView.plusBtn.addTarget(self, action: #selector(btnClicked(_ :)), for: .touchUpInside)
        customView.editBtn.isHidden = true
        
        view.addSubview(topBackView)
        topBackView.translatesAutoresizingMaskIntoConstraints = false
        topBackView.backgroundColor = UIColor(red: 108/255, green: 108/255, blue: 130/255, alpha: 1)
        
        topBackView.addSubview(alarmTextLbl)
        alarmTextLbl.translatesAutoresizingMaskIntoConstraints = false
        alarmTextLbl.text = "Alarm clock off"
        alarmTextLbl.textColor = .black
        alarmTextLbl.font = .systemFont(ofSize: 24, weight: .semibold)

        topBackView.addSubview(timeLeftLabel)
        timeLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLeftLabel.textColor = .white
        timeLeftLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AppearanceCell.self, forCellReuseIdentifier: "AppearanceCell")
        
        view.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.image = UIImage(named: "cosmos2")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.isHidden = true
        
        backgroundImage.addSubview(hourLabel)
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        hourLabel.backgroundColor = .clear
        hourLabel.textColor = .white
        hourLabel.textAlignment = .center
        hourLabel.font = .systemFont(ofSize: 55, weight: .semibold)
        
        backgroundImage.addSubview(noteLabel)
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        noteLabel.backgroundColor = .clear
        noteLabel.textColor = .white
        noteLabel.textAlignment = .center
        noteLabel.font = .systemFont(ofSize: 35, weight: .semibold)
        
        backgroundImage.addSubview(snoozeBtn)
        snoozeBtn.translatesAutoresizingMaskIntoConstraints = false
        snoozeBtn.setTitle("Snooze", for: .normal)
        snoozeBtn.backgroundColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
        snoozeBtn.layer.borderWidth = 1
        snoozeBtn.layer.borderColor = UIColor.white.cgColor
        snoozeBtn.setTitleColor(.white, for: .normal)
        snoozeBtn.layer.cornerRadius = 12
        snoozeBtn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        snoozeBtn.addTarget(self, action: #selector(snoozing), for: .touchUpInside)
        
        backgroundImage.addSubview(dismissView)
        dismissView.translatesAutoresizingMaskIntoConstraints = false
        dismissView.backgroundColor = .clear
        
        backgroundImage.addSubview(subDismissLabel)
        subDismissLabel.translatesAutoresizingMaskIntoConstraints = false
        subDismissLabel.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        subDismissLabel.layer.cornerRadius = 45
        subDismissLabel.clipsToBounds = true
        subDismissLabel.text = "Dismiss"
        subDismissLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        subDismissLabel.textAlignment = .center
        subDismissLabel.textColor = .white
        subDismissLabel.layer.borderColor = UIColor(red: 90/255, green: 74/255, blue: 188/255, alpha: 1).cgColor
        subDismissLabel.layer.borderWidth = 3
        
        subDismissLabel.isUserInteractionEnabled = false
        backgroundImage.isUserInteractionEnabled = true
        backgroundImage.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dismissPanGesture)))
        

        NSLayoutConstraint.activate([
            
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leftAnchor.constraint(equalTo: view.leftAnchor),
            customView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            topBackView.topAnchor.constraint(equalTo: customView.bottomAnchor),
            topBackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topBackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            alarmTextLbl.topAnchor.constraint(equalTo: topBackView.topAnchor, constant: 10),
            alarmTextLbl.leftAnchor.constraint(equalTo: topBackView.leftAnchor, constant: 20),
            alarmTextLbl.rightAnchor.constraint(lessThanOrEqualTo: timeLeftLabel.leftAnchor, constant: -20),
            alarmTextLbl.bottomAnchor.constraint(equalTo: topBackView.bottomAnchor, constant: -20),
            
            timeLeftLabel.topAnchor.constraint(equalTo: alarmTextLbl.topAnchor),
            timeLeftLabel.rightAnchor.constraint(equalTo: topBackView.rightAnchor, constant: -10),
            timeLeftLabel.bottomAnchor.constraint(equalTo: alarmTextLbl.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: topBackView.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            hourLabel.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 100),
            hourLabel.leftAnchor.constraint(equalTo: backgroundImage.leftAnchor, constant: 30),
            hourLabel.rightAnchor.constraint(equalTo: backgroundImage.rightAnchor, constant: -30),
            
            noteLabel.topAnchor.constraint(equalTo: hourLabel.bottomAnchor, constant: 20),
            noteLabel.centerXAnchor.constraint(equalTo: hourLabel.centerXAnchor),
            
            snoozeBtn.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 230),
            snoozeBtn.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            snoozeBtn.widthAnchor.constraint(equalToConstant: 100),
            snoozeBtn.heightAnchor.constraint(equalToConstant: 50),
            
            dismissView.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 350),
            dismissView.leftAnchor.constraint(equalTo: backgroundImage.leftAnchor, constant: -10),
            dismissView.rightAnchor.constraint(equalTo: backgroundImage.rightAnchor, constant: 10),
            dismissView.heightAnchor.constraint(equalToConstant: 100),
            
            subDismissLabel.topAnchor.constraint(equalTo: dismissView.topAnchor, constant: 5),
            subDismissLabel.centerXAnchor.constraint(equalTo: dismissView.centerXAnchor),
            subDismissLabel.bottomAnchor.constraint(equalTo: dismissView.bottomAnchor, constant: -5),
            subDismissLabel.widthAnchor.constraint(equalTo: subDismissLabel.heightAnchor),
            
            ])

    }
    
  

    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(true, animated: true)
        if HomeViewController.isShow == true {
            if isEdit == true {
                alarmArr[index] = BasicModel2(hour: defaults.string(forKey: "save hour") ?? "",
                                            minut: defaults.string(forKey: "save minut") ?? "",
                                            day: defaults.string(forKey: "day") ?? "",
                                            month: defaults.string(forKey: "month") ?? "",
                                            year: defaults.string(forKey: "year") ?? "",
                                            isOn: true,
                                            note: defaults.string(forKey: "save note") ?? "",
                                            weekdays: (defaults.array(forKey: "save days of the week") as? [String]) ?? [String](),
                                            music: defaults.string(forKey: "save musicPlayer") ?? "",
                                            musicName: defaults.string(forKey: "save musicName") ?? "",
                                            isRepeat: defaults.bool(forKey: "isRepeat"))
                isEdit = false
            } else {
                alarmArr.append(BasicModel2(hour: defaults.string(forKey: "save hour") ?? "",
                                            minut: defaults.string(forKey: "save minut") ?? "",
                                            day: defaults.string(forKey: "day") ?? "",
                                            month: defaults.string(forKey: "month") ?? "",
                                            year: defaults.string(forKey: "year") ?? "",
                                            isOn: true,
                                            note: defaults.string(forKey: "save note") ?? "",
                                            weekdays: (defaults.array(forKey: "save days of the week") as? [String]) ?? [String](),
                                            music: defaults.string(forKey: "save musicPlayer") ?? "",
                                            musicName: defaults.string(forKey: "save musicName") ?? "",
                                            isRepeat: defaults.bool(forKey: "isRepeat")))
            }
            
            
            timer.invalidate()
            resultHour = 0
            resultMinute = 0
            resultSecond = 0
            
            alarmArr = alarmArr.sorted(by: { (b1, b2) in
                
                (b1.day ?? "", b1.hour ?? "", b1.minut ?? "") < (b2.day ?? "", b2.hour ?? "", b2.minut ?? "")
                
                
                
            })
            
            showTime()
        }
        
        HomeViewController.isShow = true
        

    }

    
    @objc func btnClicked(_ sender: UIButton){
        let vc = AlarmViewController()
        defaults.set(note, forKey: "save note")
        defaults.set(weekdaysArr, forKey: "save days of the week")
        defaults.set(isRepeat,forKey: "isRepeat")
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        
    }


    func showTime() {
    let date = Date()
    let calendar = Calendar.current
    let currentHour = calendar.component(.hour, from: date)
    let currentMinut = calendar.component(.minute, from: date)
    let currentSekund = calendar.component(.second, from: date)
    
        if alarmArr.count == 0 {
    return
    } else
    
    {
        firstOnAlarm = alarmArr[0]
        for item in alarmArr{
            if item.isOn == true {
                firstOnAlarm = item
                break
            }
        }
        
        if Int(firstOnAlarm?.hour ?? "") ?? 0 < currentHour && Int(firstOnAlarm?.minut ?? "") ?? 0 < currentMinut {
            resultHour += 24
            resultMinute += 60
            resultHour = resultHour - abs((Int(firstOnAlarm?.hour ?? "") ?? 0) - currentHour)
            resultMinute = resultMinute - abs((Int(firstOnAlarm?.minut ?? "") ?? 0) - currentMinut)
            resultSecond = abs((Int(sekund) ?? 0) - currentSekund)
    
    }
    if (Int(firstOnAlarm?.hour ?? "") ?? 0) > currentHour && (Int(firstOnAlarm?.minut ?? "") ?? 0) > currentMinut || (Int(firstOnAlarm?.hour ?? "") ?? 0) == currentHour && (Int(firstOnAlarm?.minut ?? "") ?? 0) > currentMinut {
        resultHour = abs((Int(firstOnAlarm?.hour ?? "") ?? 0) - currentHour)
        resultMinute = abs((Int(firstOnAlarm?.minut ?? "") ?? 0) - currentMinut-1)
        resultSecond = abs((Int(sekund) ?? 0) - currentSekund)
    }
    if (Int(firstOnAlarm?.hour ?? "") ?? 0) == currentHour && (Int(firstOnAlarm?.minut ?? "") ?? 0) == currentMinut {
        resultHour += 24
        resultHour = resultHour - abs((Int(firstOnAlarm?.hour ?? "") ?? 0) - currentHour)
        resultSecond = abs((Int(sekund) ?? 0) - currentSekund)
    }
    if (Int(firstOnAlarm?.hour ?? "") ?? 0) < currentHour && (Int(firstOnAlarm?.minut ?? "") ?? 0) > currentMinut {
        resultHour += 24
        resultHour = resultHour - (abs((Int(firstOnAlarm?.hour ?? "") ?? 0) - currentHour))
        resultMinute = abs((Int(firstOnAlarm?.minut ?? "") ?? 0) - currentMinut-1)
        resultSecond = abs((Int(sekund) ?? 0) - currentSekund)
    
    }
    if (Int(firstOnAlarm?.hour ?? "") ?? 0) > currentHour && (Int(firstOnAlarm?.minut ?? "") ?? 0) < currentMinut {
       resultMinute += 60
       resultHour = abs((Int(firstOnAlarm?.hour ?? "") ?? 0) - currentHour-1)
        resultMinute = resultMinute - (abs((Int(firstOnAlarm?.minut ?? "") ?? 0) - currentMinut-1))
        resultSecond = abs((Int(sekund) ?? 0) - currentSekund)
    }
    if (Int(firstOnAlarm?.hour ?? "") ?? 0) > currentHour && (Int(firstOnAlarm?.minut ?? "") ?? 0) == currentMinut {
        resultMinute += 59
        resultHour = abs((Int(firstOnAlarm?.hour ?? "") ?? 0) - currentHour-1)
        resultMinute = resultMinute - abs((Int(firstOnAlarm?.minut ?? "") ?? 0) - currentMinut)
        resultSecond = abs((Int(sekund) ?? 0) - currentSekund)
    }
    if (Int(firstOnAlarm?.hour ?? "") ?? 0) < currentHour && (Int(firstOnAlarm?.minut ?? "") ?? 0) == currentMinut {
        resultHour += 24
        resultHour = resultHour - abs((Int(firstOnAlarm?.hour ?? "") ?? 0) - currentHour)
        resultMinute = abs((Int(firstOnAlarm?.minut ?? "") ?? 0) - currentMinut)
        resultSecond = abs((Int(sekund) ?? 0) - currentSekund)
    }
    if (Int(firstOnAlarm?.hour ?? "") ?? 0) == currentHour && (Int(firstOnAlarm?.minut ?? "") ?? 0) < currentMinut {
        resultHour += 23
        resultMinute += 60
        resultHour = resultHour - abs((Int(firstOnAlarm?.hour ?? "") ?? 0) - currentHour)
        resultMinute = resultMinute - abs((Int(firstOnAlarm?.minut ?? "") ?? 0) - currentMinut)
        resultSecond = abs((Int(sekund) ?? 0) - currentSekund)
    }
    
    }
    
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
    
    startTimer()
    
}
@objc func startTimer() {
    if firstOnAlarm?.isOn == true {
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
    }
    if resultHour == 0 && resultMinute == 0 && resultSecond <= 10 {
        timeLeftLabel.textColor = .red
    } else {
        timeLeftLabel.textColor = .white
    }
    
    if resultHour == 0 && resultMinute == 0 && resultSecond == 0 && firstOnAlarm?.isOn == true {
        timeLeftLabel.text = (String(format:"- %02i:%02i:%02i", resultHour, resultMinute, resultSecond))
        
        isEnd = true
        alarmArr[0].isOn = false
        timer.invalidate()

        hourLabel.text = "\(alarmArr[0].hour ?? "")" + ":" + "\(alarmArr[0].minut ?? "")"
        noteLabel.text = alarmArr[0].note ?? ""
        

        alarmTextLbl.text = "Alarm clock off"
        playSound()
        
        isEnd = false
        timeLeftLabel.isHidden = true
        showTime()
        
        if alarmArr[0].isRepeat == true {
           backgroundImage.isHidden = false
           snoozeBtn.isHidden = false

   
        }
        else{
        backgroundImage.isHidden = false
        snoozeBtn.isHidden = true
            
        }
        
        alarmArr.removeFirst()
        tableView.reloadData()
        
        
        self.tabBarController?.tabBar.isHidden = true
        
    }
}

    
    @objc func snoozing (_ sender: UIButton) {
    
                    resultHour = 0
                    resultMinute = 5
                    resultSecond = 0
                    backgroundImage.isHidden = true
                    timeLeftLabel.isHidden = false
                    firstOnAlarm?.isOn = true
                    self.tabBarController?.tabBar.isHidden = false
                    player?.stop()
                    isEnd = false
        alarmArr.append(BasicModel2(hour: defaults.string(forKey: "save hour") ?? "",
                                      minut: defaults.string(forKey: "save minut") ?? "",
                                      day: defaults.string(forKey: "day") ?? "",
                                      month: defaults.string(forKey: "month") ?? "",
                                      year: defaults.string(forKey: "year") ?? "",
                                      isOn: false,
                                      note: defaults.string(forKey: "save note") ?? "",
                                      weekdays: (defaults.array(forKey: "save days of the week") as? [String]) ?? [String](),
                                      music: defaults.string(forKey: "save musicPlayer") ?? "",
                                      musicName: defaults.string(forKey: "save musicName") ?? "",
                                      isRepeat: false))

    }
    
    @objc func dismissPanGesture(_ sender: UIPanGestureRecognizer){
        switch sender.state {
            
        case .changed:
            let translation = sender.translation(in: backgroundImage)
            
            subDismissLabel.transform = CGAffineTransform(translationX: translation.x, y: 0)
            
        case .ended:

            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.subDismissLabel.transform = .identity
            })

            backgroundImage.isHidden = true
            player?.stop()
            self.tabBarController?.tabBar.isHidden = false
            
        default:
            break
            
        }
        
    }
    

}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
       return alarmArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppearanceCell") as! AppearanceCell
        
        weekArr = alarmArr[indexPath.row].weekdays ?? [String]()

        index = indexPath.row

        cell.showHourLbl.text = alarmArr[indexPath.row].hour ?? ""
        cell.showMinutLbl.text = alarmArr[indexPath.row].minut ?? ""
        cell.noteLabel.text = alarmArr[indexPath.row].note ?? ""
        cell.colonLbl.text = ":"
        cell.showDayLbl.text = alarmArr[indexPath.row].day ?? ""
        cell.showYearLbl.text = alarmArr[indexPath.row].year ?? ""
        cell.mySwitch.isOn = alarmArr[indexPath.row].isOn ?? false
        cell.mySwitch.tag = indexPath.row
        cell.mySwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        
        if alarmArr[indexPath.row].month ?? "" == "01" {
            cell.showMonthLbl.text = "Jan"
        }
        if alarmArr[indexPath.row].month ?? "" == "02" {
            cell.showMonthLbl.text = "Feb"
        }
        if alarmArr[indexPath.row].month ?? "" == "03" {
            cell.showMonthLbl.text = "Mar"
        }
        if alarmArr[indexPath.row].month ?? "" == "04" {
            cell.showMonthLbl.text = "Apr"
        }
        if alarmArr[indexPath.row].month ?? "" == "05" {
            cell.showMonthLbl.text = "May"
        }
        if alarmArr[indexPath.row].month ?? "" == "06" {
            cell.showMonthLbl.text = "Jun"
        }
        if alarmArr[indexPath.row].month ?? "" == "07" {
            cell.showMonthLbl.text = "Jul"
        }
        if alarmArr[indexPath.row].month ?? "" == "08" {
            cell.showMonthLbl.text = "Aug"
        }
        if alarmArr[indexPath.row].month ?? "" == "09" {
            cell.showMonthLbl.text = "Sep"
        }
        if alarmArr[indexPath.row].month ?? "" == "10" {
            cell.showMonthLbl.text = "Oct"
        }
        if alarmArr[indexPath.row].month ?? "" == "11" {
            cell.showMonthLbl.text = "Nov"
        }
        if alarmArr[indexPath.row].month ?? "" == "12" {
            cell.showMonthLbl.text = "Dec"
        }
        for i in 0..<weekArr.count {
            if weekArr[i] == "Every Monday" {
                cell.mondayLbl.textColor = .cyan
            }
            
            if weekArr[i] == "Every Tuesday" {
                cell.tuesLbl.textColor = .cyan
            }
            
            if weekArr[i] == "Every Wednesday" {
                cell.wedLbl.textColor = .cyan
            }
            if weekArr[i] == "Every Thursday" {
                cell.thursLbl.textColor = .cyan
            }
            if weekArr[i] == "Every Friday" {
                cell.friLbl.textColor = .cyan
            }
            if weekArr[i] == "Every Saturday" {
                cell.satLbl.textColor = .cyan
            }
            if weekArr[i] == "Every Sunday" {
                cell.sunLbl.textColor = .cyan
            }
        }
        
        if weekArr.count == 0 {
            cell.weekdaysView.isHidden = true
        } else {
            cell.weekdaysView.isHidden = false
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        index = indexPath.row
        isEdit = true
        
        
        let vc = AlarmViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.customView.rightBtn.setTitle("Edit", for: .normal)
        vc.hour = alarmArr[indexPath.row].hour ?? ""
        vc.minut = alarmArr[indexPath.row].minut ?? ""
        vc.day = alarmArr[indexPath.row].day ?? ""
        vc.month = alarmArr[indexPath.row].month ?? ""
        vc.year = alarmArr[indexPath.row].year ?? ""
        defaults.set(alarmArr[indexPath.row].note, forKey: "save note")
        defaults.set(alarmArr[indexPath.row].weekdays, forKey: "save days of the week")
        defaults.set(alarmArr[indexPath.row].music, forKey: "save musicPlayer")
        defaults.set(alarmArr[indexPath.row].musicName, forKey: "save musicName")
        defaults.set(alarmArr[indexPath.row].isRepeat, forKey: "isRepeat")

        navigationController?.pushViewController(vc, animated: true)

    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            alarmArr.remove(at: indexPath.row)
            if alarmArr.count == 0 {
                timeLeftLabel.isHidden = true
                alarmTextLbl.text = "Alarm clock off"
                timer.invalidate()
            } else {
                timer.invalidate()
                resultHour = 0
                resultMinute = 0
                resultSecond = 0
                showTime()
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    @objc func switchChanged (_ sender: UISwitch) {
        index = sender.tag
        alarmArr[index].isOn = !(alarmArr[index].isOn ?? false)
        timer.invalidate()
        resultHour = 0
        resultMinute = 0
        resultSecond = 0
        showTime()
        

        
    }
        


    
}
