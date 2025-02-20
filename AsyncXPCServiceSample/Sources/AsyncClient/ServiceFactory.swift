//
//  ServiceFactory.swift
//  AsyncXPCServiceSample
//
//  Created by Leo Dion on 2/20/25.
//

import Foundation
import AsyncServiceXPC
import AsyncXPCConnection

public enum ServiceFactory {
  public static func service () -> AsyncService {
    let connection = NSXPCConnection(serviceName: "com.brightdigit.AsyncXPCServiceSampleXPC")
    connection.remoteObjectInterface = NSXPCInterface(with: AsyncServiceXPCProtocol.self)
    connection.resume()
    
    return RemoteXPCService<AsyncServiceXPCProtocol>(connection: connection)
  }
}
