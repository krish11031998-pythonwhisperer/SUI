//
//  ContentView.swift
//  StyleUI
//
//  Created by Krishna Venkatramani on 05/09/2022.
//

import SwiftUI
import SUI

struct ContentView: View {
	@EnvironmentObject var appStates: MainAppStates
	@State var paddingHeight: CGFloat = .zero
	
	var animationView: some View {
		AnimationCollectionMaster()
	}
	
	init() {
		
	}
	
	var navBarAppearance: UINavigationBarAppearance {
		let navAppearance = UINavigationBarAppearance()
		navAppearance.backgroundColor = .purple
		navAppearance.shadowColor = .clear
		navAppearance.titleTextAttributes = [.foregroundColor : UIColor.white]
		navAppearance.largeTitleTextAttributes = [.foregroundColor : UIColor.white]
		return navAppearance
	}
	
	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			VStack(alignment: .leading, spacing: 20) {
				HeaderSubHeadView(title: "Animated Collections".systemHeading1(),
								  subTitle: "Here you can see all the animatable fancy collections".systemSubHeading())
					.buttonify {
						self.appStates.showAnimation.toggle()
					}
				HeaderSubHeadView(title: "Image".systemHeading1(),
								  subTitle: "Every thing you can do with an image".systemSubHeading())
					.buttonify {
						self.appStates.imageView.toggle()
					}
				HeaderSubHeadView(title: "Rounded Button".systemHeading1(),
								  subTitle: "Custom Rounded Button with custom Config".systemSubHeading())
					.buttonify {
						self.appStates.roundedButton.toggle()
					}
				
				HeaderSubHeadView(title: "Custom NavBar (Work in Progress)".systemHeading1(),
								  subTitle: "Custom Navigation Bar".systemSubHeading())
					.buttonify {
						self.appStates.navBar.toggle()
					}

				HeaderSubHeadView(title: "Animation".systemHeading1(),
								  subTitle: "All Animations".systemSubHeading())
					.buttonify {
						self.appStates.animations.toggle()
					}

				
			}.padding()
				.frame(maxWidth: .infinity, alignment: .leading)
			
			
			animatedCollectionsLink
			imageNavLink
			roundedButtonLink
			customNavBarLink
			animationsNavLink
		}
		.navigationBarHidden(true)
		.customNavbarAppearance(navbarAppearance: navBarAppearance)
	}
}

extension ContentView {
	
	var animatedCollectionsLink: some View {
		NavLink(isActive: $appStates.showAnimation) {
			AnimationCollectionMaster()
		}
	}
	
	var imageNavLink: some View {
		NavLink(isActive: $appStates.imageView, titleView: {
			HStack(alignment: .center, spacing: 5) {
				ImageView(url: UIImage.testImage).framed(size: .init(squared: 30), cornerRadius: 2.5, alignment: .center)
				"Overriden - Image Views".styled(font: .systemFont(ofSize: 15, weight: .bold), color: .white).text
			}.anyView
		}) {
			ImageComponents()
		}
	}
	
	var roundedButtonLink: some View {
		NavLink(isActive: $appStates.roundedButton) {
			ButtonComponents()
		}
	}
	
	var leftBar: some View{
		HStack(alignment: .center, spacing: 5) {
			CustomButton(config: .init(imageName: .back)) {
				print("(DEBUG) clicked on backButton")
				appStates.navBar.toggle()
			}
		}
	}
	
	var rightBar: some View{
		HStack(alignment: .center, spacing: 5) {
			CustomButton(config: .init(imageName: .next)) {
				print("(DEBUG) clicked on nextButton")
			}
		}
	}
	
	var titleView: some View {
		HStack(alignment: .center, spacing: 10) {
			ImageView(url: UIImage.testImage)
				.framed(size: .init(squared: 35), cornerRadius: 5, alignment: .center)
			HeaderSubHeadView(title: "Header", subTitle: "SubTitle", spacing: 10, alignment: .center).padding(.vertical,0)
		}
	}
	
	var customNavBarLink: some View {
		NavLink(isActive: $appStates.navBar) {
			CustomNavView(navBarStyling: .init(color: .purple, style: .rounded(16))) {
				titleView
			} leftItem: {
				leftBar
			} rightItem: {
				rightBar
			} content: {
				ScrollView(.vertical, showsIndicators: false) {
					RoundedButton(model: .testModelLeading)
						.padding(.horizontal)
						.containerize(header: HeaderCaptionView(title: "Rounded Button", subTitle: "w/ Leading Image").padding().anyView)
					
					RoundedButton(model: .testModelTrailing)
						.padding(.horizontal)
						.containerize(header: HeaderCaptionView(title: "Rounded Button", subTitle: "w/ Trailing Image").padding().anyView)
						
					RoundedButton(model: .testModel)
						.padding(.horizontal)
						.containerize(header: HeaderCaptionView(title: "Rounded Button", subTitle: "w/o Image").padding().anyView)
					
					RoundedButton(model: .testModelWithBlob)
						.padding(.horizontal)
						.containerize(header: HeaderCaptionView(title: "Rounded Button", subTitle: "w/ Blob").padding().anyView)
				}
			}

		}
	}
	
	var animationsNavLink: some View {
		NavLink(isActive: $appStates.animations) {
			AnimationsMaster()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
