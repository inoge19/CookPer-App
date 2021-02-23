//
//  TimelineTableViewCell.swift
//  COOking app
//
//  Created by 井上げんき on 2020/11/07.
//

import UIKit
protocol TimelineTableViewCellDelegate {
    func didTapLikeButton(tableViewCell: UITableViewCell, button: UIButton)
    func didTapMenuButton(tableViewCell: UITableViewCell, button: UIButton)
}





class TimelineTableViewCell: UITableViewCell {
    
    var delegate : TimelineTableViewCellDelegate?
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var likeCountLabel: UILabel!
    @IBOutlet var timeStampLabel: UILabel!
    @IBOutlet var TextFiled1: UITextField!
    @IBOutlet var TextFiled2: UITextField!
    @IBOutlet var TextFiled3: UITextField!
    @IBOutlet var TextFiled4: UITextField!
    @IBOutlet var TextFiled5: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
       
        //アイコンを丸くするコード
        userImageView.layer.cornerRadius = userImageView.bounds.width / 2.0
        userImageView.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func like(button: UIButton) {
            self.delegate?.didTapLikeButton(tableViewCell: self, button: button)
        }

        @IBAction func openMenu(button: UIButton) {
            self.delegate?.didTapMenuButton(tableViewCell: self, button: button)
        }

       
    
    
}
