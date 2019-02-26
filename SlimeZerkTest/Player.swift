//
//  Player.swift
//  SlimeZerkTest
//
//  Created by Romil Parhwal on 2019-02-26.
//  Copyright © 2019 Parrot. All rights reserved.
//

import Foundation

class Player{
    var lives: Int
    var score: Int
    
    init(){
        self.lives = 3
        self.score = 0
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
    
    func increaseScore(){
        self.score = self.score + 1
    }
    
    func returnScore()->Int{
        return self.score
    }
}

var playerObject:Player = Player()
