//
//  CollectionViewController.swift
//  fakeflickr
//
//  Created by karenpeng on 11/19/16.
//  Copyright © 2016 karenpeng. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewController: UICollectionViewController {
    
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
        return 4
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
}
