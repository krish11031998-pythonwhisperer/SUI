//
//  AnimationsMaster.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 09/09/2022.
//

import SwiftUI
import SUI

struct AnimationsMaster: View {
	
	@State var shakes: CGFloat = 0
	@State var pct: CGFloat = .zero
	@State var showList: Bool = false
	
	var data: [String] = ["Curve Chart with Animatable"]
	
	var redText: some View {
		"Hello There!"
			.styled(font: .systemFont(ofSize: 15, weight: .medium), color: .white)
			.text
			.padding()
			.background(Color.red)
			.clipShape(Capsule())
	}
	
	var workList: some View {
		VStack(alignment: .leading, spacing: 10) {
			HStack(alignment: .center, spacing: 10) {
				"List of things at work".styled(font: .systemFont(ofSize: 20, weight: .bold), color: .black).text
				Spacer()
				CustomButton(config: .init(imageName: .close)) {
					asyncMainAnimation {
						self.showList.toggle()
					}
				}
			}
			Spacer().frame(height: 10, alignment: .center)
			ForEach(data, id: \.self) { text in
				text.styled(font: .systemFont(ofSize: 20, weight: .medium), color: .black).text
			}
		}
		.padding()
	}
	
	
    var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			redText
				.fillWidth(alignment: .center)
				.onTapGesture {
					withAnimation(.easeInOut(duration: 1.5)) {
						self.shakes += 5
					}
				}
				.shakeView(shakes: shakes)
				.containerize(header: HeaderCaptionView(title: "Shake Effect", subTitle: "w/ Animtable", spacing: 0, alignment: .center).anyView)
				.padding()
				
			RoundedRectangle(cornerRadius: 20)
				.fill(Color.gray.opacity(0.5))
				.horizontalProgressBar(pct: pct, size: .init(width: .totalWidth - 30, height: 20))
				.containerize(header: HeaderCaptionView(title: "Horizontal Progress Bar", subTitle: "Click for animation").anyView)
				.frame(height: 20, alignment: .leading)
				.padding()
				.onTapGesture {
					withAnimation(.default) {
						self.pct = self.pct == 1 ? 0 : 1
					}
				}
			
			Circle()
				.fill(Color.cyan.opacity(0.15))
				.frame(size: .init(squared: 200))
				.clipped()
				.circularProgressBar(pct: pct, lineWidth: 10, lineColor: .red, size: .init(squared: 200))
				.containerize(header: HeaderCaptionView(title: "Circular Progress Bar", subTitle: "Click for animation").anyView)
				.padding()
			
			RoundedButton(model: .init(trailingImg: .init(img: .init(systemName: "hand.thumbsup"), size: .init(squared: 15), cornerRadius: 0),
									   topLeadingText: "More to come!".styled(font: .systemFont(ofSize: 15, weight: .bold), color: .black),
									   bottomLeadingText: "Stay tuned".styled(font: .systemFont(ofSize: 13, weight: .medium), color: .black),
									   blob: .init(background: .gray.opacity(0.15), padding: 20, cornerRadius: 20))) {
				showList = true
			}
			.padding()
		}
		.slideInFromBottomModal(showModal: $showList, modalConfig: .defaultConfig, modal: {
			workList
		})
		.edgesIgnoringSafeArea(.bottom)
		.navigationTitle("Animations")
		.navigationBarTitleDisplayMode(.inline)
    }
}

struct AnimationsMaster_Previews: PreviewProvider {
    static var previews: some View {
        AnimationsMaster()
    }
}
