//
//  ElementShadow.swift
//  B.Station_IOS
//
//  Created by Bassam Ramadan on 12/3/19.
//  Copyright © 2019 Bassam Ramadan. All rights reserved.
//

import UIKit

class registerView : UIView{
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shadowRadius = 5
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
}
