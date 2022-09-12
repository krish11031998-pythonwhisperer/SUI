//
//  LabelButton.swift
//  SUI
//
//  Created by Krishna Venkatramani on 12/09/2022.
//

import SwiftUI

//MARK: - LabelButtonConfig
enum ImageData {
	case url(String)
	case img(String)
}

extension ImageData {
	var value: String? {
		switch self {
		case .url(let url):
			return url
		case .img(let img):
			return img
		}
	}
}
struct LabelButtonConfig {
	enum ImageDirection {
		case top
		case left
		case right
		case bottom
	}
	
	enum Alignment {
		case vertical
		case horizontal
	}
	
	enum ImageStyle {
		case clipped
		case rounded(CGFloat)
	}
	
	let imgDirection: ImageDirection
	let orientation: LabelButtonConfig.Alignment
	let alignment: SwiftUI.Alignment
	let spacing: CGFloat
	let imageSize: CGSize
	let imageStyle: ImageStyle
	
	init(imgDirection: ImageDirection = .left,
		 orientation: LabelButtonConfig.Alignment = .horizontal,
		 alignment: SwiftUI.Alignment = .leading,
		 spacing: CGFloat = 8,
		 imageSize: CGSize,
		 imageStyle: ImageStyle
	) {
		self.imgDirection = imgDirection
		self.orientation = orientation
		self.alignment = alignment
		self.spacing = spacing
		self.imageSize = imageSize
		self.imageStyle = imageStyle
	}
}

extension LabelButtonConfig.ImageStyle {
	var radius: CGFloat {
		switch self {
		case .rounded(let rad):
			return rad
		case .clipped:
			return 0
		}
	}
}

//MARK: - LabelButton

struct LabelButton: View {
	
	let config: LabelButtonConfig
	let image: ImageData
	let title: RenderableText
	let subTitle: RenderableText?
	let handler: (() -> Void)?
	
	init(config: LabelButtonConfig,
		 image: ImageData,
		 title: RenderableText,
		 subTitle: RenderableText?,
		 handler: (() -> Void)? = nil) {
	
		self.config = config
		self.image = image
		self.title = title
		self.subTitle = subTitle
		self.handler = handler
	}
	
	
	@ViewBuilder var imgView: some View {
		switch image {
		case .url(let url):
			ImageView(url: url)
		case .img(let imgName):
			ImageView(image: .init(named: imgName))
		}
	}
	
	var verticalButton: some View {
		VStack(alignment: config.alignment.horizontal, spacing: config.spacing) {
			if config.imgDirection == .top {
				imgView
					.framed(size: config.imageSize, cornerRadius: config.imageStyle.radius, alignment: .center)
			}
			HeaderSubHeadView(title: title, subTitle: subTitle)
			if config.imgDirection == .bottom {
				imgView
					.framed(size: config.imageSize, cornerRadius: config.imageStyle.radius, alignment: .center)
			}
		}
	}

	var horizontalButton: some View {
		HStack(alignment: config.alignment.vertical, spacing: config.spacing) {
			if config.imgDirection == .left {
				imgView
					.framed(size: config.imageSize, cornerRadius: config.imageStyle.radius, alignment: .center)
			}
			HeaderSubHeadView(title: title, subTitle: subTitle)
			if config.imgDirection == .right {
				imgView
					.framed(size: config.imageSize, cornerRadius: config.imageStyle.radius, alignment: .center)
			}
		}
	}
	
	@ViewBuilder var buttonBody: some View {
		if config.orientation == .vertical {
			verticalButton
		} else {
			horizontalButton
		}
	}
	
    var body: some View {
		buttonBody
			.buttonify {
				handler?()
			}
    }
}

struct LabelButton_Previews: PreviewProvider {
	
	static var config: LabelButtonConfig {
		.init(imgDirection: .left,
			  orientation: .horizontal,
			  alignment: .trailing,
			  spacing: 8,
			  imageSize: .init(squared: 100),
			  imageStyle: .rounded(50))
	}
	
    static var previews: some View {
		LabelButton(config: Self.config,
					image: .url(UIImage.testImage),
					title: "Hello".styled(font: .systemFont(ofSize: 20, weight: .bold), color: .black),
					subTitle: "World".styled(font: .systemFont(ofSize: 16, weight: .semibold), color: .gray))
		.padding()
		.fillWidth(alignment: .leading)
    }
}
