//
//  PostCell.swift
//  DemoApp
//
//  Created by Ashmika Gujarathi on 12/11/19.
//  Copyright © 2019 Ashmika. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    
    @IBOutlet weak var lblPostTitle: UILabel!
    
    @IBOutlet weak var lblCreatedAt: UILabel!
    
    @IBOutlet weak var lblAuthor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
