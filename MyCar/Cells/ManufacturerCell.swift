//
//  ManufacturerCell.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 28/12/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import UIKit

class ICarElementCell: UITableViewCell {

    @IBOutlet weak var iCarElementNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configCell(with carElement: ICarElement, for index: Int) {
        iCarElementNameLabel.text = carElement.name
        self.setCellColor(for: index)
    }

    private func setCellColor(for index: Int) {
        switch index % 2 == 0 {
        case true:
            self.backgroundColor = UIColor.lightGray
        default:
            self.backgroundColor = UIColor.white
        }
    }


}
