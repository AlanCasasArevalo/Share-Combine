//
//  MainViewController.swift
//  Share
//
//  Created by Alan Casas on 24/09/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import UIKit
import RxSwift

class MainViewController: UIViewController {

    let stream = PublishSubject<Double>()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let heavyCalc = stream
            .do(onNext: { _ in
                print("heavy calc")
            })
            .map {
                $0 * .pi / 180
            }
            .share()
        
        heavyCalc
            .map {
                "\($0)"
            }
            .subscribe(onNext: { rad in
                print("subscribe #1: \(rad)")
            })
            .disposed(by: disposeBag)
        
        heavyCalc
            .map {
                Int($0)
            }
            .map {
                "\($0)"
            }
            .subscribe(onNext: { rad in
                print("subscribe #2: \(rad)")
            })
            .disposed(by: disposeBag)
        
        heavyCalc
            .map {
                "\($0)"
            }
            .subscribe(onNext: { rad in
                print("-----------------")
            })
            .disposed(by: disposeBag)

    }


    @IBAction func buttonPressed(_ sender: Any) {
        
        let randomDegree = (0...360).randomElement() ?? 0
        stream.onNext(Double(randomDegree))
        
    }
    
}
