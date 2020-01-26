//
//  Created by Hassan Ramadan on 9/21/19.
//  Copyright © 2019 Hassan Ramadan IOS/Android Developer Tamkeen CO. All rights reserved.
//

import UIKit
import SDWebImage
class AboutUsViewController: common {

    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var socialLinks: [SocialLinksDetails]?
    var aboutData: AboutUSDataDetails?
    override func viewDidLoad() {
     
        self.navigationItem.title = "حول التطبيق"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        super.viewDidLoad()
        common.setNavigationShadow(navigationController: self.navigationController)
        self.tabBarController?.tabBar.isHidden = false
        getAboutData()
        getLinksData()
    
    }
    
    fileprivate func getAboutData(){
        self.loading()
         let url = "https://services-apps.net/bstation/public/api/aboutus"
        let headers = [
            "Content-Type": "application/json" ,
                    "Accept" : "application/json",]
        AlamofireRequests.getMethod(url: url, headers: headers) { (error, success, jsonData) in
            do {
                self.stopAnimating()
                let decoder = JSONDecoder()
                if success {
                    let dataReceived = try decoder.decode(AboutUS.self, from: jsonData)
                    self.aboutData = dataReceived.data
                    self.content.text = self.aboutData?.content
                }else{
                    let alert = UIAlertController(title: "تنبيه", message: "عفوا حدث خطأ في الاتصال من فضلك حاول مره آخري" , preferredStyle: UIAlertController.Style.alert)
                    self.present(alert, animated: true, completion: nil)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        switch action.style{
                        case .default ,.destructive ,.cancel:
                            self.getAboutData()
                        @unknown default:
                            self.getAboutData()
                        }}))
                }
                
            } catch {
                let alert = common.makeAlert()
                self.present(alert, animated: true, completion: nil)
                print(error.localizedDescription)
            }
            
        }
    }
    
    fileprivate func getLinksData(){
        self.loading()
        let url = "https://services-apps.net/bstation/public/api/social-links"
        let headers = [
            "Content-Type": "application/json" ,
            "Accept" : "application/json"
        ]
        AlamofireRequests.getMethod(url: url, headers: headers) { (error, success, jsonData) in
            do {
                self.stopAnimating()
                let decoder = JSONDecoder()
                if success{
                    let dataReceived = try decoder.decode(SocialLinks.self, from: jsonData)
                    self.socialLinks = dataReceived.data
                    self.collectionView.reloadData()
                }else{
                    let alert = UIAlertController(title: "تنبيه", message: "عفوا حدث خطأ في الاتصال من فضلك حاول مره آخري" , preferredStyle: UIAlertController.Style.alert)
                    self.present(alert, animated: true, completion: nil)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        switch action.style{
                        case .default ,.destructive ,.cancel:
                            self.getLinksData()
                        @unknown default:
                            self.getLinksData()
                        }}))
                }
                
            } catch {
                let alert = common.makeAlert()
                self.present(alert, animated: true, completion: nil)
                print(error.localizedDescription)
            }
            
        }
    }
        
    
    fileprivate func setupShadowViewtop(){
        common.setNavigationShadow(navigationController: self.navigationController)
    }
}
extension AboutUsViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.socialLinks?.count ?? 0
    }
    @objc func Link(sender : UIButton){
        let links : String = sender.titleLabel!.text!
        UIApplication.shared.open(URL(string: links)!, options: [:], completionHandler: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellCount : Int = collectionView.numberOfItems(inSection: section)*50
        let spac : Int = (collectionView.numberOfItems(inSection: section)-1)*10
        let rem : Int = Int(collectionView.frame.width) - (cellCount + spac)
        var r : CGFloat = CGFloat(rem/2)
        if r < 5 {
            r = 5
        }
        return UIEdgeInsets(top: 0, left: r, bottom: 0, right: r)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AboutUS", for: indexPath) as! SocialCell

        AlamofireRequests.getPhoto(url: self.socialLinks![indexPath.row].icon ?? "") { (error , success, image ) in
            cell.link.setBackgroundImage(image, for: .normal)
        }
        cell.link.titleLabel?.text = self.socialLinks?[indexPath.row].link
        cell.link.addTarget(self, action: #selector(Link(sender:)), for: .touchUpInside)
        return cell
    }
    
}
