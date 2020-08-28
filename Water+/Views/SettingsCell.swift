//
//  SettingsCell.swift
//  Water+
//
//  Created by Илья Кузнецов on 03.06.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    @IBOutlet weak var textOutlet: UILabel!
    
    
    var sectionType: SectionType? {
        didSet {
            guard let sectionType = sectionType else { return }
            textLabel?.text = sectionType.description
            //switchControl.isHidden = !sectionType.containsSwitch
        }
    }
     
//    lazy var switchControl: UISwitch = {
//        let switchControl = UISwitch()
//        switchControl.isOn = true
//        switchControl.onTintColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
//        switchControl.translatesAutoresizingMaskIntoConstraints = false
//        switchControl.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
//        return switchControl
//    }()
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        addSubview(switchControl)
//        switchControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        switchControl.centerXAnchor.constraint(equalTo: rightAnchor, constant: -70).isActive = true
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
//    @objc func handleSwitchAction(sender: UISwitch) {
//        if sender.isOn {
//            print("turned on")
//        } else {
//            print("turned off")
//        }
//    }
}
