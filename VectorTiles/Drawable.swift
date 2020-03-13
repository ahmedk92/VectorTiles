//
//  Drawable.swift
//  VectorTiles
//
//  Created by Ahmed Khalaf on 3/13/20.
//  Copyright © 2020 io.github.ahmedkhalaf. All rights reserved.
//
import UIKit

protocol Drawable {
    func draw(in context: CGContext)
    var rect: CGRect { get }
}

struct BlockDrawable: Drawable {
    var rect: CGRect
    var drawingBlock: (CGContext) -> Void
    
    func draw(in context: CGContext) {
        drawingBlock(context)
    }
}
