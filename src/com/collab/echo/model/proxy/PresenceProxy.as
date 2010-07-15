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
package com.collab.echo.model.proxy
{
    import com.collab.echo.model.vo.UserVO;
    import com.collab.echo.view.rooms.BaseRoom;
    
    import org.puremvc.as3.multicore.interfaces.IProxy;
    import org.puremvc.as3.multicore.patterns.proxy.Proxy;
    
    /**
     * A base <code>Proxy</code> for user presence.
	 * 
	 * <p>Note: should not de dependent on any third-party frameworks like Union.</p>
	 * 
	 * @author Thijs Triemstra
     */
    public class PresenceProxy extends Proxy implements IProxy
    {
		// ====================================
		// CONSTANTS
		// ====================================
		
		/**
		 * Cannonical name of this <code>Proxy</code>.
		 */    
		public static const NAME					: String = "PresenceProxy";

		// Notifications
		public static const CONNECTING				: String = NAME + "_connecting";
		public static const CONNECTION_SUCCESS		: String = NAME + "_connectionSuccess";
		public static const CONNECTION_CLOSED		: String = NAME + "_connectionClosed";
		public static const DISCONNECTING			: String = NAME + "_disconnecting";
		public static const ROOM_ADDED				: String = NAME + "_roomAdded";
		public static const ROOM_REMOVED			: String = NAME + "_roomRemoved";
		public static const ROOM_COUNT				: String = NAME + "_roomCount";
		public static const ROOM_JOINED				: String = NAME + "_roomJoined";
		public static const ROOM_ATTRIBUTE_UPDATE	: String = NAME + "_roomAttributeUpdate";
		public static const ROOM_CLIENT_COUNT		: String = NAME + "_roomClientCount";
		public static const ROOM_CLIENT_ADD			: String = NAME + "_roomClientAdd";
		public static const ROOM_CLIENT_REMOVE		: String = NAME + "_roomClientRemove";
		
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		protected var logLevel						: String;
		protected var reactor						: *;
		
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		internal var _users							: Vector.<UserVO>;
		internal var _hostUrl						: String;
		internal var _hostPort						: int;
		internal var _logging						: Boolean;
		internal var _rooms							: Vector.<BaseRoom>;
		internal var _ready							: Boolean;
		internal var _room							: BaseRoom;
		
		// ====================================
		// ACCESSOR/MUTATOR
		// ====================================
		
		public function get rooms():Vector.<BaseRoom>
		{
			return _rooms;
		}
		public function set rooms( val:Vector.<BaseRoom> ):void
		{
			_rooms = val;
			
			for each ( _room in _rooms )
			{
				_room.create( reactor );
			}
		}
		
		/**
		 * @return 
		 */		
		public function get users():Vector.<UserVO>
		{
			return _users;
		}
		
		public function get isReady():Boolean
		{
			return _ready;
		}
		
		/**
		 * Constructor.
		 * 
		 * @param data
		 */		
		public function PresenceProxy ( data:Object = null ) 
        {
            super ( NAME, data );
			
			_ready = false;
        }
		
		// ====================================
		// PUBLIC/PROTECTED METHODS
		// ====================================
		
		/**
		 * Connect to the server.
		 *  
		 * @param host
		 * @param port
		 * @param logging
		 */		
		public function createConnection( host:String=null, port:int=80,
										  logging:Boolean=true ):void
		{
			_hostPort = port;
			_hostUrl = host;
			_logging = logging;
			
			sendNotification( CONNECTING );
		}
		
		/**
		 * Disconnect connection to server. 
		 */		
		public function closeConnection():void
		{
			sendNotification( DISCONNECTING );
		}
		
		/**
		 * Triggered when the connection is established and ready for use.
		 */		
		protected function connectionReady():void
		{
			_ready = true;
			
			sendNotification( CONNECTION_SUCCESS );
		}
		
		/**
		 * Triggered when the connection is closed.
		 */		
		protected function connectionClosed():void
		{
			sendNotification( CONNECTION_CLOSED );
		}
		
		/**
		 * Triggered when a new room is added.
		 * 
		 * @param data
		 */		
		protected function roomAdded( data:* ):void
		{
			sendNotification( ROOM_ADDED, data );
		}
		
		/**
		 * Triggered when a room has been removed.
		 * 
		 * @param data
		 */		
		protected function roomRemoved( data:* ):void
		{
			sendNotification( ROOM_REMOVED, data );
		}
		
		/**
		 * Triggered when the total number of rooms has changed.
		 * 
		 * @param data
		 */		
		protected function roomCount( data:* ):void
		{
			sendNotification( ROOM_COUNT, data );
		}
		
	}
}