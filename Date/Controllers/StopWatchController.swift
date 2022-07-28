//
//  StopWatchController.swift
//  Date
//
//  Created by macbook on 5/27/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import UIKit

class StopWatchController: UIViewController {
    
    let customView = NavigationView2()
    let timerView = UIView()
    let minutLbl = UILabel()
    let secondLbl = UILabel()
    let msLabel = UILabel()
    let lapMinutLbl = UILabel()
    let lapSecondLbl = UILabel()
    let lapMsLabel = UILabel()
    let startBtn = UIButton(type: .system)
    let stopBtn = UIButton(type: .system)
    let lapBtn = UIButton(type: .system)
    let resumeBtn = UIButton(type: .system)
    let resetBtn = UIButton(type: .system)
    var timer = Timer()
    var lapTimer: Timer?
    
    var counter = 0
    var second = 0
    var minut = 0
    var ms = 0
    var lapCounter = 0
    var lapSecond = 0
    var lapMinut = 0
    var lapMs = 0
    var isStop = true
    
    var overallArr = [Lap]()
    var lapArr = [Lap]()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        
        view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = UIColor(red: 68/255, green: 68/255, blue: 90/255, alpha: 1)
        customView.leftBtn.isHidden = true
        customView.rightBtn.isHidden = true
        customView.titleText.text = "StopWatch"
        
        view.addSubview(timerView)
        timerView.translatesAutoresizingMaskIntoConstraints = false
        timerView.backgroundColor = UIColor(red: 108/255, green: 108/255, blue: 130/255, alpha: 1)
        
        timerView.addSubview(minutLbl)
        minutLbl.translatesAutoresizingMaskIntoConstraints = false
        minutLbl.backgroundColor = .clear
        minutLbl.font = .systemFont(ofSize: 34, weight: .medium)
        minutLbl.text = "\(minut)0:"
        
        timerView.addSubview(secondLbl)
        secondLbl.translatesAutoresizingMaskIntoConstraints = false
        secondLbl.backgroundColor = .clear
        secondLbl.font = .systemFont(ofSize: 34, weight: .medium)
        secondLbl.text = "\(second)0."
        
        timerView.addSubview(msLabel)
        msLabel.translatesAutoresizingMaskIntoConstraints = false
        msLabel.backgroundColor = .clear
        msLabel.font = .systemFont(ofSize: 34, weight: .medium)
        msLabel.text = "\(ms)0"
        
        timerView.addSubview(lapMinutLbl)
        lapMinutLbl.translatesAutoresizingMaskIntoConstraints = false
        lapMinutLbl.backgroundColor = .clear
        lapMinutLbl.font = .systemFont(ofSize: 20, weight: .medium)
        lapMinutLbl.isHidden = true
        
        timerView.addSubview(lapSecondLbl)
        lapSecondLbl.translatesAutoresizingMaskIntoConstraints = false
        lapSecondLbl.backgroundColor = .clear
        lapSecondLbl.font = .systemFont(ofSize: 20, weight: .medium)
        lapSecondLbl.isHidden = true
        
