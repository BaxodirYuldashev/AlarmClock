//
//  AboutAPPController.swift
//  Date
//
//  Created by macbook on 6/12/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import UIKit

class AboutAPPController: UIViewController {
    
    let customView = NavigationView2()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = UIColor(red: 68/255, green: 68/255, blue: 90/255, alpha: 1)
//        customView.leftBtn.addTarget(self, action: #selector(backClicked(_:)), for: .touchUpInside)
        customView.rightBtn.isHidden = true
        customView.leftBtn.isHidden = true
        customView.titleText.text = "About this APP"
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AboutAppCell.self, forCellReuseIdentifier: "AboutAppCell")
        
        
        
        NSLayoutConstraint.activate([
            
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leftAnchor.constraint(equalTo: view.leftAnchor),
            customView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            tableView.topAnchor.constraint(equalTo: customView.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        ])
    }
    
    @objc func backClicked(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        HomeViewController.isShow = false
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension AboutAPPController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutAppCell") as! AboutAppCell
        cell.label.text = "An alarm clock (or sometimes just an alarm) is a clock that is designed to alert an individual or group of individuals at a specified time. The primary function of these clocks is to awaken people from their night's sleep or short naps; they are sometimes used for other reminders as well.\nA stopwatch is a timepiece designed to measure the amount of time that elapses between its activation and deactivation.\nA large digital version of a stopwatch designed for viewing at a distance, as in a sports stadium, is called a stop clock. In manual timing, the clock is started and stopped by a person pressing a button. In fully automatic time, both starting and stopping are triggered automatically, by sensors. The timing functions are traditionally controlled by two buttons on the case. Pressing the top button starts the timer running, and pressing the button a second time stops it, leaving the elapsed time displayed. A press of the second button then resets the stopwatch to zero. The second button is also used to record split times or lap times. When the split time button is pressed while the watch is running it allows the elapsed time to that point to be read, but the watch mechanism continues running to record total elapsed time. Pressing the split button a second time allows the watch to resume display of total time."
        return cell
    }
    
    
}
