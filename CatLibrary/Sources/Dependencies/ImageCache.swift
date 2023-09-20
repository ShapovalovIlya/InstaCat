//
//  ImageCache.swift
//
//
//  Created by Илья Шаповалов on 20.09.2023.
//

import Foundation
import AppKit
import OSLog

public final class ImageCache {
    //MARK: - Public properties
    public static let shared = ImageCache()
    
    //MARK: - Private properties
    private let cache = NSCache<NSURL, NSImage>()
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: ImageCache.self)
    )
    
    //MARK: - init(_:)
    private init() {
        cache.countLimit = 30
    }
    
    //MARK: - Public methods
    public func setImage(_ image: NSImage, forUrl url: URL) {
        logger.debug("\(#function)")
        guard let nsurl = NSURL(string: url.absoluteString) else {
            return
        }
        cache.setObject(image, forKey: nsurl)
    }
    
    public func image(forUrl url: URL) -> NSImage? {
        guard 
            let nsurl = NSURL(string: url.absoluteString),
            let image = cache.object(forKey: nsurl)
        else {
            logger.debug("Unable to load image from cache")
            return nil
        }
        logger.debug("Load image from cache")
        return image
    }
}
