//
//  MainProfile.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 12/21/19.
//  Copyright © 2019 Bassam Ramadan. All rights reserved.
//

import UIKit
import Cosmos
class MainProfile: UIViewController {
    var CompanyInfo : RoutesDetails?
    @IBOutlet var PhotosCollection : UICollectionView!
    @IBOutlet var PhotosCollectionWidth : NSLayoutConstraint!
    
    @IBOutlet weak var CityName: UILabel!
    @IBOutlet weak var CompanyName: UILabel!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var CosmosRate: CosmosView!
    
    @IBAction func WhatsuppCall(_ sender: Any) {
    }
    @IBAction func PhoneCall(_ sender: Any) {
    }
    @IBOutlet weak var RatePercentage: UILabel!
    @IBOutlet weak var RateLevel: UILabel!
    @IBOutlet var PathsTableView : UITableView!
    @IBOutlet var RatingsTableView : UITableView!
    @IBOutlet var PathsTableHeight : NSLayoutConstraint!
    @IBOutlet var RatingsTableHeight : NSLayoutConstraint!
    
    @IBOutlet var PathsButton : UIButton!
    @IBOutlet var RatingsButton : UIButton!
    
    @IBAction func PathsClicked(_ sender : UIButton){
        RatingsTableView.isHidden = true
        PathsTableView.isHidden = false
        
        RatingsButton.titleLabel?.textColor = UIColor.init(named: "gray text")
        PathsButton.titleLabel?.textColor = UIColor.init(named: "dark text")
    }
    @IBAction func RatingsClicked(_ sender : UIButton){
        RatingsTableView.isHidden = false
        PathsTableView.isHidden = true
        
        PathsButton.titleLabel?.textColor = UIColor.init(named: "gray text")
        RatingsButton.titleLabel?.textColor = UIColor.init(named: "dark text")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.RatingsClicked(RatingsButton)
        
        setupValues()
    }
    fileprivate func setupValues(){
        CompanyName.text = CompanyInfo?.name
        CityName.text = CompanyInfo?.cityName
        bio.text = CompanyInfo?.bio
        RatePercentage.text = "\(CompanyInfo?.avgRate ?? 0)"
        CosmosRate.rating = CompanyInfo?.avgRate ?? 0.0
        RateLevel.text = RatingLevel.Level(CompanyInfo?.avgRate ?? 0.0)
    }
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.PathsTableHeight.constant = self.PathsTableView.contentSize.height
        self.RatingsTableHeight.constant = self.RatingsTableView.contentSize.height
      //  self.PhotosCollectionWidth.constant = self.PhotosCollection.contentSize.width
    }

}

extension MainProfile : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case PathsTableView:
            return self.CompanyInfo?.trafficRoutes.count ?? 0
        default:
            return self.CompanyInfo?.userRates.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch tableView {
            case PathsTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PathsCell", for: indexPath) as! CompanyCell
             cell.air.isHidden = !(CompanyInfo?.trafficRoutes[indexPath.row].airConditioning ?? false)
             cell.wifi.isHidden = !(CompanyInfo?.trafficRoutes[indexPath.row].wifi ?? false)
             cell.shading.isHidden = !(CompanyInfo?.trafficRoutes[indexPath.row].shading ?? false)
             cell.StartPoint.text = CompanyInfo?.trafficRoutes[indexPath.row].fromStation
             cell.EndPoint.text = CompanyInfo?.trafficRoutes[indexPath.row].toStation
            cell.carModeling.text = "\(CompanyInfo?.trafficRoutes[indexPath.row].carModel) - \(CompanyInfo?.trafficRoutes[indexPath.row].carType)"
              return cell
            default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RatingsCell", for: indexPath) as! CompanyCell
            cell.name.text = CompanyInfo?.userRates[indexPath.row].userName
            cell.comment.text = CompanyInfo?.userRates[indexPath.row].comment
            cell.rateView.rating = Double(CompanyInfo?.userRates[indexPath.row].rate ?? "0.0") as! Double
            cell.ratePercentage.text = CompanyInfo?.userRates[indexPath.row].rate ?? "0.0"
            cell.Date.text = CompanyInfo?.userRates[indexPath.row].createdAt
              return cell
        }
        
    
   
    }
}
extension MainProfile : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photos", for: indexPath)
        cell.backgroundColor = UIColor.init(named: "dark light")
        return cell
    }
}
