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
	 * A BaseRoom object dispatches a BaseRoomEvent object whenever a room's
	 * attributes or occupants change.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class BaseRoomEvent extends Event
	{
		// ====================================
		// CLASS CONSTANTS
		// ====================================
		
		/**
		 * @private 
		 */		
		internal static const NAME				: String = "BaseRoomEvent";
		
		/**
		 * The <code>BaseRoomEvent.JOIN_RESULT</code> constant defines the
		 * value of the <code>type</code> property of a room event object.
		 * 
		 * <p>This event has the following properties:</p>
		 */		
		public static const JOIN_RESULT			: String = NAME + "_joinResult";
		public static const SYNCHRONIZE			: String = NAME + "_synchronize";
		public static const OCCUPANT_COUNT		: String = NAME + "_occupantCount";
		public static const ADD_OCCUPANT		: String = NAME + "_addOccupant";
		public static const REMOVE_OCCUPANT		: String = NAME + "_removeOccupant";
		public static const ATTRIBUTE_UPDATE	: String = NAME + "_attributeUpdate";
		
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		/**
		 * @private 
		 */		
		internal var _data 						: *;
		
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
		public function BaseRoomEvent( type:String, data:* )
		{
			super( type, false, true );
			
			_data = data;
		}
		
		override public function toString():String
		{
			return "<BaseRoomEvent type='" + type + "' data='" + _data + "' />";
		}
		
	}
}