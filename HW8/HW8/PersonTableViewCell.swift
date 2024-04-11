//
//  PersonTableViewCell.swift
//  HW8
//
//  Created by Margarita Can on 9.04.2024.
//

import UIKit

final class PersonTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var lastNameLabel: UILabel!
    
    private var person: Person?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func configure (with person: Person) {
        nameLabel.text = person.name
        lastNameLabel.text = person.lastName
    }
    
}
