//
//  ImageDownloader.swift
//
//
//  Created by Илья Шаповалов on 22.09.2023.
//

import AppKit
import CoreGraphics
import Combine

public struct ImageDownloader {
    private let imageView: NSImageView
    
    //MARK: - init(_:)
    init(imageView: NSImageView) {
        self.imageView = imageView
    }
    
    func content(for url: URL) -> AnyPublisher<CGImage, Error> {
        ImageCache.shared.image(forUrl: url)
            .throwingPublisher
            .catch { _ in cgImageTaskPublisher(for: url) }
            .cacheImage(forUrl: url)
            .resize(for: imageView.bounds.size)
            .eraseToAnyPublisher()
    }
    
    private func cgImageTaskPublisher(for url: URL) -> AnyPublisher<CGImage, Error> {
        Deferred {
            Future { promise in
                guard
                    let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
                    let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
                else {
                    promise(.failure(URLError(.badServerResponse)))
                    return
                }
                promise(.success(image))
            }
        }
        .eraseToAnyPublisher()
    }
    
    //MARK: - resize(_:for:) throws -> CGImage
    static func resize(_ cgImage: CGImage, for size: CGSize) throws -> CGImage {
        guard let context = makeContext(from: cgImage, in: size) else {
            throw CocoaError(.coderInvalidValue)
        }
        context.draw(
            cgImage,
            in: .init(origin: .zero, size: size)
        )
        
        guard let scaled = context.makeImage() else {
            throw CocoaError(.fileNoSuchFile)
        }
        return scaled
    }
    
    //MARK: - makeContext(from:in:) -> CGContext?
    private static func makeContext(from cgImage: CGImage, in size: CGSize) -> CGContext? {
        let context = CGContext(
            data: nil,
            width: size.width.toInt,
            height: size.height.toInt,
            bitsPerComponent: cgImage.bitsPerComponent,
            bytesPerRow: 0,
            space: cgImage.colorSpace ?? CGColorSpace(name: CGColorSpace.sRGB)!,
            bitmapInfo: cgImage.bitmapInfo.rawValue
        )
        context?.interpolationQuality = .high
        return context
    }
    
}
