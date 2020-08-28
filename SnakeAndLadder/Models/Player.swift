//
//  Player.swift
//  SnakeAndLadder
//
//  Created by Sudhanshu Sudhanshu on 28/08/20.
//

import UIKit

class Player: NSObject {
    private let name: String
    private let id: String
    
    init(name: String) {
        self.name = name
        self.id = name + UIDevice.current.identifierForVendor!.uuidString
    }
    
    public func getId() -> String {
        id
    }
    
    public func getName() -> String {
        name
    }
    
}
