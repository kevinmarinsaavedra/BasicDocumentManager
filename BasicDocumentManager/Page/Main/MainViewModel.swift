//
//  MainViewModel.swift
//  BasicDocumentManager
//
//  Created by Kevin Marin on 14/3/24.
//

import Foundation
import UIKit

class MainViewModel: NSObject, ObservableObject {
    @Published var showFileManage = false
    @Published var fileDetails: FileDetailsModel?
    
    func saveFileDetails(url: URL?) {
        guard let url = url else {
            // If the URL is nil, we cannot continue.
            // We might log an error or display an error message to the user.
            print("Error: URL is nil")
            return
        }
        
        do {
            // Try to obtain access to the security-scoped resource for the URL.
            // This is important to access the file content securely.
            if url.startAccessingSecurityScopedResource() {
                // If access to the security-scoped resource is obtained, proceed with getting file details.
                let fileManager = Foundation.FileManager.default
                let fileName = url.lastPathComponent
                let fileExtension = url.pathExtension
                let fileData = try Data(contentsOf: url)
                let fileAttributes = try fileManager.attributesOfItem(atPath: url.path)
                var fileSize = 0
                if let size = fileAttributes[.size] as? Int {
                    fileSize = size
                }
                    
                // Create a FileDetails object with the obtained file details.
                fileDetails = .init(url: url,
                                    fileName: fileName,
                                    fileExtension: fileExtension,
                                    fileData: fileData,
                                    fileSize: fileSize)
                
                // Stop accessing the security-scoped resource once you're done using it.
                // This is important to release the resources associated with accessing the URL.
                url.stopAccessingSecurityScopedResource()
            }
        } catch {
            // Handle any error that may occur during getting file details.
            print("Error loading file details: \(error.localizedDescription)")
        }

    }
}
