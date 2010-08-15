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
	import com.collab.echo.core.messages.chat.ChatMessage;
	
	import flash.events.Event;
	
	/**
	 * Event for a chat message.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class ChatMessageEvent extends Event
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		public static const NAME				: String = "ChatMessageEvent";
		public static const LOAD_COMPLETE		: String = NAME + "_loadComplete";
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _data						: ChatMessage;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		/**
		 * @return 
		 */		
		public function get data()				: ChatMessage
		{
			return _data;
		}
		public function set data( val:ChatMessage ):void
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
		public function ChatMessageEvent( type:String, bubbles:Boolean=false, cancelable:Boolean=false )
		{
			super( type, bubbles, cancelable );
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * @private 
		 * @return 
		 */		
		override public function toString():String
		{
			return "<ChatMessageEvent type='" + type + "' data='" + _data + "' />";
		}
		
	}
}