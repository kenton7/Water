//
//  IntentHandler.swift
//  AddingExtenstion
//
//  Created by Илья Кузнецов on 02.10.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
