//
//  URLProtocolMock.swift
//  MyComicsTests
//
//  Created by Xavi on 18/10/21.
//

import Foundation

// https://www.hackingwithswift.com/articles/153/how-to-test-ios-networking-code-the-easy-way
class URLProtocolMock: URLProtocol {

    // this dictionary maps URLs to test data
    static var testURLs = [URL?: Data]()
    static var response: URLResponse?
    static var error: Error?

    // say we want to handle all types of request
    override class func canInit(with request: URLRequest) -> Bool {

        return true
    }

    // ignore this method; just send back what we were given
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {

        return request
    }

    override func startLoading() {

        // if we have a valid URL and if we have test data for that URL…
        if let url = request.url, let data = URLProtocolMock.testURLs[url] {
            // …load it immediately.
            self.client?.urlProtocol(self, didLoad: data)
        }

        // …and we return our response if defined…
        if let response = URLProtocolMock.response {
            self.client?.urlProtocol(self,
                                     didReceive: response,
                                     cacheStoragePolicy: .notAllowed)
        }
        // …and we return our error if defined…
        if let error = URLProtocolMock.error {
            self.client?.urlProtocol(self, didFailWithError: error)
        }

        // mark that we've finished
        self.client?.urlProtocolDidFinishLoading(self)
    }

    // this method is required but doesn't need to do anything
    override func stopLoading() {
        // Nothing to do
    }
}
