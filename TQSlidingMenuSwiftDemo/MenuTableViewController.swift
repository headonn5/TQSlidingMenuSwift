//
//  MenuTableViewController.swift
//  TQSlidingMenuSwift
//
//  Created by Nishant Paul on 18/02/17.
//  Copyright © 2017 TechQuench. All rights reserved.
//

import UIKit

class MenuTableViewController: TQMenuController
{
    let companyNames = ["Google", "Apple", "Facebook", "MyFutureComapny"]

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "IdCell")
    }
    
    func addSubviews(toView headerView: UIView)
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(label)
        
        // Autolayout constraints
        NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.centerX, relatedBy: .equal, toItem: headerView, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.centerY, relatedBy: .equal, toItem: headerView, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        
        label.text = "Header"
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return companyNames.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 140.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IdCell", for: indexPath)
        
        cell.textLabel?.text = companyNames[indexPath.row]
        
        return cell
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: self.tableView(tableView, heightForHeaderInSection: section)))
        headerView.backgroundColor = UIColor.yellow
        
        addSubviews(toView: headerView)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        switch indexPath.row {
        case 0:
            performCustomSegue(withIdentifier: "id_google")
        case 1:
            performCustomSegue(withIdentifier: "id_apple")
        case 2:
            performCustomSegue(withIdentifier: "id_facebook")
        case 3:
            performCustomSegue(withIdentifier: "id_future_company")
        default:
            performCustomSegue(withIdentifier: "id_google")
        }
        // dismiss the menu view
        dismiss(animated: true, completion: nil)
    }
}


