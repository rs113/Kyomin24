//
//  SocketManager.swift
//  SSNodeJsChat
//
//  Created by Emizen Tech Subhash on 25/02/21.
//

import Foundation
import Starscream

enum SocketConectionStatus : Int {
    case disconnected = 0
    case connected
    case conencting
}

struct Observers {
    var identidfire: [ResponseType]
    var socketObserver: SocketObserver
}


class SocketManager: SocketMessage {
    
    
    static let shared  = SocketManager()
    
    
    fileprivate var observersList = Array<SocketObserver>()
    fileprivate var isNotify : Bool = false
  // http://14.99.153.8:1337/V1 local server
    //http://192.168.43.42:1337/V1 local computer
    var socket = WebSocket(request: URLRequest(url: URL(string: "wss://mzadi.ezxdemo.com:4040/V1")!))
    
    func connectSocket(notify: Bool) {
        self.isNotify =  notify
        socket.delegate = self
        socket.connect()
    }
    
    func disconnectSocket(notify: Bool) {
        self.isNotify =  notify
        socket.delegate = self
        socket.disconnect()
    }
    
    func registerToScoket(observer: SocketObserver) {
        observersList.append(observer)
    }
    
    func unregisterToSocket(observer: SocketObserver) {
        if let observerIndex: Int = (observersList.firstIndex { (element) -> Bool in
            return element === observer
        }){
            self.observersList.remove(at: observerIndex)
        }else{
            print("Observer Already Unregistred")
        }
       
    }
    
    func sendMessageToSocket(message: String) {
        print("SocketManager:: SendMessage", message)
        socket.write(string: message)
    }
    
    func notifyWebSocketConnectionStatus(status:Bool) {
        for obs in observersList {
            obs.socketConnection(status: status ? SocketConectionStatus.connected :  SocketConectionStatus.disconnected)
        }
    }
    
    func notifyObserver(message: [String: Any]){
        print(message)
        guard let type: ResponseType = ResponseType(rawValue: message["type"] as? String ?? "") else {
            return
        }
        guard let statusCode: Int = message["statusCode"] as? Int  else {
            return
        }
        let responseMessage: String = message["message"] as? String ?? "Unknown Error"
        for obs in observersList {
            obs.registerFor()
            if obs.registerFor().contains(type)  {
                obs.brodcastSocketMessage(to: type, statusCode: statusCode, data: message, message: responseMessage)
               
            }
        }
        
    }
    
    
}

//  MARK: - WebSocket Delegate
extension SocketManager:WebSocketDelegate {

    
    fileprivate func connectUserId() {
        let messageDictionary = [
            "request": "create_connection",
            "user_id":obj.prefs.value(forKey: APP_USER_ID) as? String ?? "",
            "type": "create",
            
        ] as [String : Any]
        print(messageDictionary)
        
        let jsonData = try! JSONSerialization.data(withJSONObject: messageDictionary)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
        if let message:String = jsonString as String? {
            SocketManager.shared.sendMessageToSocket(message: message)
        }
    }
    
    func websocketDidConnect(socket: WebSocketClient) {
        print("SocketManager:: Web socket connected");
        if isNotify {
            notifyWebSocketConnectionStatus(status: true)
        }
        connectUserId()
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
       // socket.connect()
        print("SocketManager:: Web socket disconnected");
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.socket.connect()
        }
        
        if isNotify {
            notifyWebSocketConnectionStatus(status: false)
        }
    }
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        print(event)
        print(client)
        switch event {
        case .connected(let dict):
            print(dict)
            connectUserId()
            if isNotify {
                notifyWebSocketConnectionStatus(status: true)
            }
        case .text(let strText):
            print(strText)
            print("SocketManager:: websocketDidReceiveMessage => \(strText)")
              guard let data = strText.data(using: .utf8), let jsonData = try? JSONSerialization.jsonObject(with: data), let jsonDict = jsonData as? [String: Any] else { return }
              notifyObserver(message: jsonDict)
        case .disconnected(let str, let Utf16va):
            print(str)
            print(Utf16va)
            if isNotify {
                notifyWebSocketConnectionStatus(status: false)
            }
        case .error(let er):
            print(er)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.socket.connect()
            }
        default:
            print("")
        }
    }
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("SocketManager:: websocketDidReceiveMessage => \(text)")
        guard let data = text.data(using: .utf8), let jsonData = try? JSONSerialization.jsonObject(with: data), let jsonDict = jsonData as? [String: Any] else { return }
        notifyObserver(message: jsonDict)
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        
    }

    
    
}
