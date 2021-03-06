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
package com.collab.echo.containers
{
	import com.collab.cabin.display.util.DrawingUtils;
	import com.collab.cabin.display.util.StyleDict;
	import com.collab.cabin.display.util.TextUtils;
	import com.collab.echo.containers.panels.MenuPanel;
	
	import flash.text.TextField;
	
	/**
	 * Language translator component.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class Translator extends MenuPanel
	{
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		internal var label	: TextField;
		
		/**
		 * Constructor.
		 *  
		 * @param width
		 * @param height
		 */		
		public function Translator( width:Number=0, height:Number=0 )
		{
			super( width, height );
			show();
		}
		
		// ====================================
		// PUBLIC/PROTECTED METHODS
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
			
			// label
			label = TextUtils.createTextField( null, "Translator!", 12, StyleDict.BLACK );
			addChild( label );
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
			
			// label
			label.x = 25;
			label.y = 20;
		}
		
		/**
		 * Remove and redraw child(ren).
		 * 
		 * @private
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( background );
			removeChildFromDisplayList( label );
			
			super.invalidate();
		}
		
	}
}