/*
Echo project.

Copyright (C) 2003-2011 Collab

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
package com.collab.echo.containers.skins
{
	import com.collab.cabin.containers.scrollpane.FlashScrollPane;
	import com.collab.cabin.display.util.SkinUtils;
	import com.collab.echo.containers.Chat;
	import com.collab.echo.containers.Translator;
	import com.collab.echo.containers.Whiteboard;
	import com.collab.echo.containers.panels.UserPanel;
	import com.collab.echo.containers.scrollpane.UserScrollPane;
	import com.collab.echo.controls.buttons.BaseExpandButton;
	
	import fl.core.ComponentShim;

	// XXX: make sure the skin classes from the swc are imported
	ScrollPane_upSkin;
	ScrollPane_disabledSkin;
	Button_upSkin;
	Button_downSkin;
	Button_overSkin;
	Button_disabledSkin;
	Button_selectedDisabledSkin;
	Button_selectedUpSkin;
	Button_selectedDownSkin;
	Button_selectedOverSkin;
	Button_emphasizedSkin;
	ScrollTrack_skin;
	ScrollThumb_upSkin;
	ScrollThumb_overSkin;
	ScrollThumb_downSkin;
	ScrollArrowDown_disabledSkin;
	ScrollArrowDown_downSkin;
	ScrollArrowDown_overSkin;
	ScrollArrowDown_upSkin;
	ScrollArrowUp_upSkin;
	ScrollArrowUp_downSkin;
	ScrollArrowUp_overSkin;
	ScrollArrowUp_disabledSkin;
	ScrollBar_thumbIcon;
	TextArea_upSkin;
	TextArea_disabledSkin;
	TextInput_upSkin;
	TextInput_disabledSkin;
	ColorPicker_upSkin;
	ColorPicker_backgroundSkin;
	ColorPicker_colorWell;
	ColorPicker_disabledSkin;
	ColorPicker_downSkin;
	ColorPicker_overSkin;
	ColorPicker_swatchSelectedSkin;
	ColorPicker_swatchSkin;
	ColorPicker_textFieldSkin;
	ComponentShim;
	SliderThumb_disabledSkin;
	SliderThumb_downSkin;
	SliderThumb_overSkin;
	SliderThumb_upSkin;
	SliderTick_skin;
	SliderTrack_disabledSkin;
	SliderTrack_skin;
	CellRenderer_disabledSkin;
	CellRenderer_downSkin;
	CellRenderer_overSkin;
	CellRenderer_selectedDisabledSkin;
	CellRenderer_selectedDownSkin;
	CellRenderer_selectedOverSkin;
	CellRenderer_selectedUpSkin;
	CellRenderer_upSkin;
	List_skin;
	focusRectSkin;
    
	/**
	 * Base skin for the Hub.
	 * 
	 * @see com.collab.echo.containers.Hub Hub
	 *
	 * @langversion 3.0
     * @playerversion Flash 9
     * 
	 * @author Thijs Triemstra
	 */	
	public class HubSkin
	{
		// fonts
		[Embed(source='/usr/share/fonts/truetype/msttcorefonts/Arial.ttf', 
        	fontName='Arial', 
        	mimeType='application/x-font',
        	embedAsCFF='true'
     	)]
		// You do not use this variable directly. It exists so that 
		// the compiler will link in the font.
		private var arial:Class;
		
		// ====================================
		// CLASS CONSTANTS
		// ====================================

		public static const PANE				: Class = FlashScrollPane;
		public static const USER_SCROLL_PANE	: Class = UserScrollPane;
		public static const WHITEBOARD			: Class = Whiteboard;
		public static const CHAT				: Class = Chat;
		public static const TRANSLATOR			: Class = Translator;
		public static const EXPAND_BUTTON		: Class = BaseExpandButton;
		public static const USER_PANEL			: Class = UserPanel;
		
		// ====================================
		// STATIC METHODS
		// ====================================
		
		/**
		 * @return 
		 */		
		public static function getSkin():Object
		{
			var obj:Object = new Object();
			obj.pane = SkinUtils.getSkinClass( PANE );
			obj.userPane = SkinUtils.getSkinClass( USER_SCROLL_PANE );
			obj.whiteboard = SkinUtils.getSkinClass( WHITEBOARD );
			obj.chat = SkinUtils.getSkinClass( CHAT );
			obj.translator = SkinUtils.getSkinClass( TRANSLATOR );
			obj.expandButton = SkinUtils.getSkinClass( EXPAND_BUTTON );
			obj.userPanel = USER_PANEL;
			
			return obj;
		}
		
	}
}