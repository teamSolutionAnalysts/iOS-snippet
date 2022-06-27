//
//  APIService.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 22/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//


import Alamofire
import Moya
import NVActivityIndicatorView
import SwiftyJSON
import UIKit

//MARK: Possible errors 
enum APIStatusCode: Int {
    case success = 200
    case error = 400
    case internalServer = 500
    case notAuthorized = 412
    case alreadyExist = 428
    case alreadyLoggedIn = 401
    case tokenExpire = 403
    case notFound = 404
    case errorMessageInRequest = 409
    case largeFileSize = 413
    
}

class ApiServices {
    
    static let shared = ApiServices()
    var showLoading: Bool = true
    var authHeader: [String: String] {
        return ApiConsts.Header.appJson
    }
   
    //MARK: Loader
    func showLoader() {
        if showLoading {
            let activityData = ActivityData(type: NVActivityIndicatorType.ballPulse, color: AppColors.textThemeColor)
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
        }
    }
    
    func hideLoader() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    //MARK: Decodeing Response
    func decode<T: Decodable>(_ res: JSON?) -> T? {
        guard let response = res else { return nil }
        do {
            let data = try response.rawData()
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            Logger.shared.log("error -> \(error)")
            return nil
        }
    }
    
    //MARK: Handling Response
    func handleServices(manualStopLoading: Bool = false,
                        result: Result<Response, MoyaError>,
                        completion: @escaping (_ success: Bool, _ error: String?, _ response: JSON?) -> Void) {
        showLoading = true
        if !manualStopLoading {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
        switch result {
        case .success(let response):
            
            let apiStatusCode: APIStatusCode = APIStatusCode(rawValue: response.statusCode) ?? .notFound
            
            let responseJSON = JSON(response.data)
            
            Logger.shared.log("Request :- \(response.request?.url?.absoluteString ?? "")")
            Logger.shared.log("Headers :- \(response.request?.allHTTPHeaderFields ?? [:])")
            Logger.shared.log("Parameter :- \(JSON(response.request?.httpBody ?? Data()))")
            Logger.shared.log("Status Code:- \(response.statusCode)")
            Logger.shared.log("Response - \(responseJSON)")
            
            switch apiStatusCode {
                
            case .success:
                completion(true, nil, responseJSON)
                
            case .largeFileSize:
                AlertView.shared.displayCustomAlertWithOneButton(
                    message: AppLanguageConstants.largeImageSize.localized(),
                    btnDismissTapped: { })
                completion(false, String(apiStatusCode.rawValue), responseJSON)
                
                
            case .alreadyExist:
                let message = responseJSON[ApiConsts.Params.message].string ?? ""
                completion(false, message, responseJSON)
            default:
                do {
                    let info = try JSONDecoder().decode(CommonResponse.self, from: response.data)
                    if let error = info.error {
                        AlertView.shared.displayCustomAlertWithOneButton(message: error, btnDismissTapped: { })
                    } else if let message = info.message {
                        AlertView.shared.displayCustomAlertWithOneButton(message: message, btnDismissTapped: { })
                    }else{
                        AlertView.shared.displayCustomAlertWithOneButton(message: AppLanguageConstants.tryAgainLater.localized(), btnDismissTapped: { })
                    }
                    
                    
                } catch {
                    AlertView.shared.displayCustomAlertWithOneButton(message: AppLanguageConstants.tryAgainLater.localized(), btnDismissTapped: { })
                }
                completion(false, String(apiStatusCode.rawValue) , responseJSON)
            }
        case .failure(let error):
            Logger.shared.log(error.errorDescription as Any)
            if error.errorDescription ==
                "URLSessionTask failed with error: The Internet connection appears to be offline." {
                AlertView.shared.displayCustomAlertWithOneButton(
                    message: AppLanguageConstants.noInternet.localized(),
                    btnDismissTapped: { })
            }
            completion(false, error.localizedDescription, nil)
        }
    }
    
}
