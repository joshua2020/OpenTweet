//
//  ImageHealper.swift
//  NotTwitter
//
//  Created by Joshua on 11/12/2022.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    var task: URLSessionDataTask!
    let spinner = UIActivityIndicatorView(style: .medium)

    func loadImage(from url: URL) {
        image = nil
        addSpinner()
        
        if let task = task {
        task.cancel()
        }
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            image = imageFromCache
            removeSpinner()
            return
        }
        
        task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let newImage = UIImage(data: data)
            else  {
                print("Could not load image from URL: \(url)")
                return
            }

            imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            DispatchQueue.main.async {
                self.image = newImage
                self.removeSpinner()
            }
        }
        task.resume()
    }

    func addSpinner() {
        addSubview(spinner)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        spinner.startAnimating()
    }

    func removeSpinner() {
        spinner.stopAnimating()
        spinner.removeFromSuperview()
    }
}


protocol ParallaxEffectDelegate {
   func  applyParallaxEffect(onView: UIView, magnitude: Int)
}

extension ParallaxEffectDelegate {
    func applyParallaxEffect(onView: UIView, magnitude: Int) {
        let xAxisEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xAxisEffect.minimumRelativeValue = -magnitude
        xAxisEffect.maximumRelativeValue = magnitude
        
        let yAxisEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yAxisEffect.minimumRelativeValue = -magnitude
        yAxisEffect.maximumRelativeValue = magnitude
        
        let effectGroup = UIMotionEffectGroup()
        effectGroup.motionEffects = [xAxisEffect, yAxisEffect]
        
        onView.addMotionEffect(effectGroup)
    }
}
