//
//  MainProfile.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 12/21/19.
//  Copyright © 2019 Bassam Ramadan. All rights reserved.
//

import UIKit
class MainProfile: UIViewController {
    @IBOutlet var PhotosCollection : UICollectionView!
    @IBOutlet var PhotosCollectionWidth : NSLayoutConstraint!
    
    
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

        // Do any additional setup after loading the view.
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var identifier : String = ""
        switch tableView {
            case PathsTableView:
              identifier = "PathsCell"
            default:
                identifier = "RatingsCell"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
     return cell
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
