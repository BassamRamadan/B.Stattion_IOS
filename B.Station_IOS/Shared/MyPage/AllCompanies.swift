//
//  TableViewController.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 12/3/19.
//  Copyright © 2019 Bassam Ramadan. All rights reserved.
//

import UIKit

class TransportCompanies : common {
    var AllCompanies = [RoutesDetails]()

    @IBOutlet weak var SearchDetails: UIView!
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
              loadingCompanies()
        }
    }
    fileprivate func loadingCompanies(){
        self.loading()
        let url = "https://services-apps.net/bstation/public/api/companies"
        let headers = [ "Content-Type": "application/json" ,
                        "Accept" : "application/json"
        ]
        self.AllCompanies.removeAll()
        AlamofireRequests.getMethod(url: url, headers: headers){
            (error, success, jsonData) in
            do {
                self.stopAnimating()
                let decoder = JSONDecoder()
                if error == nil{
                    if success{
                        let propertiesRecived = try decoder.decode(Companies.self, from: jsonData)
                        self.AllCompanies.append(contentsOf: propertiesRecived.data)
                        if self.AllCompanies.count == 0{
                            self.present(common.makeAlert(message: "لا يوجد بيانات مطابقة"), animated: true, completion: nil)
                        }
                        self.AllCompaniesTable.reloadData()
                    }else{
                        let dataRecived = try decoder.decode(ErrorHandle.self, from: jsonData)
                        self.present(common.makeAlert(message: dataRecived.message ?? ""), animated: true, completion: nil)
                    }
                }else{
                    self.present(common.makeAlert(), animated: true, completion: nil)
                }
            } catch {
                self.present(common.makeAlert(message: error.localizedDescription), animated: true, completion: nil)
                
            }
        }
    }
}
extension TransportCompanies: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return AllCompanies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Companies", for: indexPath) as! CompanyCell
        cell.companyImage.isHidden = search
        cell.path.isHidden = search
        if search == false{
            cell.companyImage.sd_setImage(with: URL(string: "https://services-apps.net/bstation/public/images/users/"+AllCompanies[indexPath.row].image!))
            if AllCompanies[indexPath.row].trafficRoutes.count > 0{
                cell.StartPoint.text = AllCompanies[indexPath.row].trafficRoutes[0].fromStation
                cell.EndPoint.text = AllCompanies[indexPath.row].trafficRoutes[0].toStation
            }else{
                cell.StartPoint.text = "لم تحدد الشركة"
                cell.EndPoint.text = "اي مسارات"
            }
        }
        
        cell.companyName.text = AllCompanies[indexPath.row].name
        cell.ratePercentage.text = "\(AllCompanies[indexPath.row].avgRate ?? 0)"
        cell.rateLevel.text = RatingLevel().Level(AllCompanies[indexPath.row].avgRate!)
        cell.rateView.rating = AllCompanies[indexPath.row].avgRate ?? 0
        cell.bio.text = AllCompanies[indexPath.row].bio
        return cell
    }
   
}
class RatingLevel{
    func Level(_ avgRate : Double) -> String{
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
