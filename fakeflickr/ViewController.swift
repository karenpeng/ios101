//
//  ViewController.swift
//  fakeflickr
//
//  Created by karenpeng on 11/19/16.
//  Copyright © 2016 karenpeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let flickrService = FlickrService()
        flickrService.httpGet {
            (data, error) in
            let photosUrls = flickrService.generatePhotoUrls(data: data)
            let url = URL(string: photosUrls[0])
            do {
                let imageData = try Data(contentsOf: url!)
                let img = UIImage(data: imageData)

                guard let image = img else {
                    return
                }
                
                let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
                imgView.contentMode = .scaleAspectFit
                imgView.clipsToBounds = true
                imgView.image = img
                self.view.addSubview(imgView)

            } catch {
                print(error)
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

