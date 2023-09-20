//
//  Publisher+.swift
//  
//
//  Created by Илья Шаповалов on 21.09.2023.
//

import Combine
import AppKit

public extension Publisher where Output == NSImage {
    func cache(forUrl url: URL) -> Publishers.Map<Self, Output> {
        map { output in
            ImageCache.shared.setImage(output, forUrl: url)
            return output
        }
    }
}
