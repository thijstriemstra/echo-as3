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
package com.collab.echo.controls.painter
{
	import com.collab.echo.controls.UserCursor;
	import com.collab.echo.model.UserVO;
	
	/**
	 * Remote user of the whiteboard.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class RemotePainter extends Painter
	{
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _cursor		: UserCursor;
		
		/**
		 * Constructor.
		 *  
		 * @param data
		 */		
		public function RemotePainter( data:UserVO=null )
		{
			super( data );
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
			
			if ( _cursor )
			{
				_cursor.show();
			}
		}
		
		/**
		 * @private 
		 */		
		override public function hide():void
		{
			if ( _cursor )
			{
				_cursor.hide();
			}
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
			if ( data )
			{
				_cursor = new UserCursor( data.username );
				addChild( _cursor );
			}
		}
		
		/**
		 * @private 
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( _cursor );
			
			super.invalidate();
		}
		
		/**
		 * @private 
		 */		
		override protected function layout():void
		{
			// cursor
			if ( _cursor )
			{
				_cursor.x = 0;
				_cursor.y = 0;
			}
		}
		
	}
}