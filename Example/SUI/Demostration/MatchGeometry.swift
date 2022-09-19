//
//  MatchGeometry.swift
//  SUI_Example
//
//  Created by Krishna Venkatramani on 18/09/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import SUI

struct MatchGeometry: View {
	@State var showChild: Bool = false
	@Namespace var animation
    var body: some View {
		HStack(alignment: .center, spacing: 10) {
			if !showChild {
					Circle()
					.fill(Color.red)
					.matchedGeometryEffect(id: "example", in: animation)
					.framed(size: .init(squared: 25))
			}
			
			Spacer()
			
			"Switch"
				.systemBody(color: .white)
				.text
				.padding(.init(vertical: 10, horizontal: 15))
				.background(Color.black)
				.clipContent(radius: 16)
				.animatableBorder(pct: showChild ? 1 : 0, cornerRadius: 16)
				.buttonify {
					showChild.toggle()
				}
			
			Spacer()
			
			if showChild {
				RoundedRectangle(cornerRadius: 20)
					.fill(Color.teal)
					.matchedGeometryEffect(id: "example", in: animation)
					.framed(size: .init(squared: 100))
			}
		}
		.padding()
		.fillWidth(alignment: .center)
		.background(Color.blue)
    }
}

struct MatchGeometry_Previews: PreviewProvider {
    static var previews: some View {
        MatchGeometry()
    }
}
