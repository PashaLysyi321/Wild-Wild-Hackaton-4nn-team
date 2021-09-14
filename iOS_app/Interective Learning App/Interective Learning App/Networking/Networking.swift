//
//  Networking.swift
//  Interective Learning App
//
//  Created by Prefect on 11.09.2021.
//

import Foundation
import Alamofire

// On development environment
// We getting finished video form server on 'download' endpoint
enum Environment: String, CaseIterable {
    case develop = "Development"
    case production = "Production"
}

class Networking {
    
    static var shared = Networking()
    
    static var baseURL = Constants.currentEnviroment == .production ? "http://65.21.252.150:5000/" : "http://65.21.252.150:5000/dev/"
    
    static var posttxtURL = baseURL + "posttxt/" + Constants.currentSpecher.rawValue + "/" + Constants.currentFaceName
    static var uploadImageURLstring = baseURL + "postspeaker/"
    
    private init() { }
    
    private let jsonDecoder = JSONDecoder()
    
    // Here we uploading .txt file with input from textView field
    // And getting in response .mp4 result file
    func download(txtFileData: Data,
                  completion: @escaping (_ success: Bool,
                                         _ fileUrl: URL?) -> Void) {
        
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(txtFileData,
                                     withName: "file",
                                     fileName: "input.txt",
                                     mimeType: "text/plain")
        },
        to: URL(string: Networking.posttxtURL)!,
        method: .post,
        headers: headers) { $0.timeoutInterval = 2 }.responseData { response in
            print(Networking.baseURL)
            
            
            if let data = response.value {
                let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(UUID().uuidString + ".mp4")
                do {
                    try data.write(to: fileURL, options: .atomic)
                    completion(true, fileURL)
                } catch {
                    completion(false, nil)
                }
            }
        }
    }
    
    // Here we uploading .png file with with custom spiker image
    func uploadImage(name: String,
                     data: Data) {
        
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(data,
                                     withName: "file",
                                     fileName: name + ".png",
                                     mimeType: "image/png")
        }, to: URL(string: Networking.uploadImageURLstring + name)!,
        method: .post,
        headers: headers){ $0.timeoutInterval = 12000 }.responseData { response in
            if let _ = response.value {
            } else {
                // TODO: Handle error add escaping and return here error
            }
        }
    }
}
