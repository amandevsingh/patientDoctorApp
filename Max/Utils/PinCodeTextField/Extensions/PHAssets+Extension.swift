//
//  PHAssets+Extension.swift
//  Max
//
//  Created by Ankit on 05/02/22.
//

import Foundation
import Photos
import UIKit

extension PHAsset {

    var pngData : Data? {
        var thumbnail = UIImage()
        let imageManager = PHCachingImageManager()
        imageManager.requestImage(for: self, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil, resultHandler: { image, _ in
            thumbnail = image!
        })
        return thumbnail.pngData()
    }
}


