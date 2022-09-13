//
//  RoundedButton.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 07/09/2022.
//

import SwiftUI
import SUI

//MARK: - Defination

fileprivate extension LabelButtonConfig{
	static func basicConfigBuilder(imgDir: LabelButtonConfig.ImageDirection,
								   orientation: LabelButtonConfig.Alignment,
								   alignment: SwiftUI.Alignment = .center,
								   labelConfig: LabelButtonConfig.LabelConfig = .init(spacing: 10, alignment: .leading)) -> Self {
		.init(imgDirection: imgDir,
			  orientation: orientation,
			  alignment: alignment,
			  labelConfig: labelConfig,
			  spacing: 8,
			  imageSize: .init(squared: 100),
			  imageStyle: .rounded(50))
	}
	
	static var leftLabelButtonConfig: LabelButtonConfig {
		Self.basicConfigBuilder(imgDir: .left, orientation: .horizontal)
	}
	
	static var rightLabelButtonConfig: LabelButtonConfig {
		Self.basicConfigBuilder(imgDir: .right, orientation: .horizontal)
	}
	
	static var topLabelButtonConfig: LabelButtonConfig {
		Self.basicConfigBuilder(imgDir: .top, orientation: .vertical)
	}
	
	static var bottomLabelButtonConfig: LabelButtonConfig {
		Self.basicConfigBuilder(imgDir: .bottom, orientation: .vertical)
	}
}

fileprivate extension BlobButtonConfig {
	
	static var normal: Self {
		.init(color: .clear, cornerRadius: 13, border: .init(color: .black, borderWidth: 1))
	}
	
	static var selected: Self {
		.init(color: .purple.opacity(0.15), cornerRadius: 13, border: .init(color: .purple, borderWidth: 1))
	}
}


//MARK: - ButtonComponents

struct ButtonComponents: View {
	@State var showModal: Bool = false
	@State var showFullScreen: Bool = false
	@State var imgDir: LabelButtonConfig.ImageDirection = .left
	@State var orientation: LabelButtonConfig.Alignment = .horizontal
	@State var alignment: Alignment = .center
	@State var labelAligment: HorizontalAlignment = .leading
	@State var blobButtonSelected: Bool = false
	
	@ViewBuilder func modalView() -> some View {
		VStack(alignment: .leading, spacing: 10) {
			HStack(alignment: .center) {
				"Modal"
					.styled(font: .systemFont(ofSize: 25, weight: .bold), color: .black)
					.text
				Spacer()
				if !showFullScreen {
					CustomButton(config: .init(imageName: .close)) {
						if showModal { showModal = false }
						if showFullScreen { showFullScreen = false }
					}
				}
			}
			.fillWidth(alignment: .leading)
			"This is a simple text that is being displayed, This is a simple text that is being displayed".text
		}.padding()
	}
	
	
    var body: some View {
		ZStack(alignment: .bottom) {
			ScrollView(.vertical, showsIndicators: false) {
				LazyVStack(alignment: .center, spacing: 10) {
					roundedButtonSection
						.padding(.horizontal)
						.containerize(title: "Rounded Button".sectionHeader(),
									  subTitle: "with all Configs".sectionSubHeading(),
									  alignment: .leading, style: .headSubhead)
					blobButton
						.padding()
						.fillWidth(alignment: .center)
						.containerize(title: "Blob Button".sectionHeader(),
								  subTitle: "with all Configs".sectionSubHeading(),
								  alignment: .leading, style: .headSubhead)
					labelButtonDemoSection
						.padding(.horizontal, 10)
						.fillWidth(alignment: .center)
						.containerize(title: "Label Button".sectionHeader(),
									  subTitle: "with all Configs".sectionSubHeading(),
									  alignment: .leading, style: .headSubhead)
						
				}
				.padding(.bottom, .safeAreaInsets.bottom)
			}
		}
		.slideInFromBottomModal(showModal: $showModal, modalConfig: .defaultConfig,modal: modalView)
		.fullScreenModal(isActive: $showFullScreen, innerContent: {
			modalView()
				.padding(.top, .safeAreaInsets.top)
		})
		.edgesIgnoringSafeArea(.bottom)
		.navigationTitle("Rounded Button")
		.navigationBarTitleDisplayMode(.inline)
    }
}

//MARK: - RoundedButton Demo
extension ButtonComponents {
	
