//
//  Publisher+.swift
//
//
//  Created by Илья Шаповалов on 22.09.2023.
//

import Combine
import CoreGraphics
import Foundation

extension Publisher where Output == CGImage {
    func resize(for size: CGSize) -> Publishers.TryMap<Self, Output> {
        tryMap { cgImage in
            try ImageDownloader.resize(cgImage, for: size)
        }
    }
    
    func cacheImage(forUrl url: URL) -> Publishers.Map<Self, Output> {
        map { output in
            ImageCache.shared.setImage(output, forUrl: url)
            return output
        }
    }
}
