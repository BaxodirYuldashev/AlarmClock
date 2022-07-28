//
//  LabelViewController.swift
//  Date
//
//  Created by macbook on 5/10/22.
//  Copyright © 2022 macbook. All rights reserved.
//

import UIKit

class LabelViewController: UIViewController, UITextFieldDelegate {
    
    let customView = NavigationView2()
    let textField = UITextField()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 48/255, green: 48/255, blue: 60/255, alpha: 1)
        
        view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = UIColor(red: 68/255, green: 68/255, blue: 90/255, alpha: 1)
        customView.leftBtn.addTarget(self, action: #selector(backClicked(_:)), for: .touchUpInside)
        customView.rightBtn.isHidden = true
        customView.leftBtn.setTitle("Back", for: .normal)
        customView.titleText.text = "Make a note"
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .lightGray
        textField.borderStyle = .roundedRect
        textField.keyboardType = UIKeyboardType.default
        textField.font = .systemFont(ofSize: 22)
        textField.textColor = .black
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.placeholder = "Make a note"
        textField.text = defaults.string(forKey: "save note")
        textField.addTarget(self, action: #selector(change), for: .editingChanged)
        textField.delegate = self
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
      
        
        NSLayoutConstraint.activate([
            
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leftAnchor.constraint(equalTo: view.leftAnchor),
            customView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            textField.topAnchor.constraint(equalTo: customView.bottomAnchor, constant: 100),
            textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    @objc func backClicked(_ sender: UIButton){
//        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func change (_ sender: UITextField) {
        defaults.set(sender.text, forKey: "save note")
        customView.leftBtn.setTitle("Done", for: .normal)
    }
    
 
}
