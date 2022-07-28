//
//  TimerAnimationController.swift
//  Date
//
//  Created by macbook on 6/5/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import UIKit

import AVFoundation

class TimerAnimationController: UIViewController {
    
    let customView = NavigationView()
    let shapeView = UIImageView()
    let hourLabel = UILabel()
    let minutLabel = UILabel()
    let secondLabel = UILabel()
    let colonLbl = UILabel()
    let colonLbl2 = UILabel()
    var timer: Timer?
    var timerModel: TimerModel?
    let shapeLayer = CAShapeLayer()
    let pauseBtn = UIButton(type: .system)
    let resumeBtn = UIButton(type: .system)
    let cancelBtn = UIButton(type: .system)
    let maskLabel = UILabel()
    let maskLabel2 = UILabel()
    var duration = Int()
    var duration2 = Int()
    
    let dismissView = UIView()
    let hourGlass = UIImageView()
    let label = UILabel()
    let timeOffsetLabel = UILabel()
    let dismissButton = UIButton(type: .system)
    let restartButton = UIButton(type: .system)
    var dismissTimer = Timer()
    
    var hour = 0
    var minut = 0
    var second = 0
    var extraSecond = 0
    
    var player: AVAudioPlayer?
    
    func playSound() {
        let path = Bundle.main.path(forResource: "uplift-25942.mp3", ofType: nil)
        let url = URL(fileURLWithPath: path ?? "")
        
        do {
            player = try? AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("couldn't load the file")
        }
        
    }
    
