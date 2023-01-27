//
//  ViewController.swift
//  FlickrApp
//
//  Created by Onur Duyar on 25.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad()  {
        super.viewDidLoad()
        
        label.isHidden = true
        view.backgroundColor = .white
        
        let photoResponse: PhotoResponse = PhotoResponse()
        
        photoResponse.fetchInterestingPhotos { [self] result in
            let currentElement = photoResponse.photos.randomElement()!
            label.isHidden = false
            label.text = currentElement.title
            label.textColor = .black
            image.load(url: (currentElement.remoteURL ) )
        }
    }
}


