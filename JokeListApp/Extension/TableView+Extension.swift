//
//  TableView+Extension.swift
//  JokeListApp
//
//  Created by Parveen Khan on 04/05/23.
//

import UIKit


extension UITableView {
    
    /// to show loader on tableview footer
    func showLoadingFooter() {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .systemIndigo
        spinner.startAnimating()
        spinner.frame = CGRect(x: 0.0, y: 0.0, width: self.bounds.width, height: 44)
        self.tableFooterView = spinner
        self.tableFooterView?.isHidden = false
    }
    
    
    /// to hide loader from tableview footer
    func hideLoadingFooter() {
        self.tableFooterView?.isHidden = true
        self.tableFooterView = nil
    }
}
