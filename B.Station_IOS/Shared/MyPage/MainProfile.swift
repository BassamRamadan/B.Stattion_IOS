//
//  MainProfile.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 12/21/19.
//  Copyright © 2019 Bassam Ramadan. All rights reserved.
//

import UIKit
import Cosmos
import SDWebImage
import Spring
class MainProfile: common {
    var backBtn : UIButton!
    var CompanyInfo : RoutesDetails?
    @IBOutlet var PhotosCollection : UICollectionView!
    @IBOutlet var PhotosCollectionWidth : NSLayoutConstraint!
    @IBOutlet weak var addRating: DesignableButton!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var TestData: UILabel!
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
    
    @IBAction func PathsClicked(_ sender : UIButton!){
        RatingsTableView.isHidden = true
        PathsTableView.isHidden = false
        RatingsButton.isHighlighted = true
        PathsButton.isHighlighted = false
        if CompanyInfo?.trafficRoutes.count ?? 0 > 0{
            TestData.isHidden = true
        }else{
            TestData.isHidden = false
            TestData.text = "لا يوجد مسارات بالشركة"
        }
        addRating.isHidden = true
    }
    @IBAction func RatingsClicked(_ sender : UIButton!){
        RatingsTableView.isHidden = false
        PathsTableView.isHidden = true
        RatingsButton.isHighlighted = false
        PathsButton.isHighlighted = true
        if CompanyInfo?.userRates.count ?? 0 > 0{
            TestData.isHidden = true
        }else{
            TestData.isHidden = false
            TestData.text = "لا يوجد تقييمات للشركة"
        }
        
        if AppDelegate.normalUser == true{
             addRating.isHidden = false
        }else{
             addRating.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if AppDelegate.normalUser == true{
            self.navigationItem.title =  "بروفيل الشركة"
            setupFavoriteButton()
            RatingsClicked(RatingsButton)
            setupValues()
            setTowImages()
        }else{
            self.navigationItem.title =   "صفحتي"
            loadingProfile()
        }
    }
    private func setupFavoriteButton(){
        self.navigationItem.hidesBackButton = true
        backBtn = common.drowFavButton()
        let backButton = UIBarButtonItem(customView: backBtn)
        self.navigationItem.setRightBarButton(backButton, animated: true)
        backBtn.addTarget(self, action: #selector(addFav), for: UIControl.Event.touchUpInside)
    }
    @objc func addFav(){
        if self.backBtn.imageView?.image == UIImage(named: "ic_fav_white"){
            AddToFavorite(CompanyInfo?.id ?? 0)
        }
     }
    fileprivate func setupValues(){
        CompanyName.text = CompanyInfo?.name
        CityName.text = CompanyInfo?.cityName
        bio.text = CompanyInfo?.bio
        RatePercentage.text = "\(CompanyInfo?.avgRate ?? 0)"
        CosmosRate.rating = CompanyInfo?.avgRate ?? 0.0
        RateLevel.text = RatingLevel.Level(CompanyInfo?.avgRate ?? 0.0)
    }
    fileprivate func setTowImages(){
        if CompanyInfo?.images.count ?? 0 >= 1{
            image1.sd_setImage(with: URL(string: self.CompanyInfo?.images[0].imagePath ?? ""))
        }
        if CompanyInfo?.images.count ?? 0 >= 2{
            image2.sd_setImage(with: URL(string: self.CompanyInfo?.images[1].imagePath ?? ""))
        }
    }
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.PathsTableHeight.constant = self.PathsTableView.contentSize.height
        self.RatingsTableHeight.constant = self.RatingsTableView.contentSize.height
      //  self.PhotosCollectionWidth.constant = self.PhotosCollection.contentSize.width
    }
    fileprivate func AddToFavorite(_ CompanyId : Int){
        self.loading()
        let url = "https://services-apps.net/bstation/public/api/user/add-to-favourite"
        let headers = [ "Content-Type": "application/json" ,
                        "Accept" : "application/json",
                        "Authorization" : "Bearer \(CashedData.getUserApiKey() ?? "")"
        ]
        let params = [
            "company_id":CompanyId
        ]
        AlamofireRequests.PostMethod(methodType: "POST", url: url, info: params, headers: headers){
            (error, success, jsonData) in
            do {
                self.stopAnimating()
                let decoder = JSONDecoder()
                if error == nil{
                    if success{
                         AppDelegate.addToFavourite = true
                         self.backBtn.setImage(UIImage(named: "ic_fav_white_active"), for: [])
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
    fileprivate func loadingProfile(){
        self.loading()
        let url = "https://services-apps.net/bstation/public/api/companies/\(CashedData.getAdminID() ?? 0)"
        let headers = [ "Content-Type": "application/json" ,
                        "Accept" : "application/json"
        ]
        AlamofireRequests.getMethod(url: url, headers: headers){
            (error, success, jsonData) in
            do {
                self.stopAnimating()
                let decoder = JSONDecoder()
                if error == nil{
                    if success{
                        let propertiesRecived = try decoder.decode(Paths.self, from: jsonData)
                        self.CompanyInfo = propertiesRecived.data
                        self.RatingsClicked(self.RatingsButton)
                        self.setupValues()
                        self.setTowImages()
                        self.PathsTableView.reloadData()
                        self.RatingsTableView.reloadData()
                        self.PhotosCollection.reloadData()
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
             cell.carModeling.text = "\(CompanyInfo?.trafficRoutes[indexPath.row].carModel ?? "") - \(CompanyInfo?.trafficRoutes[indexPath.row].carType ?? "")"
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
        return max((self.CompanyInfo?.images.count ?? 0)-2, 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: (collectionView.frame.width)/3, height:  collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photos", for: indexPath) as! CompanyImageCell
        cell.image.sd_setImage(with: URL(string: self.CompanyInfo?.images[indexPath.row+2].imagePath ?? ""))
        return cell
    }
}
