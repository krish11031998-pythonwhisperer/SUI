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
	
	@State var commitText: String = ""
	@State var editText: String = ""
	
	let searchFieldConfig: CustomTextFieldConfig = {
		.init(accentColor: .black,
			  foregroundColor: .black,
			  font: .system(size: 20),
			  insets: .init(vertical: 10, horizontal: 10),
			  placeHolder: "Placeholder".systemBody(),
			  borderColor: .purple,
			  borderWidth: 2,
			  cornerRadius: 20)
	}()
	
    var body: some View {
		ScrollView {
			CustomTextField(config: searchFieldConfig) { editText in
				withAnimation {
					self.editText = editText
				}
			} searchOnCommit: { commitText in
				withAnimation {
					self.commitText = commitText
				}
			}
			.padding()
			.containerize(title: "TextField".systemHeading1(), subTitle: "Configurable".systemSubHeading(), style: .headCaption)
			
			"onEditting : \(editText)".systemBody().text.padding(.init(vertical: 10, horizontal: 16)).fillWidth(alignment: .leading)
			"onCommit: \(commitText)".systemBody().text.padding(.init(vertical: 10, horizontal: 16)).fillWidth(alignment: .leading)
		}
		
		.navigationTitle("TextField")
    }
}

struct TextFieldDemo_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldDemo()
    }
}
