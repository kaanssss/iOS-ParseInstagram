//
//  FeedCellTableViewCell.swift
//  ParseInstaClone
//
//  Created by Kaan Yalçınkaya on 14.02.2022.
//

import UIKit
import Parse

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var postImage: UIImageView!
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var postUUIDLabel: UILabel!
    
    @IBOutlet weak var postCommentText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        postUUIDLabel.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeClicked(_ sender: Any) {
        
        let likeObjects = PFObject(className: "Likes")
        likeObjects["from"] = PFUser.current()!.username //Güncel kim tıklıyorsa ondan gidecek.
        likeObjects["to"] = postUUIDLabel.text //Nereden alacağımızı belirtmemiz gerekiyor. UUID kısmını bu sebepten dolayı oluşturduk.
        
        likeObjects.saveInBackground { sucess, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
            else {
                print("saved")
            }
        }
        
    }
    
    @IBAction func commentClicked(_ sender: Any) {
        let commentObject = PFObject(className: "Comments")
        commentObject["from"] = PFUser.current()!.username //Güncel kim tıklıyorsa ondan gidecek.
        commentObject["to"] = postUUIDLabel.text //Nereden alacağımızı belirtmemiz gerekiyor. UUID kısmını bu sebepten dolayı oluşturduk.
        
        commentObject.saveInBackground { sucess, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
            else {
                print("saved")
            }
        }
        
    }
    
}
