//
//  NetworkAPI.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 20.01.2020.
//  Copyright © 2020 Verb. All rights reserved.
//

import Alamofire
import Moya
import PromiseKit

class NetworkAPI<Target: APITargetType> {

    // MARK: - Private properties

    private let provider: MoyaProvider<APITarget>

    // MARK: - Lifecycle

    init() {

        var plugins = [PluginType]()
        if App.Debug.isAPILogEnabled { plugins.append(NetworkLoggerPlugin()) }
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 180
        provider = MoyaProvider<APITarget>(
            session: Moya.Session(configuration: configuration, startRequestsImmediately: false),
            plugins: plugins
        )
    }

}

// MARK: - Public methods
extension NetworkAPI {
    
    func request(_ target: Target) -> Promise<ServerResponse> {
        
        return Promise<ServerResponse> { performRequest(target: target, seal: $0) }
    }
    
    func cancelableRequest(_ target: Target) -> CancellablePromise<ServerResponse> {
        
        var request: Moya.Cancellable?
        let cancelable = Promise<ServerResponse> { seal in
            
            request = performRequest(target: target, seal: seal)
        }.cancellize()
        
        cancelable.catch(policy: .allErrors) { error in
            
            guard error.isCancelled else { return }
            request?.cancel()
        }
        
        return cancelable
    }
    
}

// MARK: - Private type definitions
private extension NetworkAPI {
    
    struct APITarget: TargetType {
        
        var baseURL: URL
        var path: String
        var method: Moya.Method
        var sampleData: Data
        var task: Task
        var headers: [String: String]?
        
        mutating func appendHeaders(_ headers: [String: String]?) {
            
            guard let headers = headers else { return }
            for key in headers.keys {
                
                self.headers?[key] = headers[key]
            }
        }
        
    }
    
}

// MARK: - Private methods
private extension NetworkAPI {
    
    @discardableResult
    func performRequest(target: Target, seal: Resolver<ServerResponse>) -> Moya.Cancellable {

        return provider.request(buildAPITarget(target: target)) { self.handleResult($0, seal: seal) }
    }
    
    func buildAPITarget(target: Target) -> APITarget {
        
        var headers = HTTPHeadersContainer()
        headers[.api] = App.Network.apiVersion
        headers[.platform] = App.Network.platform
        headers[.version] = App.Network.appVersion
        
        var target = APITarget(baseURL: target.baseURL,
                               path: target.path,
                               method: target.method,
                               sampleData: target.sampleData,
                               task: target.task,
                               headers: target.headers)
        target.appendHeaders(headers.content)
        return target
    }
    
    func handleResult(_ result: Result<Response, MoyaError>, seal: Resolver<ServerResponse>) {
        
        switch result {
        case .success(let response):
            do {
                
                let success = try response.filterSuccessfulStatusCodes()
                seal.fulfill(ServerResponse(data: success.data))
            }
            catch {
                
                seal.reject(self.handleServerError(data: response.data, error: error, statusCode: response.statusCode))
            }
        case .failure(let error):
  
            seal.reject(self.handleServerError(data: error.response?.data ?? Data(),
                                               error: error,
                                               statusCode: error.response?.statusCode ?? -1))
        }
    }
    
    func handleServerError(data: Data, error: Error, statusCode: Int) -> APIError {
        
        guard let error = error as? MoyaError else { return APIError.cancelled }
        let apiError: APIError
        if var serverError = try? ServerErrorProducer(from: data) {
        
            serverError.type = ServerErrorType(rawValue: statusCode) ?? .unknown
            apiError = .serverError(serverError)
        } else {
            
            apiError = .init(moyaError: error)
        }
        return apiError
    }
    
}

