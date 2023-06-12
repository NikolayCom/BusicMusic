import Alamofire
import Foundation
import Moya
import Security

// MARK: - BaseRequestService

enum RequestMethod {
    case get
    case post
    case put
    case delete
    case patch
}

// MARK: - RequestManager

class RequestManager {
    //  swiftlint:disable all
    struct BaseTargetType: TargetType {
        var baseURL: URL
        var path: String
        var method: Moya.Method
        var sampleData = Data()
        var task: Task
        var headers: [String: String]?
    }

    private func makeCompletion<ResponseType: Codable>(
        data: ResponseType,
        completion: @escaping Completion<ResponseType>
    ) {
        completion(.value(data))
    }

    // swiftlint:enable all

    private func endpoint(target: BaseTargetType) -> Endpoint {
        Endpoint(
            url: URL(target: target).absoluteString.removingPercentEncoding ?? "",
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }

    private func moyaMethod(method: RequestMethod) -> Moya.Method {
        switch method {
        case .get:
            return Moya.Method.get

        case .post:
            return Moya.Method.post

        case .put:
            return Moya.Method.put

        case .delete:
            return Moya.Method.delete

        case .patch:
            return Moya.Method.patch
        }
    }

    func exec<ResponseType: Codable>(
        baseURL: URL,
        path: String,
        parameters: [String: Any]? = nil,
        body: [String: Any]? = [:],
        headers: [String: String]? = nil,
        method: RequestMethod,
        completion: @escaping Completion<ResponseType>
    ) {
        var task = Task.requestPlain
        if let parameters = parameters, !parameters.isEmpty {
            task = Task.requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
        if let body = body, !body.isEmpty,
           let theJSONData = try? JSONSerialization.data(withJSONObject: body, options: []) {
            task = Task.requestCompositeData(bodyData: theJSONData, urlParameters: parameters ?? [:])
        }

        let target = BaseTargetType(
            baseURL: baseURL,
            path: path,
            method: moyaMethod(method: method),
            task: task,
            headers: headers
        )
        let endpointClosure: MoyaProvider<BaseTargetType>.EndpointClosure = { _ in
            self.endpoint(target: target)
        }

        print("REQUEST ---> \(target) \n")

        MoyaProvider(endpointClosure: endpointClosure).request(target) { [weak self] result in
            switch result {
            case .success(let response):
                print("RESPONCE ---> \(response.request) \n \(String(decoding: response.data.prefix(response.data.count > 999 ? 999 : response.data.count), as: UTF8.self))")

                guard !response.data.isEmpty else {
                    DispatchQueue.main.async {
                        completion(.error(UIError.empty))
                    }
                    return
                }

                do {
                    let data = try response.map(ResponseType.self)

                    DispatchQueue.main.async {
                        self?.makeCompletion(data: data, completion: completion)
                    }
                } catch {
                    guard !response.data.isEmpty else {
                        DispatchQueue.main.async {
                            completion(.error(UIError.empty))
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        completion(.error(error))
                    }
                }

            case .failure(let error):
                completion(.error(error))
            }
        }
    }
}
