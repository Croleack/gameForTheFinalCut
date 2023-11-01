//
//  SettingsScreenCellBuilder.swift
//  gameForTheFinalCut
//
//  Created by Enzhe Gaysina on 01.11.2023.
//

import UIKit

class SettingsScreenCellBuilder {
    
    typealias DelegateAlias = (UITextFieldDelegate & CustomButtonViewCellDelegateProtocol)?
    
    func buildCell(tableView: UITableView, indexPath: IndexPath, delegate: DelegateAlias) -> SettingsCellCommonProtocol {
	   guard let sectionType = SectionType(rawValue: indexPath.section) else {
		  return UITextFieldCell()
	   }
	   
	   let sectionData = MockData.sections[sectionType]
	   let item = sectionData?.sectionItems[indexPath.row]
	   
	   if sectionType == .general {
		  if let cell = tableView.dequeueReusableCell(
			 withIdentifier: UITextFieldCell.identifier,
			 for: indexPath
		  ) as? UITextFieldCell {
			 cell.textField.delegate = delegate
			 return cell
		  }
	   } else if sectionType == .updateImage {
		  if let cell = tableView.dequeueReusableCell(
			 withIdentifier: CustomButtonViewCell.identifier,
			 for: indexPath
		  ) as? CustomButtonViewCell {
			 cell.delegate = delegate
			 return cell
		  }
	   } else {
		  if let cell = tableView.dequeueReusableCell(
			 withIdentifier: CustomViewCell.identifier,
			 for: indexPath
		  ) as? CustomViewCell {
			 return cell
		  }
	   }
	   return UITextFieldCell()
    }
}
