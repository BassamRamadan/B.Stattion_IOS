//
//  TableViewController.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 12/3/19.
//  Copyright © 2019 Bassam Ramadan. All rights reserved.
//

import UIKit

class TransportCompanies : UIViewController {
    var AllCompanies = [RoutesDetails]()
    var TrashingCompanies = [RoutesDetails]()
    var CurrentTableIdentifier : String!
    @IBOutlet weak var SearchDetails: UIView!
    @IBOutlet weak var TrashingTable: UITableView!
    @IBOutlet weak var AllCompaniesTable: UITableView!
    @IBOutlet weak var searchName: UILabel!
    @IBOutlet weak var searchPath: UILabel!
    var name : String!
    var path : String!
    var search : Bool! = false
    override func viewDidLoad() {
        super.viewDidLoad()

        if search == true {
            print(AllCompanies.count)
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
        if tableView == AllCompaniesTable{
            CurrentTableIdentifier = "AllCompaniesTable"
            return AllCompanies.count
        }else{
            CurrentTableIdentifier = "TrashingCompanies"
            return TrashingCompanies.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrentTableIdentifier, for: indexPath) as! CompanyCell
        cell.companyImage.isHidden = search
        cell.path.isHidden = search
        cell.companyName.text = AllCompanies[indexPath.row].name
        cell.ratePercentage.text = "\(AllCompanies[indexPath.row].avgRate ?? 0)"
        cell.rateLevel.text = RatingLevel(AllCompanies[indexPath.row].avgRate!)
        cell.rateView.rating = AllCompanies[indexPath.row].avgRate ?? 0
         cell.bio.text = AllCompanies[indexPath.row].bio
        if tableView == AllCompaniesTable{
           
        }else{
          
        }
        return cell
    }
    fileprivate func RatingLevel(_ avgRate : Double) -> String{
        switch avgRate {
        case 0.0...1.0:
            return "مقبول"
        case 1.1...2.0:
            return "جيد"
        case 2.1...3.0:
            return "جيد جدا"
        case 3.1...5.0:
            return "أمتياز"
        default:
            return "مقبول"
        }
    }
}
