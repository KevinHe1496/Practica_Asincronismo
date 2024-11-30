

import Foundation

class URLProtocolMock: URLProtocol {
    static var testData: Data?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true // Siempre intercepta las solicitudes
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let data = URLProtocolMock.testData {
            self.client?.urlProtocol(self, didLoad: data)
            self.client?.urlProtocolDidFinishLoading(self)
        }
    }

    override func stopLoading() {
        // No se necesita hacer nada aquí
    }
    
    static func startInterceptingRequests() {
        URLProtocol.registerClass(URLProtocolMock.self)
    }

    static func stopInterceptingRequests() {
        URLProtocol.unregisterClass(URLProtocolMock.self)
    }
}


