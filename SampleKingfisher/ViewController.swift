//
//  ViewController.swift
//  
//  
//  Created by ji-no on 2023/11/04
//  
//

import UIKit
import Kingfisher
import KingfisherWebP

class ViewController: UIViewController {
    @IBOutlet weak var imageView: AnimatedImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let modifier = AnyModifier { request in
            var req = request
            req.addValue("image/webp */*", forHTTPHeaderField: "Accept")
            return req
        }
        
        KingfisherManager.shared.defaultOptions += [
          .processor(WebPProcessor.default),
          .cacheSerializer(WebPSerializer.default),
          .requestModifier(modifier)
        ]
        
        let url: URL = URL(string: "https://raw.githubusercontent.com/yeatse/KingfisherWebP/62de44f4c60a00c9efd70f58c4bd88b94a28e66d/Tests/Resources/heart.webp")!
//        let url: URL = URL(string: "https://i.pinimg.com/originals/f7/b3/db/f7b3db9036f64203f261a894b1c6333b.gif")!

        KingfisherManager.shared.downloader.downloadImage(with: url, options: KingfisherManager.shared.defaultOptions) { result in
            switch result {
            case .success(let value):
                let image = value.image
                self.imageView.image = image
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
//        imageView.kf.setImage(
//            with: url,
//            options: [
//                .processor(WebPProcessor.default),
//                .cacheSerializer(WebPSerializer.default)
//            ]
//        )
    }


}

