//
//  TiledView.swift
//  VectorTiles
//
//  Created by Ahmed Khalaf on 3/13/20.
//  Copyright © 2020 io.github.ahmedkhalaf. All rights reserved.
//

import UIKit

class TiledView: UIView {
    // MARK: - API
    func add(drawable: Drawable) {
        drawables.append(drawable)
        setNeedsDisplay()
    }
    // MARK: - Ovverides
    override class var layerClass: AnyClass { CATiledLayer.self }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let drawables = self.drawables.filter({ $0.rect.intersects(rect) })
        drawables.forEach({ $0.draw(in: context) })
    }
    
    // MARK: - Private
    private var drawables: [Drawable] = []
}
