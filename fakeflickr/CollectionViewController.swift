//
//  CollectionViewController.swift
//  fakeflickr
//
//  Created by karenpeng on 11/19/16.
//  Copyright © 2016 karenpeng. All rights reserved.
//

import Foundation
import UIKit

let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
let itemsPerRow: CGFloat = 3

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var photoUrls: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        let flickrService = FlickrService()
        flickrService.httpGet {
            (data, error) in
            self.photoUrls = flickrService.generatePhotoUrls(data: data)
            print(self.photoUrls)
            DispatchQueue.main.async(execute: { 
                self.collectionView?.reloadData()
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoUrls.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
      cell.backgroundColor = UIColor.black
        
      let url = URL(string: self.photoUrls[indexPath.row])
        
      do{
        let imageData = try Data(contentsOf: url!)
        let img = UIImage(data: imageData)
            
        guard let image = img else {
            return cell
      }
            
        let imgView = cell.viewWithTag(1) as! UIImageView
        imgView.image = img
            
      } catch {
        print(error)
      }

      return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath:
                        IndexPath) -> CGSize {
//        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//        let availableWidth = self.view.frame.width - paddingSpace
//        let widthPerItem = availableWidth / itemsPerRow
//        return CGSize(width: widthPerItem, height: widthPerItem)
        let width = collectionView.frame.width / 3 - 1
        return CGSize(width: width, height: width)
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//        return sectionInsets
//    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //return sectionInsets.left
        return 1.0
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        //return sectionInsets.left
        return 1.0
    }
}
