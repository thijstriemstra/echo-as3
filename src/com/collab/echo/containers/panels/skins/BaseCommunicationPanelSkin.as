/*
Echo project.

Copyright (C) 2003-2010 Collab

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
package com.collab.echo.containers.panels.skins
{
	import com.collab.echo.containers.panels.UserPanel;
	import com.collab.echo.containers.scrollpane.FlashScrollPane;
	import com.collab.echo.containers.scrollpane.UserScrollPane;
	import com.collab.echo.controls.buttons.BaseExpandButton;
	import com.collab.echo.display.util.SkinUtils;
	import com.collab.echo.view.hub.chat.display.Chat;
	import com.collab.echo.view.hub.translator.display.Translator;
	import com.collab.echo.view.hub.whiteboard.display.Whiteboard;

	/**
	 * Base skin for the <code>CommunicationPanel</code>.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class BaseCommunicationPanelSkin
	{
		// ====================================
		// CONSTANTS
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