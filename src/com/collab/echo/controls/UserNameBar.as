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
	import com.collab.cabin.core.UIComponent;
	import com.collab.echo.display.util.DrawingUtils;
	import com.collab.echo.display.util.StyleDict;
	import com.collab.echo.display.util.TextUtils;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * Username bar.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class UserNameBar extends UIComponent
	{
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		/**
		 * 
		 */		
		protected var background		: Sprite;
		
		/**
		 * 
		 */		
		protected var nameField			: TextField;
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _title				: String;
		
		/**
		 * Constructor.
		 *  
		 * @param width
		 * @param height
		 */		
		public function UserNameBar( width:Number=0, height:Number=0, name:String=null )
		{
			_title = name;
			
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
			background = DrawingUtils.drawFill( viewWidth, viewHeight, 0, StyleDict.WHITE );
			background.buttonMode = true;
			addChild( background );
			
			// name
			nameField = TextUtils.createTextField( null, _title, 15, StyleDict.BLACK, false, true );
			addChild( nameField );
		}
		
		/**
		 * @private 
		 */		
		override protected function layout():void
		{
			// background
			background.x = 0;
			background.y = 0;
			
			// name
			nameField.x = viewWidth - ( nameField.width + 10 );
			nameField.y = 5;
		}
		
		/**
		 * @private 
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( background );
			removeChildFromDisplayList( nameField );
			
			super.invalidate();
		}
		
	}
}