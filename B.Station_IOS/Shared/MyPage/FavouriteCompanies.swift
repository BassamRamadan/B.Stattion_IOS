//
//  TrashingController.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 1/19/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit
import SDWebImage
class FavouriteCompanies: UIViewController {
    var TrashingCompanies = [FavDetails]()
    @IBOutlet weak var TrashingTable: UITableView!
    
    @IBAction func StartPointClick(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        loadingCompanies()
    }
    fileprivate func loadingCompanies(){
        let url = "https://services-apps.net/bstation/public/api/user/favourite-list"
        let headers = [ "Content-Type": "application/json" ,
                        "Accept" : "application/json",
                        "Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvc2VydmljZXMtYXBwcy5uZXRcL2JzdGF0aW9uXC9wdWJsaWNcL2FwaVwvdXNlci1zaWdudXAiLCJpYXQiOjE1Nzk0NDQyNTcsIm5iZiI6MTU3OTQ0NDI1NywianRpIjoiMzNYZ1pKQU9MZUhDMHE4aCIsInN1YiI6MiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.Joj4p8wSxXzQRStV-wFKYppIw9uS0zTANu7570EzF_k"
        ]
        self.TrashingCompanies.removeAll()
        AlamofireRequests.getMethod(url: url, headers: headers){
            (error, success, jsonData) in
            do {
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
        cell.companyImage.sd_setImage(with: URL(string: TrashingCompanies[indexPath.row].ImagePath))
        cell.companyName.text = TrashingCompanies[indexPath.row].name
        cell.ratePercentage.text = "\(TrashingCompanies[indexPath.row].AvgRate)"
        cell.rateLevel.text = RatingLevel().Level(Double(TrashingCompanies[indexPath.row].AvgRate))
        cell.rateView.rating = Double(TrashingCompanies[indexPath.row].AvgRate)
        cell.cityName.text = TrashingCompanies[indexPath.row].CityName
        return cell
    }
    
}
