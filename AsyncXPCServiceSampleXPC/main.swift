//
//  main.swift
//  AsyncXPCServiceSampleXPC
//
//  Created by Leo Dion on 2/20/25.
//

import Foundation
import AsyncXPC


// Create the delegate for the service.
let delegate = ServiceDelegate()

// Set up the one NSXPCListener for this service. It will handle all incoming connections.
let listener = NSXPCListener.service()
listener.delegate = delegate

// Resuming the serviceListener starts this service. This method does not return.
listener.resume()
