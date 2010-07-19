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
package com.collab.echo.view.hub.chat.messages
{
	/**
	 * ABSTRACT Class (should be subclassed and not instantiated).
	 *  
	 * @author Thijs Triemstra
	 */	
	public class BaseChatMessage
	{
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		internal var _data							: String;
		internal var _privateMessage				: Boolean;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		public function get data():String
		{
			return _data;
		}
		public function set data( val:String ):void
		{
			if ( val )
			{
				_data = val;
			}
		}
		
		public function get privateMessage():Boolean
		{
			return _privateMessage;
		}
		public function set privateMessage( val:Boolean ):void
		{
			if ( val )
			{
				_privateMessage = val;
			}
		}
		
		/**
		 * Constructor.
		 *  
		 * @param data
		 * @param privateMessage
		 */		
		public function BaseChatMessage( data:String=null, privateMessage:Boolean=false )
		{
			_data = data;
			_privateMessage = privateMessage;
			
			parseCommand();
		}
		
		/**
		 * 
		 */		
		protected function parseCommand():void
		{
			// override in subclass
		}
		
		/**
		 * @param command
		 */		
		protected function execute( command:String ):void
		{
			// override in subclass
		}
		
		public function toString():String
		{
			return "<BaseChatMessage data='" + data + "' />";	
		}
		
	}
}