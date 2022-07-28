//
//  Model.swift
//  Date
//
//  Created by macbook on 4/14/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import UIKit

class Model {
    
    let optionsArr = [Options(t: "Repeat", d: "Weekdays"), Options(t: "Label", d: "Morning Alarm"), Options(t: "Sound", d: "Uplift"), Options(t: "Snooze", d: "")]
    
    let repeatArr = [Repeat(day: "Every Monday", isCheck: false), Repeat(day: "Every Tuesday", isCheck: false), Repeat(day: "Every Wednesday", isCheck: false), Repeat(day: "Every Thursday", isCheck: false), Repeat(day: "Every Friday", isCheck: false), Repeat(day: "Every Saturday", isCheck: false), Repeat(day: "Every Sunday", isCheck: false)]
    
    var musicPlayArr = [
        
             MusicPlay(soundName: "Soft Chime", soundURL: "Softchime.mp3", ischeck: false),
            MusicPlay(soundName: "Radar(Default)", soundURL: "Radar - iPhone 13 ! Alarm Sound.mp3", ischeck: false),
            MusicPlay(soundName: "Apex", soundURL: "apex-26621.mp3", ischeck: false),
            MusicPlay(soundName: "Hip Hop", soundURL: "https___www.tones7.com_media_Hip-hop_Alarm.mp3", ischeck: false),
            MusicPlay(soundName: "Uplift", soundURL: "uplift-25942.mp3", ischeck: false),
            MusicPlay(soundName: "Azon", soundURL: "sheyh-mishari-bin-rashid-al--afasi--azan.mp3", ischeck: false),
            MusicPlay(soundName: "Nasheed", soundURL: "sheyh-mishari-bin-rashid-al--afasi-nashid.mp3", ischeck: false),
            MusicPlay(soundName: "Fotiha", soundURL: "sheyh-mishari-ibn-rashid-al--afasi-sura-al--fatiha-otkryvayu.mp3", ischeck: false),
            MusicPlay(soundName: "Nokia", soundURL: "nokia-iphone-a28e6ab4-dccd-3836-962c-52d5d272ead7-42372-54386.mp3", ischeck: false),
            MusicPlay(soundName: "Tentakcham", soundURL: "xamdam-sobirov-tentakcham_(uzhits.net).mp3", ischeck: false),
            MusicPlay(soundName: "Baxt", soundURL: "Asl guruhi - Baxt.mp3", ischeck: false),
            
            ]

    
}

class Options {
    var title: String?
    var desc: String?
    
    init(t: String, d: String){
        self.title = t
        self.desc = d
        
    }

}

class Repeat {
    var day: String?
    var isCheck: Bool?
    
    init(day: String, isCheck: Bool){
        self.day = day
        self.isCheck = isCheck
        
    }
}

class MusicPlay {
    var soundName: String?
    var soundURl: String?
    var isCheck: Bool?
    
    init(soundName: String, soundURL: String, ischeck: Bool) {
        self.soundName = soundName
        self.soundURl = soundURL
        self.isCheck = ischeck
    }
}

class AppearancePage {
  
    var hour: String?
    var minut: String?
    var isOn: Bool?
    
    init (hour: String, minut: String, isOn: Bool) {
       
        self.hour = hour
        self.minut = minut
        self.isOn = isOn
        
    }
}



class Lap {
    var minut: Int?
    var second: Int?
    var millisecond: Int?
    
    init(minut: Int, second: Int, millisecond: Int) {
        self.minut = minut
        self.second = second
        self.millisecond = millisecond
    }
    
}

class TimerModel {
    var hour: Int?
    var minut: Int?
    var second: Int?
    
    init(hour:Int, minut: Int, second: Int) {
        self.hour = hour
        self.minut = minut
        self.second = second
    }
}

class BasicModel {
    var hour: String?
    var minut: String?
    var isOn: Bool?
    var note: String?
    
    init(hour:String, minut: String, isOn: Bool, note: String) {
        self.hour = hour
        self.minut = minut
        self.isOn = isOn
        self.note = note
    }
    
    
}

class BasicModel2 {
    
    var hour: String?
    var minut: String?
    var day: String?
    var month: String?
    var year: String?
    var isOn: Bool?
    var note: String?
    var weekdays: [String]?
    var music: String?
    var musicName: String?
    var isRepeat: Bool?
    
    init(hour:String, minut: String, day: String, month: String, year: String, isOn: Bool, note: String, weekdays: [String], music: String, musicName: String, isRepeat: Bool) {
        self.hour = hour
        self.minut = minut
        self.day = day
        self.month = month
        self.year = year
        self.isOn = isOn
        self.note = note
        self.weekdays = weekdays
        self.music = music
        self.musicName = musicName
        self.isRepeat = isRepeat
    }
}


class Model1 {
    
    var arr = [BasicModel2]()
    
    
    init() {
        
    }
    
    func loadData(hour:String, minut: String, date: String, month: String, year: String, isOn: Bool, note: String, weekdays: [String], music: String, musicName: String, isRepeat: Bool) {
        arr.append(BasicModel2(hour: hour, minut: minut, day: date, month: month, year: year, isOn: isOn, note: note, weekdays: weekdays, music: music, musicName: musicName, isRepeat: isRepeat))
    }
    
}
