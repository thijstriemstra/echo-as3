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
	import com.collab.echo.view.display.util.StyleDict;
	import com.collab.echo.view.display.util.TextUtils;
	import com.greensock.TweenLite;
	
	import flash.display.Shape;
	import flash.text.TextField;
	
	/**
	 * @author Thijs Triemstra
	 */	
	public class UserCursor extends BaseView
	{
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _cursor		: Shape;
		private var _label		: TextField;
		private var _username	: String;
		
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
			
			TweenLite.to( this, 1, { alpha: 1 });
		}
		
		/**
		 * @private 
		 */		
		override public function hide():void
		{
			TweenLite.to( this, 1, { alpha: 0 });
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
			_label = TextUtils.createTextField( null, _username, 15 );
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