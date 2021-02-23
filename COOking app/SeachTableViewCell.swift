//
//  SeachTableViewCell.swift
//  COOking app
//
//  Created by 井上げんき on 2020/11/11.
//

import UIKit

//これからボタンを押された時はViewContrllerに任せておきたいからprotocol使う

protocol SearchTableViewCelldelegate {
    func didTabfollowButton(tableViewCell: UITableViewCell, button: UIButton)
}

class SeachTableViewCell: UITableViewCell {
    //delegateを宣言しておく
    var delegate: SearchTableViewCelldelegate?
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var followButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //押した時の情報がIBActionでは通るのでこういう風にして引数にして渡してあげる
    @IBAction func follow(button: UIButton) {
        self.delegate?.didTabfollowButton(tableViewCell: self, button: button)
        
    }
    
}
