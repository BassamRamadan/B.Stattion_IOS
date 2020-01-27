//
//  CompanyCell.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 1/18/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit
import Cosmos
class CompanyCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyImage : UIImageView!
    @IBOutlet weak var carModeling: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var ratePercentage: UILabel!
    @IBOutlet weak var rateLevel: UILabel!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var air: UIStackView!
    @IBOutlet weak var shading: UIStackView!
    @IBOutlet weak var wifi: UIStackView!
    @IBOutlet weak var path: UIStackView!
    @IBOutlet weak var StartPoint: UILabel!
    @IBOutlet weak var EndPoint: UILabel!
    @IBOutlet weak var DeleteButton: UIButton!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var ShareButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
