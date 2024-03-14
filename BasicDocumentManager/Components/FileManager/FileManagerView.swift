//
//  FileManagerView.swift
//  BasicDocumentManager
//
//  Created by Kevin Marin on 14/3/24.
//

import SwiftUI
import MobileCoreServices
import UniformTypeIdentifiers

struct FileManagerView: UIViewControllerRepresentable {
    var viewModel: FileManagerViewModel
    
    init(viewModel: FileManagerViewModel) {
        self.viewModel = viewModel
    }
    
    typealias UIViewControllerType = UIDocumentPickerViewController
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let view = UIDocumentPickerViewController(forOpeningContentTypes: [.item])
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
        // empty
    }
    
    // MARK:
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: FileManagerView

        init(parent: FileManagerView) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else {
                parent.viewModel.dismiss()
                return
            }
            
            parent.viewModel.didSelectFile(url)
            parent.viewModel.dismiss()
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.viewModel.dismiss()
        }
    }
}
