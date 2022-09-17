//
//  TextFieldDemo.swift
//  SUI_Example
//
//  Created by Krishna Venkatramani on 17/09/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import SUI

struct TextFieldDemo: View {
	
    var body: some View {
		ScrollView {
			CustomTextField(config: .init(accentColor: .black,
										  foregroundColor: .black,
										  font: .system(size: 20),
										  insets: .init(vertical: 10, horizontal: 10),
										  placeHolder: "Placeholder".systemBody(),
										  borderColor: .purple,
										  borderWidth: 2,
										 cornerRadius: 20))
			.padding()
			.containerize(title: "TextField".systemHeading1(), subTitle: "Configurable".systemSubHeading(), style: .headCaption)
		}
		
		.navigationTitle("TextField")
    }
}

struct TextFieldDemo_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldDemo()
    }
}
