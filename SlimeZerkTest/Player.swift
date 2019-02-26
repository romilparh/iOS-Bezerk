//
//  Player.swift
//  SlimeZerkTest
//
//  Created by Romil Parhwal on 2019-02-26.
//  Copyright © 2019 Parrot. All rights reserved.
//

import Foundation

class Player{
    var lives: Int;
    
    init(){
        self.lives = 3
    }
    
    func reduceLives(){
        self.lives = self.lives - 1
    }
    
    func returnLives() -> Int {
        return self.lives
    }
    func resetLives(){
        self.lives = 3
    }
}

var playerObject:Player = Player()
