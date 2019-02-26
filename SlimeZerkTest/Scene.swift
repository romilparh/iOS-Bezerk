//
//  Scene.swift
//  SlimeZerkTest
//
//  Created by Romil Parhwal on 2019-02-26.
//  Copyright © 2019 Parrot. All rights reserved.
//

import Foundation

class Scene{
    var scene: Bool
    
    init(){
        self.scene = false
    }
    
    func changeBool(){
        if(self.scene){
            self.scene = false
        } else{
            self.scene = true
        }
    }
    
}

var sceneSelector: Scene = Scene()
