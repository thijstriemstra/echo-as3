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
package com.collab.echo.display
{
	import flash.system.Capabilities;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	/**
	 * Right-click menu.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class AppContextMenu
	{
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		private var _playerVersion			: String;
		public function get playerVersion() : String
		{
			return _playerVersion;
		}
		
		private var _title					: String;
		public function get title() 		: String
		{
			return _title;
		}
		
		private var _menu					: ContextMenu;
		public function get data()			: ContextMenu
		{
			return _menu;
		}
		
		/**
		 * Constructor.
		 * 
		 * @param title
		 */		
		public function AppContextMenu( title:String="Untitled App" )
		{
			_title = title;
			
			_playerVersion = Capabilities.playerType;
			if ( Capabilities.isDebugger )
			{
				_playerVersion = "Debugger " + _playerVersion;
			}

			_playerVersion = Capabilities.manufacturer + " " +
							 Capabilities.version + " (" +
							 _playerVersion + ")";

			draw();
		}
		
		// ====================================
		// PRIVATE METHODS
		// ====================================
		
		/**
		 * Create custom menu. 
		 */		
		private function draw():void
		{
			var item1:ContextMenuItem = new ContextMenuItem( _title, true, true, true );
			_menu = new ContextMenu();
			_menu.hideBuiltInItems();
			_menu.customItems.push( item1 );
		}

	}
}