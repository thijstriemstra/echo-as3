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
	import com.collab.cabin.display.util.StyleDict;
	import com.collab.cabin.display.util.TextUtils;
	import com.greensock.TweenLite;
	
	import flash.display.Shape;
	import flash.text.TextField;
	
	/**
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class UserCursor extends UIComponent
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		private static const FADE_TIME	: int = .5;
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _cursor				: Shape;
		private var _label				: TextField;
		private var _username			: String;
		
		/**
		 * Constructor.
		 *  
		 * @param username
		 */		
		public function UserCursor( username:String=null )
		{
			_username = username;
			
			mouseChildren = false;
			mouseEnabled = false;
			alpha = 0;
			
			super();
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * @private 
		 */		
		override public function show():void
		{
			super.show();
			
			TweenLite.to( this, FADE_TIME, { alpha: 1 });
		}
		
		/**
		 * @private 
		 */		
		override public function hide():void
		{
			TweenLite.to( this, FADE_TIME, { alpha: 0 });
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * @private 
		 */		
		override protected function draw():void
		{
			// cursor
			_cursor = new Shape();
			_cursor.graphics.beginFill( StyleDict.BLACK, 1 );
			_cursor.graphics.drawRect( 0, 0, 5, 5 );
			_cursor.graphics.endFill();
			addChild( _cursor );
			
			// textfield
			_label = TextUtils.createTextField( null, _username.toUpperCase(),
												12 );
			addChild( _label );
		}
		
		/**
		 * @private 
		 */		
		override protected function layout():void
		{
			// cursor
			_cursor.x = 0;
			_cursor.y = 0;
			
			// label
			_label.x = _cursor.x + _cursor.width;
			_label.y = _cursor.y + ( _cursor.height / 2 );
		}
		
		/**
		 * @private 
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( _cursor );
			removeChildFromDisplayList( _label );
			
			super.invalidate();
		}
		
	}
}