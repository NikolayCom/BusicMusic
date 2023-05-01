//
//  BaseApiRequestService.swift
//  UseCases
//
//  Created by Nikolay Pivnik on 1.05.23.
//

import Foundation

public class BaseApiRequestService {
    enum Path: String {
        case artist

        var fullPath: String {
            switch self {
            case .artist:
                return rawValue
            }
        }
    }

    private let request = RequestManager()

    public init() {}

    func exec<ResponseType: Codable>(
        baseURL: String,
        path: Path,
        parameters: [String: Any]? = nil,
        body: [String: Any]? = nil,
        method: RequestMethod,
        completion: @escaping Completion<ResponseType>
    ) {
        self.exec(
            baseURL: baseURL,
            path: path.fullPath,
            parameters: parameters,
            body: body,
            method: method,
            completion: completion
        )
    }

    func exec<ResponseType: Codable>(
        baseURL: String = "BaseUrl",
        path: String,
        parameters: [String: Any]? = nil,
        body: [String: Any]? = nil,
        method: RequestMethod,
        completion: @escaping Completion<ResponseType>
    ) {
        guard let url = URL(string: baseURL) else {
            completion(.error(UIError.wrongUrl))
            return
        }

        self.exec(
            baseURL: url,
            path: path,
            parameters: parameters,
            body: body,
            method: method
        ) { [weak self] in
            self?.exec(
                baseURL: baseURL,
                path: path,
                parameters: parameters,
                body: body,
                method: method,
                completion: completion
            )
        }
        completion: { (result: Result<ResponseType>) in
            switch result {
            case .value(let response):
                completion(.value(response))

            case .error(let error):
                completion(.error(error))
            }
        }
    }
}

// MARK: - Private

extension BaseApiRequestService {
    private func exec<ResponseType: Codable>(
        baseURL: URL,
        path: String,
        header: [String: String]? = nil,
        parameters: [String: Any]? = nil,
        body: [String: Any]? = [:],
        method: RequestMethod,
        refresh: Action? = nil,
        completion: @escaping Completion<ResponseType>
    ) {
        let headers = self.composeHeader(path: path, header: header)
        let parameters = self.composeParams(params: parameters)

        self.request.exec(
            baseURL: baseURL,
            path: path,
            parameters: parameters,
            body: body,
            headers: headers,
            method: method,
            completion: { (result: Result<ResponseType>) in
                switch result {
                case .value(let response):
                    completion(.value(response))

                case .error(let error):
                    guard let uiError = error as? UIError else {
                        completion(.error(error))
                        return
                    }

                    switch uiError {
                    default:
                        completion(.error(error))
                        return
                    }
                }
            }
        )
    }

    private func composeParams(params: [String: Any]?) -> [String: Any] {
        var params = params ?? [:]
        params["fmt"] = "json"

        return params
    }

    private func composeHeader(path: String, header: [String: String]?) -> [String: String] {
        if let header = header { return header }
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        return headers
    }
}
