//
//  MainView.swift
//  BasicDocumentManager
//
//  Created by Kevin Marin on 14/3/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                if let viewModel = fileCardViewModel {
                    FileCardView(viewModel: viewModel)
                }
                
                Button(
                    action: {
                        viewModel.showFileManage = true
                    },
                    label: {
                        Text(Constant.text)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, minHeight: Constant.buttonHeight)
                            .background(backgroundGradiente)
                            .cornerRadius(Constant.cornerRadius)
                            .overlay(
                                RoundedRectangle(cornerRadius: Constant.cornerRadius)
                                    .stroke(Color.black, lineWidth: 3)
                            )                })
                
            }
            .padding()
            .sheet(isPresented: $viewModel.showFileManage, content: {
                FileManagerView(viewModel: fileManagerViewModel)
                    .edgesIgnoringSafeArea(.all)
            })
        }
    }
}

// MARK: ViewModels complements
extension MainView {
    var fileCardViewModel: FileCardViewModel? {
        guard let fileDetails = viewModel.fileDetails else {
            return nil
        }
        
        return FileCardViewModel(
            fileURL: fileDetails.url,
            fileName: fileDetails.fileName,
            fileExtension: fileDetails.fileExtension,
            fileData: fileDetails.fileData,
            fileSize: fileDetails.fileSize)
    }
    
    var fileManagerViewModel: FileManagerViewModel {
        return .init(
            didSelectFile: { url in
                viewModel.saveFileDetails(url: url)
            },
            dismiss: {
                viewModel.showFileManage = false
            })
    }
}

// MARK: View complements
extension MainView {
    var backgroundGradiente: some View {
        return LinearGradient(
            gradient: Gradient(colors: [Color.yellow, Color.orange]),
            startPoint: .leading,
            endPoint: .trailing)
    }
}

extension MainView {
    struct Constant {
        static let primaryColor: Color = .black
        static let text = "OPEN FILE MANAGER"
        static let buttonHeight = 50.0
        static let cornerRadius = 15.0
    }
}

#Preview {
    MainView()
}

