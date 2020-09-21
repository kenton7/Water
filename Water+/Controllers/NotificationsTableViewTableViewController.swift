//
//  NotificationsTableViewTableViewController.swift
//  Water+
//
//  Created by Илья Кузнецов on 31.08.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class NotificationsTableViewTableViewController: UITableViewController {
    
    @IBOutlet weak var timeLabelOutlet: UILabel!
    var cellDelegate = FromTableViewCell()
    
    

    var halfModalTransitioningDelegate: HalfModalTransitioningDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView()
        //tableView.register(UITableViewCell.self.classForCoder(), forCellReuseIdentifier: "fromCell")
        
    }
    
    @IBAction func fromPressed(_ sender: UIButton) {
        
    }
    
    
    @IBAction func fromButtomPressed(_ sender: UIButton) {

    }
    
    
    @IBAction func toPressed(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        self.halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: self, presentingViewController: segue.destination)
        
        segue.destination.modalPresentationStyle = .custom
        segue.destination.transitioningDelegate = self.halfModalTransitioningDelegate
    }
    

    // MARK: - Table view data source
    
    //override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "fromCell", for: indexPath) as? FromTableViewCell
        //cell?.timeLabelOutlet.text = "22:00"
//        let timeLabel = cell.viewWithTag(2) as? UILabel
//        if let label = UITa.viewWithTag(1) as? UILabel {
//            if indexPath.row == 0 {
//                label.text = "С"
//                timeLabel?.text = "9:00"
//            } else if indexPath.row == 1 {
//                label.text = "До"
//                timeLabel?.text = "23:00"
//            } else {
//                label.text = "Промежуток"
//                timeLabel?.text = "1 час"
//            }
//        }
        //return cell!
    //}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

