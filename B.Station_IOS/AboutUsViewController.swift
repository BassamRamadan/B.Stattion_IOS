//
//  Created by Hassan Ramadan on 9/21/19.
//  Copyright © 2019 Hassan Ramadan IOS/Android Developer Tamkeen CO. All rights reserved.
//

import UIKit



class AboutUsViewController: UIViewController {

    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var socialLinks: [SocialLinksDatum]?
    var aboutData: AboutUSDataClass?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        common.setNavigationShadow(navigationController: self.navigationController)
        self.tabBarController?.tabBar.isHidden = false
        getAboutData()
        getLinksData()
    
    }
    
    fileprivate func getAboutData(){
        
        let headers = [
            "Content-Type": "application/json" ,
                    "Accept" : "application/json",]
        AlamofireRequests.getMethod(url: "https://salonatcom-app.com/mobile-app/api/aboutus", headers: headers) { (error, success, jsonData) in
            do {
                let decoder = JSONDecoder()
                let dataReceived = try decoder.decode(AboutUS.self, from: jsonData)
                if dataReceived.code == 200{
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
                print(error.localizedDescription)
            }
            
        }
    }
    
    fileprivate func getLinksData(){
        
        let headers = [
            "Content-Type": "application/json" ,
            "Accept" : "application/json",]
        AlamofireRequests.getMethod(url: "https://salonatcom-app.com/mobile-app/api/links", headers: headers) { (error, success, jsonData) in
            do {
                let decoder = JSONDecoder()
                let dataReceived = try decoder.decode(SocialLinks.self, from: jsonData)
                if dataReceived.code == 200{
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
                print(error.localizedDescription)
            }
            
        }
    }
        
    func setupBackButton(){
        self.navigationItem.hidesBackButton = true
        let backBtn: UIButton = common.drowbackButton()
        let backButton = UIBarButtonItem(customView: backBtn)
        self.navigationItem.setRightBarButton(backButton, animated: true)
        backBtn.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
    }
    @objc func back(){
        print("accessed")
        common.openback(sender: self.navigationController!)
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
        
        AlamofireRequests.getPhoto(url: self.socialLinks?[indexPath.row].icon ?? "") { (error , success, image ) in
            cell.link.setBackgroundImage(image, for: .normal)
            
        }
        cell.link.titleLabel?.text = self.socialLinks?[indexPath.row].link
        cell.link.addTarget(self, action: #selector(Link(sender:)), for: .touchUpInside)
        return cell
    }
    
}
