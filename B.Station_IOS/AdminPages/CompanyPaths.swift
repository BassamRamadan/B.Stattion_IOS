//
//  CompanyPaths.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 1/20/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit

class CompanyPaths: UIViewController {

    var AllPaths : RoutesDetails! = nil
    @IBOutlet weak var PathsTable: UITableView!
    @IBAction func Delete(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingPaths()
    }
    fileprivate func loadingPaths(){
        let url = "https://services-apps.net/bstation/public/api/company/profile"
        let headers = [ "Content-Type": "application/json" ,
                        "Accept" : "application/json",
                        "Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvc2VydmljZXMtYXBwcy5uZXRcL2JzdGF0aW9uXC9wdWJsaWNcL2FwaVwvY29tcGFueS1sb2dpbiIsImlhdCI6MTU3OTQ3NDY0NywibmJmIjoxNTc5NDc0NjQ3LCJqdGkiOiJFNGJiUHh4OEtoNUhQU0FrIiwic3ViIjoxNiwicHJ2IjoiY2ZlN2VjOTlhMjNmNDM4OGU3ZjFkNWZiODcwODM3NWM4NTRlZGE2NCJ9.bBry3A30zjn9IFmqZQcjdkqIdLKGJGma6J82Szw4nk0"
        ]
        AlamofireRequests.getMethod(url: url, headers: headers){
            (error, success, jsonData) in
            do {
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
        return cell
    }
    
    
}