        timerView.addSubview(lapMsLabel)
        lapMsLabel.translatesAutoresizingMaskIntoConstraints = false
        lapMsLabel.backgroundColor = .clear
        lapMsLabel.font = .systemFont(ofSize: 20, weight: .medium)
        lapMsLabel.isHidden = true
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LapCell.self, forCellReuseIdentifier: "LapCell")
        tableView.register(LapHeader.self, forHeaderFooterViewReuseIdentifier: "LapHeader")
        tableView.isHidden = true
        tableView.layer.cornerRadius = 15
        tableView.layer.masksToBounds = true
        tableView.backgroundColor = UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1)
        
        view.addSubview(startBtn)
        startBtn.translatesAutoresizingMaskIntoConstraints = false
        startBtn.setTitle("Start", for: .normal)
        startBtn.titleLabel?.font = .systemFont(ofSize: 18)
        startBtn.layer.cornerRadius = 20
        startBtn.backgroundColor = UIColor(red: 45/255, green: 200/255, blue: 220/255, alpha: 1)
        startBtn.setTitleColor(.black, for: .normal)
        startBtn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        startBtn.tag = 1
        
        view.addSubview(stopBtn)
        stopBtn.translatesAutoresizingMaskIntoConstraints = false
        stopBtn.setTitle("Stop", for: .normal)
        stopBtn.titleLabel?.font = .systemFont(ofSize: 17)
        stopBtn.layer.cornerRadius = 15
        stopBtn.backgroundColor = UIColor(red: 203/255, green: 45/255, blue: 20/255, alpha: 1)
        stopBtn.setTitleColor(.white, for: .normal)
        stopBtn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        stopBtn.tag = 2
        stopBtn.isHidden = true
        
        view.addSubview(lapBtn)
        lapBtn.translatesAutoresizingMaskIntoConstraints = false
        lapBtn.setTitle("Lap", for: .normal)
        lapBtn.titleLabel?.font = .systemFont(ofSize: 17)
        lapBtn.layer.cornerRadius = 15
        lapBtn.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        lapBtn.setTitleColor(.white, for: .normal)
        lapBtn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        lapBtn.tag = 3
        lapBtn.isHidden = true
        
        view.addSubview(resumeBtn)
        resumeBtn.translatesAutoresizingMaskIntoConstraints = false
        resumeBtn.setTitle("Resume", for: .normal)
        resumeBtn.titleLabel?.font = .systemFont(ofSize: 17)
        resumeBtn.layer.cornerRadius = 15
        resumeBtn.backgroundColor = UIColor(red: 50/255, green: 180/255, blue: 90/255, alpha: 1)
        resumeBtn.setTitleColor(.white, for: .normal)
        resumeBtn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        resumeBtn.tag = 4
        resumeBtn.isHidden = true
        
        view.addSubview(resetBtn)
        resetBtn.translatesAutoresizingMaskIntoConstraints = false
        resetBtn.setTitle("Reset", for: .normal)
        resetBtn.titleLabel?.font = .systemFont(ofSize: 17)
        resetBtn.layer.cornerRadius = 15
        resetBtn.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        resetBtn.setTitleColor(.white, for: .normal)
        resetBtn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        resetBtn.tag = 5
        resetBtn.isHidden = true
        
        
        NSLayoutConstraint.activate([
            
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leftAnchor.constraint(equalTo: view.leftAnchor),
            customView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            timerView.topAnchor.constraint(equalTo: customView.bottomAnchor),
            timerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            timerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            timerView.heightAnchor.constraint(equalToConstant: 200),
            
            tableView.topAnchor.constraint(equalTo: timerView.bottomAnchor, constant: 5),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            tableView.bottomAnchor.constraint(equalTo: startBtn.topAnchor),
            
            minutLbl.topAnchor.constraint(equalTo: secondLbl.topAnchor),
            minutLbl.rightAnchor.constraint(equalTo: secondLbl.leftAnchor, constant: -5),
            minutLbl.bottomAnchor.constraint(equalTo: secondLbl.bottomAnchor),
            
            secondLbl.centerYAnchor.constraint(equalTo: timerView.centerYAnchor),
            secondLbl.centerXAnchor.constraint(equalTo: timerView.centerXAnchor),
            
            msLabel.topAnchor.constraint(equalTo: secondLbl.topAnchor),
            msLabel.leftAnchor.constraint(equalTo: secondLbl.rightAnchor, constant: 5),
            msLabel.bottomAnchor.constraint(equalTo: secondLbl.bottomAnchor),
            
            lapMinutLbl.topAnchor.constraint(equalTo: lapSecondLbl.topAnchor),
            lapMinutLbl.rightAnchor.constraint(equalTo: lapSecondLbl.leftAnchor, constant: -5),
            lapMinutLbl.bottomAnchor.constraint(equalTo: lapSecondLbl.bottomAnchor),
            
            lapSecondLbl.topAnchor.constraint(equalTo: secondLbl.bottomAnchor, constant: 5),
            lapSecondLbl.centerXAnchor.constraint(equalTo: secondLbl.centerXAnchor),
            lapSecondLbl.bottomAnchor.constraint(equalTo: timerView.bottomAnchor, constant: -30),
            
            lapMsLabel.topAnchor.constraint(equalTo: lapSecondLbl.topAnchor),
            lapMsLabel.leftAnchor.constraint(equalTo: lapSecondLbl.rightAnchor, constant: 5),
            lapMsLabel.bottomAnchor.constraint(equalTo: lapSecondLbl.bottomAnchor),
            
            startBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            startBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startBtn.widthAnchor.constraint(equalToConstant: 130),
            startBtn.heightAnchor.constraint(equalToConstant: 50),
            
            stopBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -35),
            stopBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60),
            stopBtn.widthAnchor.constraint(equalToConstant: 100),
            stopBtn.heightAnchor.constraint(equalToConstant: 40),
            
            lapBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -35),
            lapBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60),
            lapBtn.widthAnchor.constraint(equalToConstant: 100),
            lapBtn.heightAnchor.constraint(equalToConstant: 40),
            
            resumeBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -35),
            resumeBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60),
            resumeBtn.widthAnchor.constraint(equalToConstant: 100),
            resumeBtn.heightAnchor.constraint(equalToConstant: 40),
            
            resetBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -35),
            resetBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60),
            resetBtn.widthAnchor.constraint(equalToConstant: 100),
            resetBtn.heightAnchor.constraint(equalToConstant: 40),
            
            ])
        
        
        
    }
    
    @objc func startTimer() {
        
        minut = counter/6000
        second = (counter/100)%60
        ms = counter%100

        counter += 1
        minutLbl.text = String(format: "%02d:", minut)
        secondLbl.text = String(format: "%02d.", second)
        msLabel.text = String(format: "%02d", ms)
        
    }
    
    @objc func lapStartTimer() {
        
        lapMinut = lapCounter/6000
        lapSecond = (lapCounter/100)%60
        lapMs = lapCounter%100
        
        lapCounter += 1
        lapMinutLbl.text = String(format: "%02d:", lapMinut)
        lapSecondLbl.text = String(format: "%02d.", lapSecond)
        lapMsLabel.text = String(format: "%02d", lapMs)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        HomeViewController.isShow = false
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    @objc func btnClicked (_ sender: UIButton) {
        if sender.tag == 1 { // Start
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
            startBtn.isHidden = true
            stopBtn.isHidden = false
            lapBtn.isHidden = false
            
        }
        
        if sender.tag == 2 {  // Stop
            if lapTimer != nil {
               lapTimer?.invalidate()
                lapTimer = nil
            }
            
            timer.invalidate()
            resumeBtn.isHidden = false
            stopBtn.isHidden = true
            lapBtn.isHidden = true
            resetBtn.isHidden = false
            
        }
        
        if sender.tag == 3 {  // Lap
            
            tableView.isHidden = false
            overallArr.append(Lap(minut: minut, second: second, millisecond: ms))
            if lapTimer == nil {
                lapTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(lapStartTimer), userInfo: nil, repeats: true)
            }
            lapArr.append(Lap(minut: lapMinut, second: lapSecond, millisecond: lapMs))
        
            
            lapMinutLbl.isHidden = false
            lapSecondLbl.isHidden = false
            lapMsLabel.isHidden = false
            lapCounter = 0
            
            tableView.reloadData()
        }
        
        if sender.tag == 4 {  // Resume
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
           
            if lapTimer == nil {
                lapTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(lapStartTimer), userInfo: nil, repeats: true)
            }
            
            
            stopBtn.isHidden = !stopBtn.isHidden
            resumeBtn.isHidden = !resumeBtn.isHidden
            lapBtn.isHidden = false
            resetBtn.isHidden = true
        

        }
        
        if sender.tag == 5 {  // Reset
            timer.invalidate()
            minut = 0
            second = 0
            ms = 0
            counter = 0
            minutLbl.text = String(format: "%02d:", minut)
            secondLbl.text = String(format: "%02d.", second)
            msLabel.text = String(format: "%02d", ms)
            overallArr.removeAll()
            
            if lapTimer != nil {
                lapTimer?.invalidate()
                lapTimer = nil
            }
            lapMinut = 0
            lapSecond = 0
            lapMs = 0
            lapCounter = 0
            lapMinutLbl.text = String(format: "%02d:", lapMinut)
            lapSecondLbl.text = String(format: "%02d.", lapSecond)
            lapMsLabel.text = String(format: "%02d", lapMs)
            
            resumeBtn.isHidden = true
            resetBtn.isHidden = true
            startBtn.isHidden = false
            tableView.isHidden = true
            lapMinutLbl.isHidden = true
            lapSecondLbl.isHidden = true
            lapMsLabel.isHidden = true
            
        }
    }
    
    
}

extension StopWatchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "LapHeader") as! LapHeader
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return overallArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LapCell") as! LapCell
        
        cell.lapLbl.text = String(format: "%02d", indexPath.row+1)
        
        if indexPath.row == 0 {
            cell.lapTimesLbl.text = String(format: "%02d:%02d.%02d", overallArr[0].minut ?? 0, overallArr[0].second ?? 0, overallArr[0].millisecond ?? 0)
        } else {
            cell.lapTimesLbl.text = String(format: "%02d:%02d.%02d", lapArr[indexPath.row].minut ?? 0, lapArr[indexPath.row].second ?? 0, lapArr[indexPath.row].millisecond ?? 0)
        }
        
        cell.overallTimesLbl.text = String(format: "%02d:%02d.%02d", overallArr[indexPath.row].minut ?? 0, overallArr[indexPath.row].second ?? 0, overallArr[indexPath.row].millisecond ?? 0)
        

        return cell
    }
    
    
}
