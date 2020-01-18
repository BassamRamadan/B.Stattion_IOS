//
//  TableViewController.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 12/3/19.
//  Copyright © 2019 Bassam Ramadan. All rights reserved.
//

import UIKit

class TransportCompanies : UIViewController {

    @IBOutlet weak var SearchDetails: UIView!
    @IBOutlet weak var searchName: UILabel!
    @IBOutlet weak var searchPath: UILabel!
    var name : String!
    var path : String!
    var search : Bool! = false
    override func viewDidLoad() {
        super.viewDidLoad()

        if search == true {
            searchName.text = name
            searchPath.text = path
            SearchDetails.isHidden = false
        }else{
              SearchDetails.isHidden = true
        }
    }
    
}
extension TransportCompanies: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fav", for: indexPath) as! CompanyCell
        cell.companyImage.isHidden = search
        cell.path.isHidden = search
        return cell
    }
}
