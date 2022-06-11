//
//  ExperienceLanguageViewController.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 22/12/20.
//  Copyright © 2020 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ExperienceLanguageViewController: UIViewController,CommonListingSaveDelegate {

    
    @IBOutlet weak var BasicLbl: UILabel!
       @IBOutlet weak var StepsLbl: UILabel!
       @IBOutlet weak var BasicTextLbl: UILabel!
     @IBOutlet weak var LanguageCollection: UICollectionView!
    
     var ListingActivityDelegate: listingActivityProtocol!
    var SelectedArray : NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
 SharedsaveInstance.delegate = self
        
        self.BasicLbl.font = UIFont(name: SemiBoldFont, size: 18)
                  self.StepsLbl.font = UIFont(name: RegularFont, size: 14)
                   self.BasicTextLbl.font = UIFont(name: RegularFont, size: 14)
                  self.LanguageCollection.reloadData()
        // Do any additional setup after loading the view.
    }
    func ActasCommonSave()
      {
          if  SelectedArray.count == 0{
              self.showInformation(title: "Closest", message: "Successfully Added")
          }else{
              self.showInformation(title: "Closest", message: "Please add photo first")
          }
        print(self.SelectedArray)
           
      }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ExperienceLanguageViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
           return 10
           
           
           //return Singleton.sharedInstance.couponDetailsJson.couponDetails.count
      
   }
   
   // make a cell for each cell index path
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
       
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LanguageCollectionViewCell", for: indexPath as IndexPath) as! LanguageCollectionViewCell
    if self.SelectedArray.contains(indexPath.row) {
        cell.SelImg.image = UIImage(named: "checkbox-2")
    }else{
        cell.SelImg.image = UIImage(named: "tick-off")
    }
        cell.NameLbl.font = UIFont(name: RegularFont, size: 14)
       cell.NameLbl.text = "English"
       return cell
   }
   
   // MARK: - UICollectionViewDelegate protocol
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    if self.SelectedArray.contains(indexPath.row) {
        self.SelectedArray.remove(indexPath.row)
    }else{
        self.SelectedArray.add(indexPath.row)
    }
     
    self.LanguageCollection.reloadData()
       
       
   }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = 60
        let width = collectionView.frame.width/2
           return CGSize(width: 130, height: 60)
       }
   
}
