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
package com.collab.echo.containers.panels
{
	import com.collab.cabin.core.UIComponent;
	import com.collab.cabin.display.util.DrawingUtils;
	import com.collab.cabin.display.util.StyleDict;
	import com.collab.echo.controls.MenuBar;
	
	import flash.display.Sprite;
	
	/**
	 * Panel containing a MenuBar.
	 * 
	 * @see com.collab.echo.controls.MenuBar
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class MenuPanel extends UIComponent
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		private static const BAR_HEIGHT		: int = 50;
		
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		protected var background			: Sprite;
		protected var bar 					: MenuBar;
		protected var menuItems				: Array;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		/**
		 * @return 
		 */		
		public function get dataProvider():Array
		{
			return menuItems;
		}
		public function set dataProvider( val:Array ):void
		{
			if ( val )
			{
				menuItems = val;
				invalidate()
			}
		}
		
		/**
		 * Constructor.
		 *  
		 * @param width
		 * @param height
		 */		
		public function MenuPanel( width:Number=0, height:Number=0 )
		{
			super( width, height );
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * Instantiate and add child(ren) to display list.
		 * 
		 * @private
		 */	
		override protected function draw() : void
		{
			// background
			background = DrawingUtils.drawFill( viewWidth, viewHeight,
												 0, StyleDict.WHITE, 1 ); 
			addChild( background );
			
			// bar
			bar = new MenuBar( viewWidth, 30 );
			bar.dataProvider = menuItems;
			addChild( bar );
		}
		
		/**
		 * Position child(ren) on display list.
		 * 
		 * @private
		 */
		override protected function layout():void
		{
			// background
			background.x = 0;
			background.y = 0;
			
			// bar
			bar.x = 0;
			bar.y = 0;
		}
		
		/**
		 * Remove and redraw child(ren).
		 * 
		 * @private
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( background );
			removeChildFromDisplayList( bar );
			
			super.invalidate();
		}
		
	}
}