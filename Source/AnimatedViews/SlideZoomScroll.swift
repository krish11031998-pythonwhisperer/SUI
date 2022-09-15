//
//  SlideZoomCardCarousel.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 06/09/2022.
//

import Foundation
import SwiftUI

//MARK: - View Modifier

fileprivate struct SlideZoomCard: ViewModifier {
	@State var scale: CGFloat = 1
	
	func scaleFactor(midX: CGFloat){
		asyncMainAnimation(animation: .default) {
			scale = midX > .totalWidth * 0.5 ? 0.9 : 1
		}
	}
	
	func clearViewBuilder(g: GeometryProxy) -> some View {
		scaleFactor(midX: g.frame(in: .global).midX)
		return Color.clear
	}
	
	func body(content: Content) -> some View {
		content
			.scaleEffect(scale)
			.background(GeometryReader(content: clearViewBuilder(g:)))
	}
}

//MARK: - View Extension

fileprivate extension View {
	
	func slideZoomCard() -> some View { modifier(SlideZoomCard()) }
}

//MARK: - SlideZoomScroll

public struct SlideZoomScroll<Content: View>: View {
	
	@State var currentIdx: Int = .zero
	@State var off: CGFloat = .zero
	
	let size: CGSize
	let spacing: CGFloat
	let data: [Any]
	let cardBuilder: (Any) -> Content
	
	public init(data: [Any], itemSize: CGSize, spacing: CGFloat = 10, @ViewBuilder cardBuilder: @escaping (Any) -> Content) {
		self.data = data
		self.cardBuilder = cardBuilder
		self.spacing = spacing
		self.size = itemSize
	}
	
	public var body: some View {
		SimpleHScroll(data: data, config: .original) {
			cardBuilder($0)
				.slideZoomCard()
				.fixedSize()
		}
	}
}


fileprivate struct SlideZoomCardCarousel_Preview: PreviewProvider {
	
	static var previews: some View {
		SlideZoomScroll(data: [Color.red, Color.blue, Color.mint,Color.red, Color.blue,Color.red, Color.blue, Color.mint,Color.red, Color.blue], itemSize: .init(width: 200, height: 200)) { color in
			RoundedRectangle(cornerRadius: 20)
				.fill((color as? Color) ?? .red)
				.frame(width: 200, height: 200)
		}
	}
}
