//
//  RoundedButton.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 07/09/2022.
//

import SwiftUI
import SUI

struct RoundedButtonComponents: View {
	@State var showModal: Bool = false
	@State var showFullScreen: Bool = false
	
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
					RoundedButton(model: .testModelLeading)
						.padding(.horizontal)
						.containerize(header: HeaderCaptionView(title: "Rounded Button", subTitle: "w/ Leading Image").padding().anyView)
					
					RoundedButton(model: .testModelTrailing)
						.padding(.horizontal)
						.containerize(header: HeaderCaptionView(title: "Rounded Button", subTitle: "w/ Trailing Image").padding().anyView)
						
					RoundedButton(model: .testModel) {
						self.showFullScreen.toggle()
					}
					.padding(.horizontal)
					.containerize(header: HeaderCaptionView(title: "Rounded Button", subTitle: "w/o Image").padding().anyView)
					
					RoundedButton(model: .testModelWithBlob) {
						self.showModal.toggle()
					}
					.padding(.horizontal)
					.containerize(header: HeaderCaptionView(title: "Rounded Button", subTitle: "w/ Blob").padding().anyView)
				}
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



struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButtonComponents()
    }
}
