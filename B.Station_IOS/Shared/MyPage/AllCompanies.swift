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
    
    private final let stringWithLink = "Please download B.Station app here from Tamkeen Site: http://support@tamkeen-apps.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if search == true {
            setupBackButton()
            self.navigationItem.title =  "نتائج البحث"
            let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
            searchName.text = name
            searchPath.text = path
            SearchDetails.isHidden = false
        }else{
            self.navigationItem.title =   "شركات النقل"
            let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
            SearchDetails.isHidden = true
            loadingCompanies()
        }
    }
 
    @IBAction func shareAppAction(_ sender: UIButton) {
        let activityController = UIActivityViewController(activityItems: [stringWithLink], applicationActivities: nil)
        activityController.completionWithItemsHandler = { _, completed, _, _
            in
            if completed {
                print("completed")
            } else {
                print("canceled")
            }
        }
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            let activityVC: UIActivityViewController = UIActivityViewController(activityItems: [stringWithLink], applicationActivities: nil)
            
            // ios > 8.0
            if activityVC.responds(to: #selector(getter: UIViewController.popoverPresentationController)) {
                activityVC.popoverPresentationController?.sourceView = super.view
                
                //                activityVC.popoverPresentationController?.sourceRect = super.view.frame
            }
            present(activityVC, animated: true, completion: nil)
        } else {
            present(activityController, animated: true) {
                print("presented")
            }
        }
    }
    func setupBackButton() {
        self.navigationItem.hidesBackButton = true
        let backBtn: UIButton = common.drowbackButton()
        let backButton = UIBarButtonItem(customView: backBtn)
        self.navigationItem.setRightBarButton(backButton, animated: true)
        backBtn.addTarget(self, action: #selector(self.back), for: UIControl.Event.touchUpInside)
    }
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
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
        cell.companyImage.sd_setImage(with: URL(string:(AllCompanies[indexPath.row].imagePath ?? "") ) )
        cell.companyName.text = AllCompanies[indexPath.row].name
        cell.ratePercentage.text = "\(AllCompanies[indexPath.row].avgRate ?? 0)"
        cell.rateLevel.text = RatingLevel.Level(AllCompanies[indexPath.row].avgRate!)
        cell.rateView.rating = AllCompanies[indexPath.row].avgRate ?? 0
        cell.bio.text = AllCompanies[indexPath.row].bio
        cell.cityName.text = AllCompanies[indexPath.row].cityName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "CompanyPage", sender: self.AllCompanies[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CompanyPage"{
            
            if let destination = segue.destination as? MainProfile{
                destination.CompanyInfo = sender as! RoutesDetails?
            }
        }
    }
   
}
class RatingLevel{
    class func Level(_ avgRate : Double) -> String{
        switch avgRate {
        case 0.0...1.0:
            return "مقبول"
        case 1.1...2.0:
            return "جيد"
        case 2.1...3.0:
            return "جيد جدا"
        case 3.1...5.0:
            return "ممتاز"
        default:
            return "مقبول"
        }
    }
}
