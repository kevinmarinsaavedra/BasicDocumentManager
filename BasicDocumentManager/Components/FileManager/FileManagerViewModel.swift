//
//  FileManagerViewModel.swift
//  BasicDocumentManager
//
//  Created by Kevin Marin on 14/3/24.
//

import Foundation
import UIKit

class FileManagerViewModel: ObservableObject {
    var didSelectFile: (URL?) -> Void
    var dismiss: () -> Void
    
    init(didSelectFile: @escaping (URL?) -> Void, dismiss: @escaping () -> Void) {
        self.didSelectFile = didSelectFile
        self.dismiss = dismiss
    }
}

