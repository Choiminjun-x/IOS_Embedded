//
//  SocketIO.swift
//  ios_Embedded
//
//  Created by 허예원 on 2021/08/29.
//

import UIKit
import SocketIO

class SocketIOManager: NSObject{
    static let shared = SocketIOManager()
    var manager = SocketManager(socketURL: URL(string: "http://localhost:9000")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    
    
    override init() {
        super.init()
        socket = self.manager.defaultSocket
//        socket = self.manager.socket(forNamespace: "/test")
//        socket.on("test") {
//            dataArray, ack in print(dataArray) }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func sendMessage(message: String){
        socket.emit("test", message)
    }
    
}
