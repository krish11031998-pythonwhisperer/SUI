//
//  Text.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 07/09/2022.
//

import Foundation
import SwiftUI

//MARK: - Heading Type
public enum HeadingType {
	case headSubhead
	case headCaption
}

//MARK: - Head SubHead View

public struct HeaderSubHeadView: View {
	
	let title: RenderableText
	let subTitle: RenderableText?
	let spacing: CGFloat
	let alignment: Alignment
	
	public init(title: RenderableText, subTitle: RenderableText?, spacing: CGFloat = 10, alignment: Alignment = .leading) {
		self.title = title
		self.subTitle = subTitle
		self.spacing = spacing
		self.alignment = alignment
	}
	
	public var body: some View {
		VStack(alignment: alignment.horizontal, spacing: spacing) {
			title.text
			if let validSubtitle = subTitle {
				validSubtitle.text
			}
		}
	}
}


//MARK: -  Head Caption View

public struct HeaderCaptionView: View {
	
	let title: RenderableText
	let subTitle: RenderableText?
	let spacing: CGFloat
	let alignment: Alignment
	
	public init(title: RenderableText, subTitle: RenderableText? = nil, spacing: CGFloat = 10, alignment: Alignment = .leading) {
		self.title = title
		self.subTitle = subTitle
		self.spacing = spacing
		self.alignment = alignment
	}
	
	public var body: some View {
		HStack(alignment: alignment.vertical, spacing: spacing) {
			title.text
			Spacer()
			if let validSubTitle = subTitle {
				validSubTitle.text
			}
			
		}
	}
}
