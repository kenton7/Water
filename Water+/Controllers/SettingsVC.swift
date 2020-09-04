//
//  SettingsVC.swift
//  Water+
//
//  Created by Илья Кузнецов on 04.07.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class SettingsVC: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Настройки"
        self.tabBarController?.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        self.tabBarController?.navigationController?.isNavigationBarHidden = false
        
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.register(SettingsCell.self, forCellReuseIdentifier: K.cellIdentifier)
        tableView.rowHeight = 60
        //убираем пустые ячейки в таблице
        tableView.tableFooterView = UIView()
    }
    
    func setupDarkMode() {
        view.backgroundColor = .tertiarySystemBackground
        navigationController?.navigationBar.barTintColor = .tertiarySystemBackground
        tabBarController?.tabBar.barTintColor = .tertiarySystemBackground
    }
    
    
    @IBAction func editDaillyNormalPressed(_ sender: UIButton) {
        
    }
    @IBAction func editWeightPressed(_ sender: UIButton) {
        
    }
    @IBAction func notificationsPressed(_ sender: UIButton) {
        
    }
    @IBAction func setLanguagePressed(_ sender: UIButton) {
        
    }
    @IBAction func rateAppPressed(_ sender: UIButton) {
        
    }
    @IBAction func writeToDevelopersPressed(_ sender: UIButton) {
        
    }
    @IBAction func aboutApp(_ sender: UIButton) {
        
    }
    
    @IBAction func unwindToSettingsC(segue: UIStoryboardSegue) {
        
     }
    
    @IBAction func setupDarkMode(_ sender: UISwitch) {
        //sender.addTarget(self, action: #selector(turnOnDarkMode), for: .touchUpInside)
    }
    
    
    
    // MARK: - Table view data source
    //настраиваем header под себя
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = .white
        title.text = SettingsSections(rawValue: section)?.description
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        return view
    }
    //высота между разделителями
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        return SettingsSections.allCases.count
    //    }
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //
    //            guard let section = SettingsSections(rawValue: section) else { return 0 }
    //
    //            switch section {
    //            case .General:
    //                return GeneralOptions.allCases.count
    //            case .Customization:
    //                return CustomizationOptions.allCases.count
    //            case .About:
    //                return AboutOptions.allCases.count
    //            }
    //        }
    //
    //    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //            let view = UIView()
    //            view.backgroundColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
    //            let title = UILabel()
    //            title.font = UIFont.boldSystemFont(ofSize: 16)
    //            title.textColor = .white
    //            title.text = SettingsSections(rawValue: section)?.description
    //            view.addSubview(title)
    //            title.translatesAutoresizingMaskIntoConstraints = false
    //            title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    //            title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    //
    //            return view
    //        }
    //
    //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //            let cell = tableView.dequeueReusableCell(withIdentifier: K.settingsCell, for: indexPath) as! SettingsCell
    //
    //            guard let section = SettingsSections(rawValue: indexPath.section) else { return UITableViewCell() }
    //
    //            switch section {
    //            case .General:
    //                let general = GeneralOptions(rawValue: indexPath.row)
    //                cell.textLabel?.text = general?.description
    //                cell.sectionType = general
    //            case .Customization:
    //                let customization = CustomizationOptions(rawValue: indexPath.row)
    //                cell.textLabel?.text = customization?.description
    //            case .About:
    //                let about = AboutOptions(rawValue: indexPath.row)
    //                cell.textLabel?.text = about?.description
    //                cell.sectionType = about
    //            }
    //
    //            return cell
    //        }
    //
    //    }
}

