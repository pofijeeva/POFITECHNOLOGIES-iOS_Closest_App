//
//  DetailPageReviewsCollectionViewCell.swift
//  HomeStay
//
//  Created by Apple7 on 11/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class DetailPageReviewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var Baseview: UIView!
    @IBOutlet weak var ReviewImg: UIImageView!
    @IBOutlet weak var ReviewMsg: UILabel!
    @IBOutlet weak var ReviewerName: UILabel!

    @IBOutlet weak var ReviewDate: UILabel!
    @IBOutlet weak var RatingView: FloatRatingView!
    @IBOutlet weak var ReviewBaseViewHeight: NSLayoutConstraint!


}
