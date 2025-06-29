//
//  CustomNavigationView.swift
//  ArticalesApp
//
//  Created by Kareem on 29/06/2025.
//

import SwiftUI

struct CustomNavigationView<Content: View>: View {
    let title: String
    let showBackButton: Bool
    let showSearchButton: Bool
    let showMenuButton: Bool
    let content: Content
    let onBackTapped: (() -> Void)?
    let onSearchTapped: (() -> Void)?
    let onMenuTapped: (() -> Void)?
    
    init(
        title: String,
        showBackButton: Bool = false,
        showSearchButton: Bool = true,
        showMenuButton: Bool = true,
        onBackTapped: (() -> Void)? = nil,
        onSearchTapped: (() -> Void)? = nil,
        onMenuTapped: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.showBackButton = showBackButton
        self.showSearchButton = showSearchButton
        self.showMenuButton = showMenuButton
        self.onBackTapped = onBackTapped
        self.onSearchTapped = onSearchTapped
        self.onMenuTapped = onMenuTapped
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            navigationBar
            
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private var navigationBar: some View {
        VStack(spacing: 0) {
            // Green navigation content
            HStack {
                leftButton
                
                Spacer()
                
                Text(title)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                Spacer()
                
                rightButtons
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.4, green: 0.8, blue: 0.6),
                        Color(red: 0.3, green: 0.7, blue: 0.5)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        }
        .background(
            Color.navColor
                .ignoresSafeArea(.all, edges: .top)
        )
    }
    
    @ViewBuilder
    private var leftButton: some View {
        if showBackButton {
            Button(action: {
                onBackTapped?()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
            }
        } else if showMenuButton {
            Button(action: {
                onMenuTapped?()
            }) {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
            }
        } else {
            Color.clear
                .frame(width: 24, height: 24)
        }
    }
    
    private var rightButtons: some View {
        HStack(spacing: 16) {
            if showSearchButton {
                Button(action: {
                    onSearchTapped?()
                }) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                }
            }
            
            Button(action: {
                // Handle more action
            }) {
                Image(systemName: "ellipsis")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
            }
        }
    }
}
