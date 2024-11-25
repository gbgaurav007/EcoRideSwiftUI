//
//  VerificationService.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 27/10/24.
//

import Foundation

class VerificationService {
    func verifyDriver(data: VerificationModel, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let livePhotoData = data.livePhoto else {
            completion(.failure(NSError(domain: "Invalid photo", code: 0)))
            return
        }
        
        let url = URL(string: "\(API_BASE_URL)/users/verifyDriver")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(getAccessToken())", forHTTPHeaderField: "Authorization")
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let formData = createMultipartFormData(boundary: boundary, carName: data.carName, carNumber: data.carNumber, livePhotoData: livePhotoData)
        
        URLSession.shared.uploadTask(with: request, from: formData) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                completion(.failure(NSError(domain: "Invalid response", code: 0)))
                return
            }
            completion(.success(()))
        }.resume()
    }
    
    private func createMultipartFormData(boundary: String, carName: String, carNumber: String, livePhotoData: Data) -> Data {
        var formData = Data()
        
        formData.append("--\(boundary)\r\n".data(using: .utf8)!)
        formData.append("Content-Disposition: form-data; name=\"carName\"\r\n\r\n".data(using: .utf8)!)
        formData.append("\(carName)\r\n".data(using: .utf8)!)
        
        formData.append("--\(boundary)\r\n".data(using: .utf8)!)
        formData.append("Content-Disposition: form-data; name=\"carNumber\"\r\n\r\n".data(using: .utf8)!)
        formData.append("\(carNumber)\r\n".data(using: .utf8)!)
        
        formData.append("--\(boundary)\r\n".data(using: .utf8)!)
        formData.append("Content-Disposition: form-data; name=\"livePhoto\"; filename=\"livePhoto.jpg\"\r\n".data(using: .utf8)!)
        formData.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        formData.append(livePhotoData)
        formData.append("\r\n".data(using: .utf8)!)
        
        formData.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return formData
    }
}
