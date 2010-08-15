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
	 * A Connection object dispatches a BaseConnectionEvent object whenever the
	 * connection status changes.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class BaseConnectionEvent extends Event
	{
		// ====================================
		// CLASS CONSTANTS
		// ====================================
		
		/**
		 * @private 
		 */		
		internal static const NAME				: String = "BaseConnectionEvent";
		
		public static const CONNECTING			: String = NAME + "_connecting";
		public static const CONNECTION_SUCCESS	: String = NAME + "_connectionSuccess";
		public static const CONNECTION_CLOSED	: String = NAME + "_connectionClosed";
		public static const DISCONNECTING		: String = NAME + "_disconnecting";
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _data 						: *;
		
		// ====================================
		// ACCESSOR/MUTATOR
		// ====================================
		
		/**
		 * @return 
		 */		
		public function get data()				: *
		{
			return _data;
		}
		
		/**
		 * Constructor.
		 *  
		 * @param type
		 * @param data
		 */		
		public function BaseConnectionEvent( type:String, data:*=null )
		{
			super( type, false, true );
			
			_data = data;
		}
		
		/**
		 * @private
		 * @return 
		 */		
		override public function toString():String
		{
			return "<BaseConnectionEvent type='" + type + "' data='" + _data + "' />";
		}
		
	}
}