//
//  CompanyPaths.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 1/20/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit

class CompanyPaths:  common {

    var AllPaths : RoutesDetails! = nil
    @IBOutlet weak var PathsTable: UITableView!
    @IBAction func Delete(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "هل تريد حذف المسار بالفعل" , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "لا أوافق", style: .default, handler: { action in
            }))
        alert.addAction(UIAlertAction(title: "موافق", style: .default, handler: { action in
            self.DeletePaths(self.AllPaths.trafficRoutes[(sender as! UIButton).tag].id!)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         loadingPaths()
    }
    fileprivate func DeletePaths(_ Id : Int){
         self.loading()
         let url = "https://services-apps.net/bstation/public/api/company/delete-traffic/\(Id)"
         let headers = [ "Content-Type": "application/json" ,
                        "Accept" : "application/json",
                        "Authorization" : "Bearer \(CashedData.getAdminApiKey() ?? "")"
        ]
        AlamofireRequests.PostMethod(methodType: "DELETE", url: url, info: [:], headers: headers){
            (error, success, jsonData) in
            do {
                self.stopAnimating()
                let decoder = JSONDecoder()
                if error == nil{
                    if success{
                            self.loadingPaths()
                            self.PathsTable.reloadData()
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
    fileprivate func loadingPaths(){
        self.loading()
        let url = "https://services-apps.net/bstation/public/api/companies/\(CashedData.getAdminID() ?? 0)"
        let headers = [ "Content-Type": "application/json" ,
                        "Accept" : "application/json",
                        "Authorization" : "Bearer \(CashedData.getAdminUpdateKey() ?? "")"
        ]
        AlamofireRequests.getMethod(url: url, headers: headers){
            (error, success, jsonData) in
            do {
                self.stopAnimating()
                let decoder = JSONDecoder()
                if error == nil{
                    if success{
                        let propertiesRecived = try decoder.decode(Paths.self, from: jsonData)
                        self.AllPaths = propertiesRecived.data
                        if self.AllPaths.trafficRoutes.count == 0{
                            self.present(common.makeAlert(message: "لا يوجد مسارات للشركه"), animated: true, completion: nil)
                        }
                        self.PathsTable.reloadData()
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



extension CompanyPaths:UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if AllPaths == nil{
            return 0
        }
        return AllPaths.trafficRoutes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Paths", for: indexPath) as! CompanyCell
        cell.air.isHidden = !AllPaths.trafficRoutes[indexPath.row].airConditioning
        cell.wifi.isHidden = !AllPaths.trafficRoutes[indexPath.row].wifi
        cell.shading.isHidden = !AllPaths.trafficRoutes[indexPath.row].shading
        cell.StartPoint.text = AllPaths.trafficRoutes[indexPath.row].fromStation
        cell.EndPoint.text = AllPaths.trafficRoutes[indexPath.row].toStation
        cell.phone.text = AllPaths.trafficRoutes[indexPath.row].phone
        cell.carModeling.text = "\(AllPaths.trafficRoutes[indexPath.row].carModel)-\(AllPaths.trafficRoutes[indexPath.row].carType)"
        cell.DeleteButton.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
