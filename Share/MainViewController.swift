//
//  MainViewController.swift
//  Share
//
//  Created by Alan Casas on 24/09/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import UIKit
import Combine

@available(iOS 13.0, *)
class MainViewController: UIViewController {

    let stream = PassthroughSubject<Double, Never>()
    var cancels: [Cancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let heavyCalc = stream
            .handleEvents( receiveOutput: { _ in
                print("heavy Calc")
            })
            .map {
                $0 * .pi / 180
            }
            .share()
        
        let cancelable1 = heavyCalc
            .map {
                "\($0)"
            }
            .sink(receiveValue: { rad in
                print("receiveValue #1: \(rad)")
            })
            cancels.append(cancelable1)
        
        let cancelable2 = heavyCalc
            .map {
                Int($0)
            }
            .map {
                "\($0)"
            }
            .sink(receiveValue: { rad in
                print("receiveValue #2: \(rad)")
            })
            cancels.append(cancelable2)
        
        let cancelable3 = heavyCalc
            .sink(receiveValue: { _ in
                print("------------")
            })
            cancels.append(cancelable3)

    }


    @IBAction func buttonPressed(_ sender: Any) {
        
        let randomDegree = (0...360).randomElement() ?? 0
        stream.send(Double(randomDegree))
        
    }
    
}
