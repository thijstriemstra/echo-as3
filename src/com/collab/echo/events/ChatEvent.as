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
	 * Chat event.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class ChatEvent extends Event
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		public static const NAME				: String = "ChatEvent";
		
		public static const SUBMIT				: String = NAME + "_submit";
		public static const HISTORY_UP			: String = NAME + "_historyUp";
		public static const HISTORY_DOWN		: String = NAME + "_historyDown";
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _data						: String;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		/**
		 * @return 
		 */		
		public function get data()				: String
		{
			return _data;
		}
		public function set data( val:String ):void
		{
			_data = val;
		}
		
		/**
		 * Constructor.
		 * 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 */		
		public function ChatEvent( type:String, bubbles:Boolean=true,
								   cancelable:Boolean=true )
		{
			super( type, bubbles, cancelable );
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		override public function toString():String
		{
			return "<ChatEvent type='" + type + "' data='" + _data + "' />";
		}
		
	}
}