	@ViewBuilder var roundedButtonSection: some View {
		RoundedButton(model: .testModelLeading)
			.containerize(title: "Rounded Button".systemHeading2(), subTitle: "w/ Leading Image".systemSubHeading(color: .gray),hPadding: 0)
			.fillWidth(alignment: .leading)
		
		RoundedButton(model: .testModelTrailing)
			.containerize(title: "Rounded Button".systemHeading2(), subTitle: "w/ Trailing Image".systemSubHeading(color: .gray),hPadding: 0)
			.fillWidth(alignment: .leading)
			
		RoundedButton(model: .testModel) {
			self.showFullScreen.toggle()
		}
		.containerize(title: "Rounded Button".systemHeading2(), subTitle: "w/o Image".systemSubHeading(color: .gray),hPadding: 0)
		.fillWidth(alignment: .leading)
		
		RoundedButton(model: .testModelWithBlob) {
			self.showModal.toggle()
		}
		.containerize(title: "Rounded Button".systemHeading2(), subTitle: "w/ Blob".systemSubHeading(color: .gray),hPadding: 0)
		.fillWidth(alignment: .leading)
	}
}

//MARK: - Blob Button
extension ButtonComponents {

	@ViewBuilder var blobButton: some View {
		BlobButton(text: ("Click me").systemBody(color: blobButtonSelected ? .purple : .black),
				   config: blobButtonSelected ? .selected : .normal) {
			asyncMainAnimation {
				blobButtonSelected.toggle()
			}
		}.fixedWidth(width: .totalWidth.half)
		
	}
}

//MARK: - Label Button Demo
extension ButtonComponents {
	
	var imgDirs: [LabelButtonConfig.ImageDirection] {
		[.left,.right,.bottom,.top]
	}
	
	var orientationList: [LabelButtonConfig.Alignment] {
		[.vertical, .horizontal]
	}
	
	var alignmentList: [(key: String, value: Alignment)] {
		["Leading" : Alignment.leading,
		 "Trailing" : Alignment.trailing,
		 "Center": Alignment.center,
		 "Top": Alignment.top,
		 "Bottom": Alignment.bottom]
			.sorted { $0.key < $1.key}
	}
	
	var labelAlignmentList : [(key: String, value: HorizontalAlignment)]{
		["Leading" : HorizontalAlignment.leading,
		 "Trailing" : HorizontalAlignment.trailing,
		 "Center": HorizontalAlignment.center].sorted { $0.key < $1.key}
	}
	
	@ViewBuilder var labelButtonDemoSection: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack(alignment: .center, spacing: 10) {
				ForEach(imgDirs, id:\.self) { dir in
					BlobButton(text: dir.rawValue.capitalized.systemBody(color: imgDir ==  dir ? .purple : .black),
							   config: dir == imgDir ? .selected : .normal) {
						asyncMainAnimation {
							imgDir = dir
							orientation = dir == .left || dir == .right ? .horizontal : .vertical
						}
					}
				}
			}
			
		}.padding(.top)
			.containerize(title: "Image Direction".systemSubHeading(color: .black),
						   subTitle: "Orientation is automatically updated!".systemBody(color: .gray),vPadding: 0, hPadding: 0)
		ScrollView(.horizontal, showsIndicators: false) {
			HStack(alignment: .center, spacing: 10) {
				ForEach(Array(alignmentList), id:\.key) { al in
					BlobButton(text: al.key.systemBody(color: alignment ==  al.value ? .purple : .black),
							   config: alignment == al.value ? .selected : .normal) {
						asyncMainAnimation {
							alignment = al.value
						}
					}
				}
			}
			
		}
		.containerize(title: "Alignment".systemSubHeading(color: .black),vPadding: 0, hPadding: 0)
		
		ScrollView(.horizontal, showsIndicators: false) {
			HStack(alignment: .center, spacing: 10) {
				ForEach(Array(labelAlignmentList), id:\.key) { al in
					BlobButton(text: al.key.systemBody(color: labelAligment ==  al.value ? .purple : .black),
							   config: labelAligment == al.value ? .selected : .normal) {
						asyncMainAnimation {
							labelAligment = al.value
						}
					}
				}
			}
			
		}
		.containerize(title: "Label Alignment".systemSubHeading(color: .black),vPadding: 0, hPadding: 0)
		
		LabelButton(config: .basicConfigBuilder(imgDir: imgDir,
												orientation: orientation,
												alignment: alignment,labelConfig: .init(spacing: 8, alignment: labelAligment)),
					image: .img(UIImage.testImage),
					title: "Hello World".systemHeading1(),
					subTitle: "with horizontal leading config".systemSubHeading(color: .gray)) {
			print("(DEBUG) clicked on Hello World!")
		}
	}
}

extension ButtonComponents {
}


struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        ButtonComponents()
    }
}
