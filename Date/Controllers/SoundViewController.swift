//
//  SoundViewController.swift
//  Date
//
//  Created by macbook on 5/3/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import UIKit

import AVFoundation

class SoundViewController: UIViewController {
    
    let customView = NavigationView2()
    let tableView = UITableView()
    var defaults = UserDefaults.standard
    var model = Model()
    
    
    var player: AVAudioPlayer?
    
    func playSound(index: Int) {
        let path = Bundle.main.path(forResource: model.musicPlayArr[index].soundURl ?? "", ofType: nil)
        let url = URL(fileURLWithPath: path ?? "")
        
        do {
            player = try? AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("couldn't load the file")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 48/255, green: 48/255, blue: 60/255, alpha: 1)
        
        view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = UIColor(red: 68/255, green: 68/255, blue: 90/255, alpha: 1)
        customView.leftBtn.addTarget(self, action: #selector(backClicked(_:)), for: .touchUpInside)
        customView.rightBtn.isHidden = true
        customView.leftBtn.setTitle("Back", for: .normal)
        customView.titleText.text = "Select ringtone"
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SoundCell.self, forCellReuseIdentifier: "SoundCell")
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

extension SoundViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as! Header
        return headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.musicPlayArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SoundCell") as! SoundCell
        cell.selectionStyle = .none
        cell.soundName.text = model.musicPlayArr[indexPath.row].soundName ?? ""
        
     
        
        if model.musicPlayArr[indexPath.row].soundName == defaults.string(forKey: "save musicName") ?? "" {
            cell.checkMark.isHidden = false
           
        } else {
            cell.checkMark.isHidden = true
        }
        
        
        if indexPath.row == 0 {
            cell.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
        }
        if indexPath.row == model.musicPlayArr.count-1 {
            cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        for i in 0..<model.musicPlayArr.count {
            model.musicPlayArr[i].isCheck = false
        }
            model.musicPlayArr[indexPath.row].isCheck = !(model.musicPlayArr[indexPath.row].isCheck ?? false)
        
        defaults.set(model.musicPlayArr[indexPath.row].soundName, forKey: "save musicName")
        defaults.set(model.musicPlayArr[indexPath.row].soundURl, forKey: "save musicPlayer")
      
        playSound(index: indexPath.row)
            tableView.reloadData()
        }
        

}

