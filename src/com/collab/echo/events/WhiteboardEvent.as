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
package com.collab.echo.events
{
	import flash.events.Event;
	
	/**
	 * Whiteboard event.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class WhiteboardEvent extends Event
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		public static const NAME				: String = "WhiteboardEvent";
		public static const UNDO				: String = NAME + "_undo";
		public static const CHANGE_COLOR		: String = NAME + "_changeColor";
		public static const CHANGE_THICKNESS	: String = NAME + "_changeThickness";
		public static const DRAW_LINE			: String = NAME + "_drawLine";
		public static const SEND_LINE			: String = NAME + "_sendLine";
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _color						: uint;
		private var _thickness					: Number;
		private var _line						: String;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		/**
		 * Contains a value when <code>CHANGE_COLOR</code> is dispatched.
		 * 
		 * @return 
		 */		
		public function get color():uint
		{
			return _color;
		}
		public function set color( val:uint ):void
		{
			_color = val;
		}
		
		/**
		 * Contains a value when <code>CHANGE_THICKNESS</code> is dispatched.
		 * 
		 * @return 
		 */		
		public function get thickness():Number
		{
			return _thickness;
		}
		public function set thickness( val:Number ):void
		{
			_thickness = val;
		}
		
		/**
		 * @return 
		 */		
		public function get line():String
		{
			return _line;
		}
		public function set line( val:String ):void
		{
			if ( val )
			{
				_line = val;
			}
		}
		
		/**
		 * Constructor.
		 *  
		 * @param type
		 */		
		public function WhiteboardEvent( type:String )
		{
			super( type, true, true );
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		override public function toString():String
		{
			return "<WhiteboardEvent type='" + type + "' color='" + _color +
				   "' thickness='" + _thickness + "' />";
		}
		
	}
}