    func stopSound() {
        let path = Bundle.main.path(forResource: "uplift-25942.mp3", ofType: nil)
        let url = URL(fileURLWithPath: path ?? "")
        
        do {
            player = try? AVAudioPlayer(contentsOf: url)
            player?.stop()
        } catch {
            print("couldn't load the file")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.animationCircular()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)//UIColor(red: 58/255, green: 58/255, blue: 80/255, alpha: 1)
        
        view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = UIColor(red: 68/255, green: 68/255, blue: 90/255, alpha: 1)
        customView.editBtn.isHidden = true
        customView.plusBtn.isHidden = true
        customView.title.text = "Timer"
        
        view.addSubview(dismissView)
        dismissView.translatesAutoresizingMaskIntoConstraints = false
        dismissView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dismissView.alpha = 0
        dismissView.isHidden = true
        dismissView.layer.cornerRadius = 12
        dismissView.layer.borderWidth = 2
        
        dismissView.addSubview(hourGlass)
        hourGlass.translatesAutoresizingMaskIntoConstraints = false
        hourGlass.image = UIImage(named: "hourglass")
        
        dismissView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Timer's up:"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.backgroundColor = .clear
        
        dismissView.addSubview(timeOffsetLabel)
        timeOffsetLabel.translatesAutoresizingMaskIntoConstraints = false
        timeOffsetLabel.textColor = .red
        timeOffsetLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        timeOffsetLabel.backgroundColor = .clear
        
        dismissView.addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        dismissButton.layer.borderWidth = 1
        dismissButton.layer.cornerRadius = 12
        dismissButton.setTitleColor(.white, for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        dismissButton.tag = 4
        
        dismissView.addSubview(restartButton)
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        restartButton.setTitle("Restart", for: .normal)
        restartButton.backgroundColor = #colorLiteral(red: 0.5436306, green: 0.6764801145, blue: 0.5404207706, alpha: 1)
        restartButton.layer.borderWidth = 1
        restartButton.layer.cornerRadius = 12
        restartButton.setTitleColor(.white, for: .normal)
        restartButton.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        restartButton.tag = 5
        
        view.addSubview(shapeView)
        shapeView.image = UIImage(named: "circle3")?.withRenderingMode(.alwaysTemplate)
        shapeView.tintColor = .lightGray
        shapeView.translatesAutoresizingMaskIntoConstraints = false
        
        shapeView.addSubview(hourLabel)
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        hourLabel.font = .systemFont(ofSize: 34, weight: .semibold)
        
        shapeView.addSubview(colonLbl)
        colonLbl.translatesAutoresizingMaskIntoConstraints = false
        colonLbl.font = .systemFont(ofSize: 34, weight: .semibold)
        colonLbl.text = ":"
        
        shapeView.addSubview(minutLabel)
        minutLabel.translatesAutoresizingMaskIntoConstraints = false
        minutLabel.font = .systemFont(ofSize: 34, weight: .semibold)
        
        shapeView.addSubview(colonLbl2)
        colonLbl2.translatesAutoresizingMaskIntoConstraints = false
        colonLbl2.font = .systemFont(ofSize: 34, weight: .semibold)
        colonLbl2.text = ":"
        
        shapeView.addSubview(secondLabel)
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.font = .systemFont(ofSize: 34, weight: .semibold)
        
        view.addSubview(pauseBtn)
        pauseBtn.translatesAutoresizingMaskIntoConstraints = false
        pauseBtn.setTitle("Pause", for: .normal)
        pauseBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1747116961, blue: 0.286368998, alpha: 1)
        pauseBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        pauseBtn.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        pauseBtn.layer.cornerRadius = 25
        pauseBtn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        pauseBtn.tag = 1
        
        view.addSubview(resumeBtn)
        resumeBtn.translatesAutoresizingMaskIntoConstraints = false
        resumeBtn.setTitle("Resume", for: .normal)
        resumeBtn.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        resumeBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        resumeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        resumeBtn.layer.cornerRadius = 25
        resumeBtn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        resumeBtn.tag = 2
        resumeBtn.isHidden = true
        
        view.addSubview(cancelBtn)
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        cancelBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        cancelBtn.layer.cornerRadius = 25
        cancelBtn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        cancelBtn.tag = 3
        
        
        view.addSubview(maskLabel)
        maskLabel.translatesAutoresizingMaskIntoConstraints = false
        maskLabel.backgroundColor = #colorLiteral(red: 1, green: 0.1747116961, blue: 0.286368998, alpha: 1).withAlphaComponent(0.3)
        maskLabel.text = "Pause"
        maskLabel.textColor = .white
        maskLabel.textAlignment = .center
        maskLabel.layer.cornerRadius = 25
        maskLabel.clipsToBounds = true
        maskLabel.font = .systemFont(ofSize: 22, weight: .medium)
        maskLabel.isHidden = false
        
        view.addSubview(maskLabel2)
        maskLabel2.translatesAutoresizingMaskIntoConstraints = false
        maskLabel2.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1).withAlphaComponent(0.3)
        maskLabel2.text = "Cancel"
        maskLabel2.textColor = .white
        maskLabel2.textAlignment = .center
        maskLabel2.layer.cornerRadius = 25
        maskLabel2.clipsToBounds = true
        maskLabel2.font = .systemFont(ofSize: 22, weight: .medium)
        maskLabel2.isHidden = false
        
