//
//  HypeListViewController.swift
//  Hype
//
//  Created by Curt McCune on 6/13/22.
//

import UIKit

class HypeListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    
    @IBAction func addHypeButtonTapped(_ sender: Any) {
    }

    
}

extension HypeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HypeController.shared.hypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hypeCell", for: indexPath)
        
        
        return cell
    }
    
    
}
