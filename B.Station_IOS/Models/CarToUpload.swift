//
//  CarToUpload.swift
//  Tourist-Guide
//
//  Created by mac on 11/30/19.
//  Copyright © 2019 Tamkeen. All rights reserved.
//

import Foundation
import UIKit

class CarToUplad {
    var name , model,passenger,dailyCost: String
    var image: UIImage?
    
    
    init(name: String, model: String,passenger: String, dailyCost: String,image: UIImage?) {
        self.name = name
        self.model = model
        self.passenger = passenger
        self.dailyCost = dailyCost
        self.image = image
    }
}
