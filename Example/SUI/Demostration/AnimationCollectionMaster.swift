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
	
	@StateObject var randomImageDownload: RandomImagesDownloaders = .init(endPoint: .list(page: Int.random(in: 0...5), limit: 25))
	
	func headerBuilder(title: String, subTitle: String? = nil) -> AnyView {
		HStack(alignment: .center, spacing: 10) {
			title.text
				.padding(10)
				.borderCard(borderColor: .red, radius: 8, borderWidth: 1)
			Spacer()
			if let validSubTitle = subTitle {
				validSubTitle.text
			}
		}.padding()
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
							.styled(font: .systemFont(ofSize: 14, weight: .medium), color: .black)
							.text
						Spacer()
					}
					.padding()
					.frame(size: .init(width: .totalWidth - 20, height: 200))
					.background((color as? Color) ?? .black)
					.clipContent(radius: 16)
				}
				.containerize(header: headerBuilder(title: "Slide Over Carousel"))

				CascadingCardStack(data: colors, offFactor: .totalWidth.half.half) { color in
					RoundedRectangle(cornerRadius: 20)
						.fill((color as? Color) ?? .red)
						.frame(width: 200, height: 350)
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
				}.padding()
				RoundedButton(model: .init(topLeadingText: "StackScroll View".styled(font: .systemFont(ofSize: 15, weight: .bold), color: .black),
										   bottomLeadingText: "Experience it!".styled(font: .systemFont(ofSize: 13, weight: .medium), color: .black),
										   blob: .init(background: .gray.opacity(0.14),
										   padding: 20,
										   cornerRadius: 20))) {
					showStackedScroll.toggle()
				}.padding()
			
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
		StackedScroll(data: [Color.red, Color.blue, Color.green]) { data in
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
				RoundedButton(model: .testModelWithBlob)
					.fixedSize(horizontal: false, vertical: true)
			}
			.padding(.init(top: .safeAreaInsets.top + 50, leading: 20, bottom: .safeAreaInsets.bottom, trailing: 20))
			.frame(width: .totalWidth, height: .totalHeight, alignment: .topLeading)
			.background((data as? Color) ?? .black)
		}

	}
}
