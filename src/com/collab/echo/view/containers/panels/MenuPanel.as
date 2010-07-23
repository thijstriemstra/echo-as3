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
package com.collab.echo.view.containers.panels
{
	import com.collab.echo.view.controls.MenuBar;
	import com.collab.echo.view.controls.menu.MenuItem;
	import com.collab.echo.view.display.BaseView;
	import com.collab.echo.view.display.util.DrawingUtils;
	import com.collab.echo.view.display.util.StyleDict;
	
	import flash.display.Sprite;
	
	/**
	 * @author Thijs Triemstra
	 */	
	public class MenuPanel extends BaseView
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
			background = DrawingUtils.drawFill( viewWidth, viewHeight - BAR_HEIGHT,
												 0, StyleDict.GREEN1, 0 ); 
			addChild( background );
			
			// bar
			bar = new MenuBar( MenuItem );
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
			background.y = BAR_HEIGHT;
			
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