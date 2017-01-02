//
//  CarViewController.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 01/01/2017.
//  Copyright © 2017 Ievgenii Iablonskyi. All rights reserved.
//

import UIKit

class CarViewController: UIViewController {

    var car: Car!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSelectedCarAlert()
    }

    func showSelectedCarAlert() {
        AlertPresenter.showAlert(withTitle: "You have selected:", andMessage: "\(car.manufacturer.name): \(car.model.name)")
    }

}
