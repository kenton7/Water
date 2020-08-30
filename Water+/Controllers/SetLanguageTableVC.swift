//
//  SetLanguageTableVC.swift
//  Water+
//
//  Created by Илья Кузнецов on 06.07.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class SetLanguageTableVC: UITableViewController {
    
    
    @IBOutlet weak var languageLabel: UILabel!
    
    let lang = LanguagesScreen()
    var selectedArray = NSMutableArray()
    
    var availableLanguages: [String] {
        var availableLanguages = Bundle.main.localizations
        if let indexOfBase = availableLanguages.firstIndex(of: "Base") {
            availableLanguages.remove(at: indexOfBase)
        }
        return availableLanguages
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.tabBarController?.navigationItem.title = "Язк"
//        self.tabBarController?.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.tabBarController?.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.isNavigationBarHidden = true
//        self.tabBarController?.navigationController?.isNavigationBarHidden = false
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
        tableView.tableFooterView = UIView()
        
        availableLanguages.map {
            Locale.current.localizedString(forLanguageCode: $0)!
        }
    }
    
    @IBAction func unwindSegueFromLanguage(segue: UIStoryboardSegue) {
        
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lang.languagesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.languageCell, for: indexPath) as! LanguageCell
        cell.tintColor = .black
        cell.languageLabel.text = lang.languagesArray[indexPath.row]
        
        if selectedArray.contains(lang.languagesArray[indexPath.row]) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
        
        switch lang.languagesArray[indexPath.row] {
        case "Русский":
            print("Русский")
        case "Английский":
            print("English")
        case "Немецкий":
            print("Deutsche")
        case "Французский":
            print("france")
            
        case "Итальянский":
            print("Italiano")
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
    }

}


