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
package com.collab.echo.controls
{
	import com.collab.cabin.controls.Menu;
	import com.collab.cabin.controls.menu.MenuBarItem;
	import com.collab.cabin.controls.menu.MenuDirection;
	import com.collab.cabin.display.util.StyleDict;
	
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * Menu bar.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class MenuBar extends Menu
	{
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _background			: Sprite;
		
		/**
		 * Constructor.
		 * 
		 * @param width
		 * @param height
		 * @param itemType
		 */		
		public function MenuBar( width:int=0, height:int=0, itemType:Class=null )
		{
			if ( itemType == null )
			{
				itemType = MenuBarItem;
			}
			
			super( itemType, MenuDirection.HORIZONTAL, new Point( 7, 7 ), 8 );
			
			viewWidth = width;
			viewHeight = height;
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * @private 
		 */		
		override protected function draw():void
		{
			// background
			_background = new Sprite();
			_background.graphics.beginFill( StyleDict.GREY2, 1 );
			_background.graphics.drawRect( 0, 0, viewWidth, viewHeight );
			_background.graphics.endFill();
			addChild( _background );
			
			super.draw();
		}
		
		/**
		 * @private 
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( _background );
			
			super.invalidate();
		}
		
	}
}