        NSLayoutConstraint.activate([
            
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leftAnchor.constraint(equalTo: view.leftAnchor),
            customView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            dismissView.topAnchor.constraint(equalTo: customView.bottomAnchor, constant: 20),
            dismissView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            dismissView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            hourGlass.topAnchor.constraint(equalTo: dismissView.topAnchor,constant: 10),
            hourGlass.leftAnchor.constraint(equalTo: dismissView.leftAnchor,constant: 10),
            hourGlass.widthAnchor.constraint(equalToConstant: 25),
            hourGlass.heightAnchor.constraint(equalTo: hourGlass.widthAnchor),
            
            label.centerYAnchor.constraint(equalTo: hourGlass.centerYAnchor),
            label.leftAnchor.constraint(equalTo: hourGlass.rightAnchor,constant: 10),
            
            timeOffsetLabel.topAnchor.constraint(equalTo: hourGlass.bottomAnchor, constant: 10),
            timeOffsetLabel.leftAnchor.constraint(equalTo: dismissView.leftAnchor,constant: 10),
            
            dismissButton.topAnchor.constraint(equalTo: timeOffsetLabel.bottomAnchor, constant: 10),
            dismissButton.leftAnchor.constraint(equalTo: dismissView.leftAnchor,constant: 10),
            dismissButton.rightAnchor.constraint(equalTo: restartButton.leftAnchor,constant: -10),
            dismissButton.bottomAnchor.constraint(equalTo: dismissView.bottomAnchor,constant: -10),
            
            restartButton.topAnchor.constraint(equalTo: dismissButton.topAnchor),
            restartButton.rightAnchor.constraint(equalTo: dismissView.rightAnchor,constant: -10),
            restartButton.widthAnchor.constraint(equalTo: dismissButton.widthAnchor),
            restartButton.bottomAnchor.constraint(equalTo: dismissButton.bottomAnchor),
            
            shapeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shapeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            shapeView.heightAnchor.constraint(equalToConstant: 300),
            shapeView.widthAnchor.constraint(equalToConstant: 300),
            
            hourLabel.topAnchor.constraint(equalTo: shapeView.topAnchor, constant: 52),
            hourLabel.leftAnchor.constraint(equalTo: shapeView.leftAnchor, constant: 50),
            hourLabel.bottomAnchor.constraint(equalTo: shapeView.bottomAnchor, constant: -50),
            
            colonLbl.leftAnchor.constraint(equalTo: hourLabel.rightAnchor, constant: 10),
            colonLbl.centerYAnchor.constraint(equalTo: hourLabel.centerYAnchor),
            
            minutLabel.topAnchor.constraint(equalTo: hourLabel.topAnchor),
            minutLabel.leftAnchor.constraint(equalTo: colonLbl.rightAnchor, constant: 10),
            minutLabel.bottomAnchor.constraint(equalTo: hourLabel.bottomAnchor),
            
            colonLbl2.leftAnchor.constraint(equalTo: minutLabel.rightAnchor, constant: 10),
            colonLbl2.centerYAnchor.constraint(equalTo: minutLabel.centerYAnchor),
            
            secondLabel.topAnchor.constraint(equalTo: hourLabel.topAnchor),
            secondLabel.leftAnchor.constraint(equalTo: colonLbl2.rightAnchor, constant: 10),
            secondLabel.bottomAnchor.constraint(equalTo: hourLabel.bottomAnchor),
            
            pauseBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            pauseBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            pauseBtn.heightAnchor.constraint(equalToConstant: 50),
            pauseBtn.widthAnchor.constraint(equalToConstant: 120),
            
            resumeBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            resumeBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            resumeBtn.heightAnchor.constraint(equalToConstant: 50),
            resumeBtn.widthAnchor.constraint(equalToConstant: 120),
            
            cancelBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            cancelBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            cancelBtn.heightAnchor.constraint(equalToConstant: 50),
            cancelBtn.widthAnchor.constraint(equalToConstant: 120),
            
            maskLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            maskLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            maskLabel.heightAnchor.constraint(equalToConstant: 50),
            maskLabel.widthAnchor.constraint(equalToConstant: 120),
            
            maskLabel2.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            maskLabel2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            maskLabel2.heightAnchor.constraint(equalToConstant: 50),
            maskLabel2.widthAnchor.constraint(equalToConstant: 120),
            
        
        ])
        
        
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            
        
        
        basicAnimation()
        
        
    }
    
    @objc func btnClicked(_ sender: UIButton){
        var pausedTime : CFTimeInterval = shapeLayer.convertTime(CACurrentMediaTime(), from: nil)
        
        if sender.tag == 1 {
            
            
            shapeLayer.timeOffset = pausedTime
            shapeLayer.speed = 0.0
            
            pauseBtn.isHidden = true
            resumeBtn.isHidden = false
            maskLabel.isHidden = true
            

                timer?.invalidate()
        }
        
        if sender.tag == 2 {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            
            pausedTime = shapeLayer.timeOffset
            shapeLayer.speed = 1.0
            shapeLayer.timeOffset = 0.0
            shapeLayer.beginTime = 0.0
            let resume: CFTimeInterval = shapeLayer.convertTime(CACurrentMediaTime(), from: nil)
            shapeLayer.beginTime = resume - pausedTime
            
            resumeBtn.isHidden = true
            pauseBtn.isHidden = false
            maskLabel.isHidden = true
        }
        
        if sender.tag == 3 {
            timer?.invalidate()
            navigationController?.popViewController(animated: true)
        }
        
       
    }
    
    
    
    @objc func timerAction () {
     
        
        timerModel?.second = (timerModel?.second ?? 0) - 1
        
        if timerModel?.second ?? 0 < 0 {
            timerModel?.minut = (timerModel?.minut ?? 0) - 1
            timerModel?.second = 59
        }
        
        if timerModel?.minut ?? 0 < 0 {
            timerModel?.hour = (timerModel?.hour ?? 0) - 1
            timerModel?.minut = 59
        }
        
        
        
        if timerModel?.hour ?? 0 < 10 {
            hourLabel.text = "0\(timerModel?.hour ?? 0)"
           
        } else {
            hourLabel.text = "\(timerModel?.hour ?? 0)"
           
        }
        
        if timerModel?.minut ?? 0 < 10 {
            minutLabel.text = "0\(timerModel?.minut ?? 0)"
           
        } else {
            minutLabel.text = "\(timerModel?.minut ?? 0)"
            
        }
        
        if timerModel?.second ?? 0 < 10 {
           secondLabel.text = "0\(timerModel?.second ?? 0)"
           
        } else {
            secondLabel.text = "\(timerModel?.second ?? 0)"
            
        }
        
        if timerModel?.hour ?? 0 == 0 && timerModel?.minut ?? 0 == 0 && timerModel?.second ?? 0 <= 10 {
            hourLabel.textColor = .red
            minutLabel.textColor = .red
            secondLabel.textColor = .red
            colonLbl.textColor = .red
            colonLbl2.textColor = .red

        } else {
            hourLabel.textColor = .black
            minutLabel.textColor = .black
            secondLabel.textColor = .black
            colonLbl.textColor = .black
            colonLbl2.textColor = .black

        }
        
        if timerModel?.second == 0 && timerModel?.minut == 0 && timerModel?.hour == 0 {
            if timer != nil {
                timer?.invalidate()
                timer = nil
            }
            UIView.animate(withDuration: 1) {
                self.dismissView.alpha = 1
                self.dismissView.isHidden = false
            }
            dismissTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(dismissTimerAction), userInfo: nil, repeats: true)
            
            playSound()
            
            pauseBtn.isHidden = true
            cancelBtn.isHidden = true
            maskLabel.isHidden = false
            maskLabel2.isHidden = false
        }
        
       
    }
    
    @objc func dismissTimerAction() {
        
        
        
        timeOffsetLabel.text = String(format: "-%02d:%02d:%02d", hour, minut, second)
        second += 1
        
        if second == 60 {
            minut += 1
            second = 0
            if minut == 60 {
                hour += 1
                minut = 0
            }
        }
        
    }
    
    @objc func dismissTapped(_ sender: UIButton) {
        if sender.tag == 4 {
            dismissTimer.invalidate()
            hour = 0
            minut = 0
            second = 0
            stopSound()
            navigationController?.popViewController(animated: true)
        }
        
        if sender.tag == 5 {
            timerModel?.second = extraSecond
            dismissTimer.invalidate()
            hour = 0
            minut = 0
            second = 0
            stopSound()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
       
            basicAnimation()
            
            UIView.animate(withDuration: 1){
                self.dismissView.alpha = 0
            }
            pauseBtn.isHidden = false
            cancelBtn.isHidden = false
            maskLabel.isHidden = true
            maskLabel2.isHidden = true
        }
    }
    
    func animationCircular() {
        
        let arcCenter = CGPoint(x: shapeView.frame.width/2, y: shapeView.frame.height/2)
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        
        let circularPath = UIBezierPath(arcCenter: arcCenter, radius: 140, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 21
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        shapeView.layer.addSublayer(shapeLayer)
        
        if timerModel?.hour ?? 0 == 0 && timerModel?.minut ?? 0 == 0 && timerModel?.second ?? 0 <= 10
        {
            shapeLayer.strokeColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor
        } else {
            shapeLayer.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1).cgColor
        }
            
    }
    
    func basicAnimation() {
            
        
         duration = (timerModel?.minut ?? 0) * 60 + (timerModel?.second ?? 0)
         duration2 = (timerModel?.hour ?? 0) * 3600
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(duration + duration2)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = true
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
        
    }
    
}


