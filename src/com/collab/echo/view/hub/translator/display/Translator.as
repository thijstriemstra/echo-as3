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
package com.collab.echo.view.hub.translator.display
{
	import com.collab.echo.view.containers.panels.MenuPanel;
	import com.collab.echo.view.display.util.DrawingUtils;
	import com.collab.echo.view.display.util.StyleDict;
	import com.collab.echo.view.display.util.TextUtils;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * @author Thijs Triemstra
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
												0, StyleDict.RED1, 1 ); 
			addChild( background );
			
			// label
			label = TextUtils.createTextField( null, "Translator", 20, StyleDict.WHITE );
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