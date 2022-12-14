//
//  Connectivity.swift
//  IntrazeroTask
//
//  Created by Bassam on 8/13/22.
//

import Foundation
import Alamofire

struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
  }
}
