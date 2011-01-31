/*
Echo project.

Copyright (C) 2003-2011 Collab

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
	import com.collab.cabin.util.StringUtil;
	
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
		internal static const NAME						: String = "BaseRoomEvent";
		
		public static const SEND_INTERNAL_MESSAGE		: String = NAME + "_sendInternalMessage";
		public static const RECEIVE_INTERNAL_MESSAGE	: String = NAME + "_receiveInternalMessage";
		
		// XXX: needs to go chat and whiteboard events
		public static const SEND_PUBLIC_MESSAGE			: String = NAME + "_sendPublicMessage";
		public static const RECEIVE_PUBLIC_MESSAGE		: String = NAME + "_receivePublicMessage";
		public static const SEND_PRIVATE_MESSAGE		: String = NAME + "_sendPrivateMessage";
		public static const RECEIVE_PRIVATE_MESSAGE		: String = NAME + "_receivePrivateMessage";
		public static const SEND_LINE					: String = NAME + "_sendLine";
		public static const RECEIVE_LINE				: String = NAME + "_receiveLine";
		
		/**
		 * The <code>BaseRoomEvent.JOIN_RESULT</code> constant defines the
		 * value of the <code>type</code> property of a room event object.
		 * 
		 * <p>This event has the following properties:</p>
		 */		
		public static const JOIN_RESULT					: String = NAME + "_joinResult";
		public static const LEAVE_RESULT				: String = NAME + "_leaveResult";
		public static const SYNCHRONIZE					: String = NAME + "_synchronize";
		public static const OCCUPANT_COUNT				: String = NAME + "_occupantCount";
		public static const ADD_OCCUPANT				: String = NAME + "_addOccupant";
		public static const REMOVE_OCCUPANT				: String = NAME + "_removeOccupant";
		public static const CLIENT_ATTRIBUTE_UPDATE		: String = NAME + "_clientAttributeUpdate";
		
		public static const ROOM_ADDED					: String = NAME + "_roomAdded";
		public static const ROOM_ADDED_RESULT			: String = NAME + "_roomAddedResult";
		public static const ROOM_REMOVED				: String = NAME + "_roomRemoved";
		public static const ROOM_REMOVED_RESULT			: String = NAME + "_roomRemovedResult";
		public static const ROOM_COUNT					: String = NAME + "_roomCount";
		
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
		
		/**
		 * @private 
		 * @return 
		 */		
		override public function toString():String
		{
			return StringUtil.replace("<BaseRoomEvent type='%s' data='%s' />",
				                      type, _data);
		}
		
	}
}