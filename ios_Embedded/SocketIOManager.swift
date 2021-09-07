//
//  SocketIOManager.swift
//  httptest
//
//  Created by 허예원 on 2021/07/24.
//

import UIKit
import SocketIO

class SocketIOManager: NSObject {
    static let shared = SocketIOManager()
    var manager = SocketManager(socketURL: URL(string: "http://192.168.35.167:9000")!, config: [.log(true), .compress])
    //var manager = SocketManager(socketURL: URL(string: "http://localhost:9000")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    
    override init() {
        super.init()
        socket = self.manager.defaultSocket

    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func sendMessage(socketMessage: String, message: String) {
        socket.emit(socketMessage, message)
    }

}
