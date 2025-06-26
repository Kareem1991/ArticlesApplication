//
//  ArticalesConfigurator.swift
//  ArticalesApp
//
//  Created by Kareem on 26/06/2025.
//
import SwiftUI

final class ArticalesConfigurator {
	
    static func configureModule() -> ArticlesView {
        let remoteRepo = ArticalesRemoteRepository()
        let localRepo = ArticalesLocalRepository()
        let ArticalesUseCase = ArticalesUseCase(remoteArticalesRepo: remoteRepo, localArticalesRepo: localRepo)
        let viewModel = ArticlesViewModel(articalesUseCase: ArticalesUseCase)
        let view = ArticlesView(viewModel: viewModel)
        return view
    }
}
