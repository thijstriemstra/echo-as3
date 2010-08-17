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
package com.collab.echo.controls.menu
{
	import com.collab.cabin.display.util.StyleDict;

	/**
	 * The MenuBarItem class defines the default item renderer for the top-level
	 * menu bar of a MenuBar control.
	 * 
	 * By default, the item renderer draws the text associated with each item in
	 * the top-level menu bar.
	 * 
	 * @see com.collab.echo.controls.MenuBar
	 * @see com.collab.echo.controls.Menu
	 * 
	 * @author Thijs Triemstra
	 * @langversion 3.0
	 * @playerversion Flash 9
	 */	
	public class MenuBarItem extends MenuItem
	{
		/**
		 * Constructor.
		 * 
		 * @param index
		 * @param label
		 */		
		public function MenuBarItem( index:int=0, label:String=null )
		{
			super( index, label );
			
			this.upColor = StyleDict.WHITE;
			this.selectColor = StyleDict.GREY4;
			this.backgroundColor = StyleDict.YELLOW1;
			this.backgroundAlpha = 0;
		}
		
	}
}