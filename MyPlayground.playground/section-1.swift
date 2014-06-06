// Playground - noun: a place where people can play

import UIKit


var dictionary = NSDictionary(objects: [ NSDictionary(objects: [ "222" ], forKeys: [ "temp" ]) ], forKeys: [ "main" ])

var dictionary2 = [ "main" : [ "temp" : "223" ] ]

dictionary.valueForKeyPath("main.temp")

let foo : Dictionary! = dictionary2["main"]

let bar = foo["temp"]



dictionary2.bridgeToObjectiveC().valueForKeyPath("main.temp")

for _ in 1..10 {
    var thing = "test"
}


