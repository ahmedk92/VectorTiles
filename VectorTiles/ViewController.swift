//
//  ViewController.swift
//  VectorTiles
//
//  Created by Ahmed Khalaf on 3/13/20.
//  Copyright © 2020 io.github.ahmedkhalaf. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - UIScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        tiledView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        tiledView.contentScaleFactor = UIScreen.main.scale * scale
        tiledView.setNeedsDisplay()
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        overrideUserInterfaceStyle = .light
        
        strings.forEach {
            let attributedString = NSAttributedString(string: $0, attributes: [
                .font: UIFont.systemFont(ofSize: CGFloat((8...32).randomElement()!)),
                .foregroundColor: UIColor.random
            ])
            
            let size = attributedString.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: .greatestFiniteMagnitude), options: [.usesFontLeading, .usesLineFragmentOrigin], context: nil).size
            
            let rect = CGRect(
                x: CGFloat((0...2000-Int(size.width)).randomElement()!),
                y: CGFloat((0...2000-Int(size.height)).randomElement()!),
                width: size.width,
                height: size.height
            )
                        
            self.tiledView.add(drawable: BlockDrawable(rect: rect) { _ in                
                attributedString.draw(in: rect)
            })
        }
    }
    
    // MARK: - Private
    @IBOutlet private weak var tiledView: TiledView!
    @IBOutlet private weak var scrollView: UIScrollView!
    private let strings = ["Ahmed", "Mohammed", "Ali", "Kamal", "Adam"].repeating(times: 100)
}

extension UIColor {
    static var random: UIColor {
        func randomComponent() -> CGFloat {
            CGFloat((0...255).randomElement()!) / 255
        }
                
        return UIColor(displayP3Red: randomComponent(), green: randomComponent(), blue: randomComponent(), alpha: 1)
    }
}

extension Array {
    func repeating(times: Int) -> Self {
        var newArray = Array()
        newArray.reserveCapacity(count * times)
        for i in 0..<newArray.capacity {
            newArray.append(self[i % count])
        }
        return newArray
    }
}
