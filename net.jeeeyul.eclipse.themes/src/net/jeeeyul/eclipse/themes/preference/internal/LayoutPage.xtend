package net.jeeeyul.eclipse.themes.preference.internal

import net.jeeeyul.eclipse.themes.SharedImages
import net.jeeeyul.eclipse.themes.internal.OSHelper
import net.jeeeyul.eclipse.themes.preference.JTPConstants
import net.jeeeyul.eclipse.themes.preference.JThemePreferenceStore
import net.jeeeyul.eclipse.themes.rendering.JTabSettings
import net.jeeeyul.swtend.SWTExtensions
import org.eclipse.swt.SWT
import org.eclipse.swt.custom.CTabFolder
import org.eclipse.swt.widgets.Composite
import org.eclipse.swt.widgets.Event
import org.eclipse.swt.widgets.Spinner

class LayoutPage extends AbstractJTPreferencePage {
	extension OSHelper = OSHelper.INSTANCE
	Spinner borderRadiusScale
	Spinner paddingsScale
	Spinner tabItemPaddingsScale
	Spinner tabSpacingScale
	Spinner tabItemSpacingScale
	Spinner tabHeightScale

	new() {
		super("Layout")
		this.image = SharedImages.getImage(SharedImages.LAYOUT)
	}

	override createContents(Composite parent, extension SWTExtensions swtExtensions, extension PreperencePageHelper helper) {
		parent.newComposite [
			layout = newGridLayout[
				numColumns = 3
			]
			
			newLabel[text = "Border Radius"]
			borderRadiusScale = newSpinner[
				minimum = 0
				maximum = 10
				selection = 3
				onSelection = [requestFastUpdatePreview()]
				layoutData = newGridData[
					widthHint = 40
				]
			]
			newLabel[
				text="0 ~ 10px"
				foreground = COLOR_DARK_GRAY
			]
			
			newLabel[text = "Tab Item Paddings"]
			tabItemPaddingsScale = newSpinner[
				minimum = 0
				maximum = 10
				selection = 2
				onSelection = [requestFastUpdatePreview()]
				layoutData = newGridData[
					widthHint = 40
				]
			]
			newLabel[
				text = "0 ~ 10px"
				foreground = COLOR_DARK_GRAY
			]
			
			newLabel[text = "Content Paddings"]
			paddingsScale = newSpinner[
				minimum = 0
				maximum = 10
				selection = 2
				onSelection = [requestFastUpdatePreview()]
				layoutData = newGridData[
					widthHint = 40
				]
			]
			newLabel[
				text = "0 ~ 10px"
				foreground = COLOR_DARK_GRAY
			]
			
			newLabel[text = "Tab Spacing"]
			tabSpacingScale = newSpinner[
				minimum = -1
				maximum = 20
				selection = 2
				onSelection = [requestFastUpdatePreview()]
				layoutData = newGridData[
					widthHint = 40
				]
			]
			newLabel[
				text = "-1(overlap) ~ 20px"
				foreground = COLOR_DARK_GRAY
			]
			
			newLabel[text = "Tab Item Spacing"]
			tabItemSpacingScale = newSpinner[
				minimum = 0
				maximum = 10
				selection = 2
				onSelection = [requestFastUpdatePreview()]
				layoutData = newGridData[
					widthHint = 40
				]
			]
			newLabel[
				text = "0 ~ 10px"
				foreground = COLOR_DARK_GRAY
			]
			
			newLabel[text = "Tab Height"]
			tabHeightScale = newSpinner[
				minimum = minimumTabHeight
				maximum = 40
				selection = minimumTabHeight
				onSelection = [requestUpdatePreview()]
				layoutData = newGridData[
					widthHint = 40
				]
			]
			newLabel[
				text = '''«minimumTabHeight» ~ 40px'''
				foreground = COLOR_DARK_GRAY
			]
		]
	}

	override updatePreview(CTabFolder folder, JTabSettings renderSettings, extension SWTExtensions swtExtensions, extension PreperencePageHelper helper) {
		renderSettings.borderRadius = borderRadiusScale.selection
		renderSettings.paddings = newInsets(paddingsScale.selection)
		renderSettings.tabItemPaddings = newInsets(tabItemPaddingsScale.selection)
		renderSettings.tabSpacing = tabSpacingScale.selection
		renderSettings.tabItemHorizontalSpacing = this.tabItemSpacingScale.selection

		folder.tabHeight = tabHeightScale.selection
		folder.notifyListeners(SWT.Resize, new Event())
		folder.layout(true, true)
	}

	override load(JThemePreferenceStore store, extension SWTExtensions swtExtensions, extension PreperencePageHelper helper) {
		this.borderRadiusScale.selection = store.getInt(JTPConstants.Layout.BORDER_RADIUS)
		this.paddingsScale.selection = store.getInt(JTPConstants.Layout.CONTENT_PADDING)
		this.tabHeightScale.selection = Math.max(store.getInt(JTPConstants.Layout.TAB_HEIGHT), minimumTabHeight)

		this.tabSpacingScale.selection = store.getInt(JTPConstants.Layout.TAB_SPACING)

		this.tabItemPaddingsScale.selection = store.getInt(JTPConstants.Layout.TAB_ITEM_PADDING)
		this.tabItemSpacingScale.selection = store.getInt(JTPConstants.Layout.TAB_ITEM_SPACING)
	}

	override save(JThemePreferenceStore store, extension SWTExtensions swtExtensions, extension PreperencePageHelper helper) {
		store.setValue(JTPConstants.Layout.BORDER_RADIUS, this.borderRadiusScale.selection)
		store.setValue(JTPConstants.Layout.CONTENT_PADDING, this.paddingsScale.selection)
		store.setValue(JTPConstants.Layout.TAB_HEIGHT, this.tabHeightScale.selection)
		store.setValue(JTPConstants.Layout.TAB_SPACING, this.tabSpacingScale.selection)
		store.setValue(JTPConstants.Layout.TAB_ITEM_PADDING, this.tabItemPaddingsScale.selection)
		store.setValue(JTPConstants.Layout.TAB_ITEM_SPACING, this.tabItemSpacingScale.selection)
	}

	override dispose(extension SWTExtensions swtExtensions, extension PreperencePageHelper helper) {
	}

}
