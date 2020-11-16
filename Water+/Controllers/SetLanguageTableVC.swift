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
    let settingsVC = SettingsVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
        tableView.tableFooterView = UIView()
        
    }
    
    @IBAction func unwindSegueFromLanguage(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
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
        case NSLocalizedString("RUSSIAN", comment: "rus"):
            let alertRu = UIAlertController(title: "Перезапустите приложение", message: "", preferredStyle: .alert)
            let ru = UIAlertAction(title: "Ок", style: .default) { (alert) in
                Bundle.setLanguage("ru")
                UserDefaults.standard.set("ru", forKey: "selectedLanguage")
                self.navigationController?.popToRootViewController(animated: true)
            }
            alertRu.addAction(ru)
            self.present(alertRu, animated: true, completion: nil)
        case NSLocalizedString("ENGLISH", comment: "eng"):
            let alertEn = UIAlertController(title: "Restart the app", message: "", preferredStyle: .alert)
            let en = UIAlertAction(title: "Ok", style: .default) { (alert) in
                Bundle.setLanguage("en")
                UserDefaults.standard.set("en", forKey: "selectedLanguage")
                self.navigationController?.popToRootViewController(animated: true)
            }
            alertEn.addAction(en)
            self.present(alertEn, animated: true, completion: nil)
        case NSLocalizedString("GERMAN", comment: "de"):
            let alertDe = UIAlertController(title: "Starten Sie die Anwendung neu", message: "", preferredStyle: .alert)
            let de = UIAlertAction(title: "Ok", style: .default) { (alert) in
                Bundle.setLanguage("de")
                UserDefaults.standard.set("de", forKey: "selectedLanguage")
                self.navigationController?.popToRootViewController(animated: true)
            }
            alertDe.addAction(de)
            self.present(alertDe, animated: true, completion: nil)
        case NSLocalizedString("FRENCH", comment: "fr"):
            let alertFr = UIAlertController(title: "Redémarrez l'application", message: "", preferredStyle: .alert)
            let fr = UIAlertAction(title: "Ok", style: .default) { (alert) in
                Bundle.setLanguage("fr")
                UserDefaults.standard.set("fr", forKey: "selectedLanguage")
                self.navigationController?.popToRootViewController(animated: true)
            }
            alertFr.addAction(fr)
            self.present(alertFr, animated: true, completion: nil)
        case NSLocalizedString("ITALIAN", comment: "it"):
            let alertIt = UIAlertController(title: "Riavvia l'applicazione", message: "", preferredStyle: .alert)
            let it = UIAlertAction(title: "Ok", style: .default) { (alert) in
                Bundle.setLanguage("it")
                UserDefaults.standard.set("it", forKey: "selectedLanguage")
                self.navigationController?.popToRootViewController(animated: true)
            }
            alertIt.addAction(it)
            self.present(alertIt, animated: true, completion: nil)
        default:
            Bundle.setLanguage("ru")
            UserDefaults.standard.setValue("ru", forKey: "selectedLanguage")
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
    }
    
}

extension Bundle {
    class func setLanguage(_ language: String) {
        var onceToken: Int = 0

        if (onceToken == 0) {
            /* TODO: move below code to a static variable initializer (dispatch_once is deprecated) */
            object_setClass(Bundle.main, PrivateBundle.self)
        }
        onceToken = 1
        objc_setAssociatedObject(Bundle.main, &associatedLanguageBundle, (language != nil) ? Bundle(path: Bundle.main.path(forResource: language, ofType: "lproj") ?? ""): nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
private var associatedLanguageBundle: Character = "0"

class PrivateBundle: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        let bundle: Bundle? = objc_getAssociatedObject(self, &associatedLanguageBundle) as? Bundle
        return (bundle != nil) ? (bundle!.localizedString(forKey: key, value: value, table: tableName)) : (super.localizedString(forKey: key, value: value, table: tableName))
    }
}


