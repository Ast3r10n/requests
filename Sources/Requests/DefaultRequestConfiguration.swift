//
//  DefaultRequestConfiguration.swift
//  
//
//  Created by Andrea Sacerdoti on 22/01/2020.
//

import Foundation

/// The protocol the app's specific configuration must implement.
public protocol RequestConfiguration {
  /// The default Request headers.
  ///
  /// Any headers passed to specific `Requests` would be appended to these.
  var defaultHeaders: [String: String] { get }
  /// The Request protocol.
  var requestProtocol: String { get }
  /// The default base URL (not including protocol).
  var baseURL: String { get }
  /// The server's authentication realm.
  var authenticationRealm: String { get }
  /// The default authentication method to use with Requests.
  var authenticationMethod: String { get }
}

public extension RequestConfiguration {
  /// The URLProtectionSpace generated by the configuration parameters.
  var protectionSpace: URLProtectionSpace { get }
}

public extension RequestConfiguration {
  func assign(to holder: RequestConfigurationHolder = RequestConfigurationHolder.shared) {
    holder.configuration = self
  }
}

/// The `RequestConfiguration` assigned to the `ReuqestConfigurationHolder` instance by default.
open class DefaultRequestConfiguration: RequestConfiguration {

  open var defaultHeaders: [String: String] {
    [
      "Accept": "application/json",
      "Content-Type": "application/json",
    ]
  }

  open var requestProtocol: String {
    "https"
  }


  open var baseURL: String {
    "test.url.com"
  }

  open var authenticationRealm: String {
    "Restricted"
  }

  open var authenticationMethod: String {
    NSURLAuthenticationMethodDefault
  }
  
  public var protectionSpace: URLProtectionSpace {
    URLProtectionSpace(host: baseURL,
                       port: 443,
                       protocol: requestProtocol,
                       realm: authenticationRealm,
                       authenticationMethod: authenticationMethod)
  }

  public init() {
  }
}
