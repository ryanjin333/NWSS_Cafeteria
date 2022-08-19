//
//  HomeTableViewCell.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-05.
//

import UIKit
import FirebaseDatabase


class HomeTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.init(name: "Avenir-Medium", size: 15)
        return label
    }()
    
    let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
 
   let homeControllerVariables = HomeControllerVariables()

    
    
    func set(indexPath: IndexPath) {
        //Home Table View Cell Initialization
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(itemImageView)
        
        //Home Table View Cell Label Attributes
        let ref = Database.database().reference()
        ref.child(homeControllerVariables.menuName).observe(.value, with: { snapshot in
            var i = 0
            for child in snapshot.children {
                if (i == indexPath.row) {
                    guard let child = child as? DataSnapshot else { return }
                    HomeTitleTableList.cellLabels.insert(child.key, at: indexPath.row)
                    self.titleLabel.text = HomeTitleTableList.cellLabels[indexPath.row]
                    break
                }
                i += 1
            }
          })
        itemImageView.image = UIImage(named: "burger")
        
        //Home Table View Cell Constraints
        titleLabel.addConstraint(top: self.contentView.topAnchor, left: itemImageView.rightAnchor, right: nil, bottom: nil, paddingTop: 25, paddingLeft: 20, paddingRight: 0, paddingBottom: 0, width: 175, height: 30)
        itemImageView.addConstraint(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, right: nil, bottom: nil, paddingTop: 5, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: 70, height: 70)
    }
    
}
