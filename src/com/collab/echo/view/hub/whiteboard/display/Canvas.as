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
package com.collab.echo.view.hub.whiteboard.display
{
	import com.collab.echo.view.display.BaseView;
	import com.collab.echo.view.display.util.DrawingUtils;
	import com.collab.echo.view.display.util.StyleDict;
	
	import flash.display.Sprite;
	
	/**
	 * Whiteboard canvas.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class Canvas extends BaseView
	{
		private var _background	: Sprite;
		
		/**
		 * Constructor.
		 *  
		 * @param width
		 * @param height
		 */		
		public function Canvas( width:int=0, height:int=0 )
		{
			super( width, height );
			show();
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
			_background = DrawingUtils.drawFill( viewWidth, viewHeight, 0,
												 StyleDict.YELLOW1, 1 );
			addChild( _background );
		}
		
		/**
		 * @private 
		 */		
		override protected function layout():void
		{
			// background
			_background.x = 0;
			_background.y = 0;
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