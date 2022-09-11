//
//  AnimationMaster.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 07/09/2022.
//

import Foundation
import SwiftUI
import SUI

struct AnimationCollectionMaster: View {
	let colors : [Color] = [Color.red, Color.blue, Color.mint,Color.red, Color.blue,Color.red, Color.blue, Color.mint,Color.red, Color.blue]
	
	@State var showDiscoveryView: Bool = false
	@State var showStackedScroll: Bool = false
	@State var loadData: Bool = false
	@State var enableScroll: Bool = true
	
	@StateObject var randomImageDownload: RandomImagesDownloaders = .init(endPoint: .list(page: Int.random(in: 0...5), limit: 25))
	
	func headerBuilder(title: String, subTitle: String? = nil) -> AnyView {
		HeaderSubHeadView(title: title.styled(font: .systemFont(ofSize: 15, weight: .bold), color: .black),
						  subTitle: subTitle?.styled(font: .systemFont(ofSize: 13, weight: .medium), color: .black))
		.padding()
		.fillWidth(alignment: .leading)
		.anyView
	}
		
	private func loadImages(_ val: Bool) {
		randomImageDownload.loadImage()
	}
	
	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			VStack(alignment: .center, spacing: 10) {
				
				SlideOverCarousel(data:[Color.red, Color.blue, Color.brown, Color.mint]) { color in
					VStack(alignment: .leading, spacing: 15) {
						RoundedButton(model: .testModelLeading)
							.fixedHeight(height: 50)
							"This is a test text , a alternative to the boring Lorem ipsum text"
							.systemBody()
							.text
						Spacer()
					}
					.padding()
					.frame(size: .init(width: .totalWidth - 20, height: 200))
					.background((color as? Color) ?? .black)
					.clipContent(radius: 16)
				}
				.containerize(header: headerBuilder(title: "Slide Over Carousel", subTitle: "w/o Timer"))

				
				SlideOverCarousel(data:[Color.red, Color.blue, Color.brown, Color.mint],config: .withTimer) { color in
					VStack(alignment: .leading, spacing: 15) {
						RoundedButton(model: .testModelLeading)
							.fixedHeight(height: 50)
							"This is a test text , a alternative to the boring Lorem ipsum text"
							.systemBody()
							.text
						Spacer()
					}
					.padding()
					.frame(size: .init(width: .totalWidth - 20, height: 200))
					.background((color as? Color) ?? .black)
					.clipContent(radius: 16)
				}.containerize(header: headerBuilder(title: "Slide Over Carousel", subTitle: "w/ Timer"))
				
				CascadingCardStack(data: colors, offFactor: .totalWidth.half.half) { color, isSelected in
					ZStack(alignment: .center) {
						if let color = color as? Color {
							color
						} else {
							Color.black
						}
					}
					.framed(size: .init(width: 200, height: 350), cornerRadius: 20, alignment: .center)
				}
				.containerize(header: headerBuilder(title: "Cascading Card Stack"))
					
				SlideZoomScroll(data: colors, itemSize: .init(width: 200, height: 200)) { color in
					RoundedRectangle(cornerRadius: 20)
						.fill((color as? Color) ?? .red)
						.frame(width: 200, height: 200)
				}.containerize(header: headerBuilder(title: "Slide Zoom Scroll"))
				
				SlideCardView(data: colors, itemSize: .init(width: 200, height: 200), spacing: 0, leading: false) { color,isSelected in
					RoundedRectangle(cornerRadius: 20)
						.fill((color as? Color) ?? .red)
						.frame(width: 200, height: 200)
						.overlay {
							VStack(alignment: .leading) {
								Spacer()
								if isSelected {
									"isSelected".text
										.transition(.move(edge: .bottom))
										.padding(.bottom,10)
								}
							}
							.frame(width: 200, height: 200)
							.scaleEffect(0.85)
						}
				}.containerize(header: headerBuilder(title: "Slide Card View"))
				
				RoundedButton(model: .init(topLeadingText: "Discovery View".styled(font: .systemFont(ofSize: 15, weight: .bold), color: .black),
										   bottomLeadingText: "Experience it!".styled(font: .systemFont(ofSize: 13, weight: .medium), color: .black),
										   blob: .init(background: .gray.opacity(0.14),
										   padding: 20,
										   cornerRadius: 20))) {
					loadData.toggle()
				}.padding(.horizontal)
				
				RoundedButton(model: .init(topLeadingText: "StackScroll View".styled(font: .systemFont(ofSize: 15, weight: .bold), color: .black),
										   bottomLeadingText: "Experience it!".styled(font: .systemFont(ofSize: 13, weight: .medium), color: .black),
										   blob: .init(background: .gray.opacity(0.14),
										   padding: 20,
										   cornerRadius: 20))) {
					showStackedScroll.toggle()
				}.padding(.horizontal)
			
			}
		}
		.navigationTitle("Animatable Collections")
		.fullScreenModal(isActive: $showDiscoveryView, innerContent: discoveryView)
		.fullScreenModal(isActive: $showStackedScroll, config: .init(isDraggable: true, showCloseIndicator: true), innerContent: stackScrollView)
		.onChange(of: loadData, perform: loadImages(_:))
		.onReceive(randomImageDownload.$images) {
			if !$0.isEmpty {
				withAnimation(.default) {
					self.showDiscoveryView = true
				}
			}
		}
	}
}


extension AnimationCollectionMaster {
	
	var discoveryModel: DiscoveryViewModel {
		.init(cardSize: .init(width: 250, height: 350), rows: 5, spacing:25, bgColor: .black)
	}
	
	@ViewBuilder func discoveryView() -> some View {
		DiscoveryView(data: randomImageDownload.images, model: discoveryModel) { data in
			if let imgData = data as? RandomImage {
				ImageView(url: imgData.optimizedImage(size: .init(width: 250, height: 350)))
					.framed(size: .init(width: 250, height: 350), cornerRadius: 20, alignment: .center)
			} else {
				RoundedRectangle(cornerRadius: 20)
					.fill(.brown)
					.frame(size: .init(width: 250, height: 350))
			}
			
		}
	}
	
	@ViewBuilder func stackScrollView() -> some View {
		StackedScroll(data: [Color.red, Color.blue, Color.green]) { data, _ in
			ExampleView(color: (data as? Color) ?? .black)
		}
	}
}

fileprivate struct ExampleView: View {
	
	let color: Color
	@State var enableScroll: Bool = true
	
	init(color: Color) {
		self.color = color
	}
	
	var mainBody: some View {
		VStack(alignment: .leading, spacing: 20) {
			RoundedButton(model: .testModel)
				.fixedSize(horizontal: false, vertical: true)
				.clipped()
			RoundedButton(model: .testModelLeading)
				.fixedSize(horizontal: false, vertical: true)
				.clipped()
			RoundedButton(model: .testModelTrailing)
				.fixedSize(horizontal: false, vertical: true)
				.clipped()
			RoundedButton(model: .testModelWithBlob) {
				enableScroll.toggle()
			}
				.fixedSize(horizontal: false, vertical: true)
		}
		.padding(.init(top: .safeAreaInsets.top + 50,
					   leading: 20,
					   bottom: .safeAreaInsets.bottom,
					   trailing: 20))
		.frame(width: .totalWidth, height: .totalHeight, alignment: .topLeading)
		.background(color)
		.scrollToggle(state: enableScroll)

		
	}
	
	var body: some View {
		mainBody
	}
}
