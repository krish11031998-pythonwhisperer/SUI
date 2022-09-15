//
//  SimpleHScroll.swift
//  SUI
//
//  Created by Krishna Venkatramani on 15/09/2022.
//

import SwiftUI

public struct SimpleHScrollConfig {
	let spacing:CGFloat
	let showsIndicator: Bool
	let horizontalInsets: EdgeInsets
	let alignment: VerticalAlignment
}

public extension SimpleHScrollConfig {
	
	static var original: SimpleHScrollConfig {
		.init(spacing: 10, showsIndicator: false, horizontalInsets: .init(vertical: 0, horizontal: 10), alignment: .center)
	}
}

public struct SimpleHScroll<Content: View>: View {
	let data: [Any]
	let viewBuilder: (Any) -> Content
	let config: SimpleHScrollConfig
	
	public init(data:[Any], config: SimpleHScrollConfig, @ViewBuilder viewBuilder: @escaping (Any) -> Content) {
		self.data = data
		self.viewBuilder = viewBuilder
		self.config = config
	}
	
    public var body: some View {
		ScrollView(.horizontal, showsIndicators: config.showsIndicator) {
			HStack(alignment: config.alignment, spacing: config.spacing) {
				ForEach(Array(data.enumerated()), id: \.offset) {
					viewBuilder($0.element)
						.padding(.leading, $0.offset == 0 ? config.horizontalInsets.leading : 0)
						.padding(.trailing, $0.offset == data.count - 1 ? config.horizontalInsets.trailing : 0)
				}
			}
		}
    }
}

fileprivate
struct SimpleHScroll_Previews: PreviewProvider {
    static var previews: some View {
		SimpleHScroll(data: Array(repeating: Color.orange, count: 10), config: .original) { color in
			RoundedRectangle(cornerRadius: 20)
				.fill((color as? Color) ?? .black)
				.framed(size: .init(squared: 100))
		}
    }
}
