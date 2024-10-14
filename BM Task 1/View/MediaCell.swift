//
//  MediaCell.swift
//  BM Task 1
//
//  Created by Apple on 23/07/2024.
//

import UIKit


class MediaCell: UITableViewCell {

    @IBOutlet weak var imgCell: UIImageView!
    
    @IBOutlet weak var labelCell: UILabel!
    
   
    @IBOutlet weak var avgLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgCell.layer.cornerRadius = imgCell.frame.size.width / 7
        imgCell.layer.borderWidth = 1
        imgCell.layer.borderColor = UIColor(named: "Second_Color")?.cgColor
        imgCell.clipsToBounds = true

        labelCell.layer.shadowColor = UIColor.black.cgColor
        labelCell.layer.shadowRadius =  3.0
        labelCell.layer.shadowOpacity = 0.75
        labelCell.layer.shadowOffset = CGSize(width: 4, height: 4)
        labelCell.layer.masksToBounds = false
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    func configureCell(media: TVShowsResponse) {
            if let imageUrl = URL(string: media.show.image?.medium ?? "") {
                self.imgCell.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "Subject 2"))
            }
            
            self.labelCell.text = media.show.name
            
        if let rating = media.show.rating?.average {
            self.avgLabel.text = "Rating: \(rating)"
        }else {
            self.avgLabel.text = "Rating: none"
        }
        
        }
    
    
}
