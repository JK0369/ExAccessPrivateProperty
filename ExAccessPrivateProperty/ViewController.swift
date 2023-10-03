//
//  ViewController.swift
//  ExAccessPrivateProperty
//
//  Created by 김종권 on 2023/10/03.
//

import UIKit

class SomeClass {
    private var name = "jake"
    private var age = 20
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let instance = SomeClass()
//        instance.name // 'name' is inaccessible due to 'private' protection level
        
        let mirror = Mirror(reflecting: instance)
        let name = mirror
            .children
            .first { label, _ in label == "name" }?
            .value
        
        let age = mirror
            .children
            .first { label, _ in label == "age" }?
            .value
        
        print(name, age) // "jake" 20
        
        print(mirror.property(name: "name"))
        print(mirror.property(name: "age"))
        print(property(instance: instance, propertyName: "name")) // "jake"
    }
}

extension Mirror {
    func property(name: String) -> Any? {
        children
            .first { label, _ in label == name }?
            .value
    }
}

func property(instance: Any, propertyName: String) -> Any? {
    Mirror(reflecting: instance)
        .property(name: propertyName)
}
