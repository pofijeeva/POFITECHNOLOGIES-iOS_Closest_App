//
//  SampleTableViewController.swift
//  HomeStay
//
//  Created by Apple2 on 05/01/19.
//  Copyright © 2019 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class SampleTableViewController: UIViewController {
    
    @IBOutlet weak var samplecoll: UICollectionView!
    
    @IBOutlet weak var dateLbl: UILabel!
    
    var headerTit = [DateDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerTit = Singleton.sharedInstance.rootClass.dateDetails
        for i in 0..<headerTit.count {
            self.dateLbl.text = self.headerTit[i].timingFor
        }
        self.samplecoll.reloadData()
        
        // Do any additional setup after loading the view.
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
extension SampleTableViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  Singleton.sharedInstance.rootClass.dateDetails[0].tableDetails.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SampleCollectionViewCell", for: indexPath) as? SampleCollectionViewCell else { return UICollectionViewCell() }

//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SampleCollectionViewCell", for: indexPath) as? SampleCollectionViewCell
        
        cell.tabName.text = Singleton.sharedInstance.rootClass.dateDetails[0].tableDetails[indexPath.item].tableName
        cell.tabPrice.text = Singleton.sharedInstance.rootClass.dateDetails[0].tableDetails[indexPath.item].price ?? ""
        cell.tabTime.text = Singleton.sharedInstance.rootClass.dateDetails[0].tableDetails[indexPath.item].startTime
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        print("Row Number is:",indexPath.item)
        
        // self.present(cells!, animated: true, completion: nil)
    }
}
