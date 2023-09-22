//
//  NSImageView.swift
//
//
//  Created by Илья Шаповалов on 22.09.2023.
//

import AppKit
import Combine

public extension NSImageView {
    typealias Completion = Subscribers.Completion<Error>
    
    func image(
        for url: URL,
        completion: @escaping (Completion) -> Void
    ) -> AnyCancellable {
        ImageDownloader(imageView: self)
            .content(for: url)
            .map { NSImage(cgImage: $0, size: .zero) }
            .sink(receiveCompletion: completion) { image in
                self.image = image
            }
    }
}
