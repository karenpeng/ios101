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
    
    let flickrService = FlickrService()
    var photoUrls: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flickrService.httpGet {
            (data, error) in
            self.photoUrls = self.flickrService.generatePhotoUrls(data: data)
            print(self.photoUrls)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
      cell.backgroundColor = UIColor.black
        
      let url = URL(string: "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcT49md2-g0REsg7747eYEAtdaoo7nD6zGhao5rdY8E72RtV0VFc8Q")
        
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
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
