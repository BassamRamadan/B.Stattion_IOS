//
//  TrashingController.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 1/19/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit
import SDWebImage
class FavouriteCompanies: common {
    var TrashingCompanies = [FavDetails]()
    @IBOutlet weak var TrashingTable: UITableView!
    
    @IBAction func Delete(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "هل تريد حذف المسار بالفعل" , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "لا أوافق", style: .default, handler: { action in
        }))
        alert.addAction(UIAlertAction(title: "موافق", style: .default, handler: { action in
            self.DeleteCompany(self.TrashingCompanies[(sender as! UIButton).tag].id)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadingCompanies()
    }
    fileprivate func DeleteCompany(_ Id : Int){
        self.loading()
        let url = "https://services-apps.net/bstation/public/api/user/delete-from-favourite/\(Id)"
        let headers = [ "Content-Type": "application/json" ,
                        "Accept" : "application/json",
                        "Authorization" : "Bearer \(CashedData.getUserApiKey() ?? "")"
        ]
        AlamofireRequests.PostMethod(methodType: "DELETE", url: url, info: [:], headers: headers){
            (error, success, jsonData) in
            do {
                self.stopAnimating()
                let decoder = JSONDecoder()
                if error == nil{
                    if success{
                        self.loadingCompanies()
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
    fileprivate func loadingCompanies(){
        self.loading()
        let url = "https://services-apps.net/bstation/public/api/user/favourite-list"
        let headers = [ "Content-Type": "application/json" ,
                        "Accept" : "application/json",
                         "Authorization" : "Bearer \(CashedData.getUserApiKey() ?? "")"
        ]
        self.TrashingCompanies.removeAll()
        AlamofireRequests.getMethod(url: url, headers: headers){
            (error, success, jsonData) in
            do {
                self.stopAnimating()
                let decoder = JSONDecoder()
                if error == nil{
                    if success{
                        let propertiesRecived = try decoder.decode(FavList.self, from: jsonData)
                        self.TrashingCompanies.append(contentsOf: propertiesRecived.data)
                        if self.TrashingCompanies.count == 0{
                            self.present(common.makeAlert(message: "لا يوجد بيانات"), animated: true, completion: nil)
                        }
                        self.TrashingTable.reloadData()
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
extension FavouriteCompanies: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TrashingCompanies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCompanies", for: indexPath) as! CompanyCell
        cell.companyImage.sd_setImage(with: URL(string: TrashingCompanies[indexPath.row].ImagePath ?? ""))
        cell.companyName.text = TrashingCompanies[indexPath.row].name
        cell.ratePercentage.text = "\(TrashingCompanies[indexPath.row].AvgRate)"
        cell.rateLevel.text = RatingLevel.Level(Double(TrashingCompanies[indexPath.row].AvgRate))
        cell.rateView.rating = Double(TrashingCompanies[indexPath.row].AvgRate)
        cell.cityName.text = TrashingCompanies[indexPath.row].CityName
        cell.DeleteButton.tag = indexPath.row
        return cell
    }
    
}
