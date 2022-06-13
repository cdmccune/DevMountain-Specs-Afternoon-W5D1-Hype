//
//  HypeListViewController.swift
//  Hype
//
//  Created by Curt McCune on 6/13/22.
//

import UIKit

class HypeListViewController: UIViewController {
    
    
    var refresh: UIRefreshControl = UIRefreshControl()
    
    
    @IBOutlet var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setUpViews()
        
    }
    
    
    
    @IBAction func addHypeButtonTapped(_ sender: Any) {
        presentAddHypeAlert()
    }
    
    
    @objc func loadData() {
        HypeController.shared.fetchHypes { success in
            if success   {
                self.updateViews()
            }
        }
    }
    
    func setUpViews() {
        refresh.attributedTitle = NSAttributedString(string: "Pull to see more Hypes!")
        refresh.addTarget(self, action: #selector(loadData), for: .valueChanged)
        tableView.addSubview(refresh)
    }
    
    func updateViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refresh.endRefreshing()
        }
    }
    
    func presentAddHypeAlert() {
        let alertController = UIAlertController(title: "Get Hype!", message: "What is hype may never die", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "What is Hype today?"
            textField.autocorrectionType = .yes
            textField.autocapitalizationType = .sentences
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let addHypeAction = UIAlertAction(title: "Send", style: .default) { _ in
            guard let text = alertController.textFields?.first?.text, !text.isEmpty else {return}
            
            HypeController.shared.saveHype(with: text) { success in
                if success {
                    self.updateViews()
                }
                
            }
        }
        alertController.addAction(addHypeAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
}

extension HypeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HypeController.shared.hypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hypeCell", for: indexPath)
        
        
        let hype = HypeController.shared.hypes[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = hype.body
        content.secondaryText = hype.timestamp.formatDate()
        
        cell.contentConfiguration = content
        
        
        return cell
    }
    
    
}
