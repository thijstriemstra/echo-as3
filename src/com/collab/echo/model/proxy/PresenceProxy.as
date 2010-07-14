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
    
    import org.puremvc.as3.multicore.interfaces.IProxy;
    import org.puremvc.as3.multicore.patterns.proxy.Proxy;
    
    /**
     * A base <code>Proxy</code> for user presence.
	 * 
	 * <p>Should not rely on any third-party framework like Union.</p>
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
		public static const ROOM_JOINED				: String = NAME + "_roomJoined";
		public static const ROOM_ADDED				: String = NAME + "_roomAdded";
		public static const ROOM_REMOVED			: String = NAME + "_roomRemoved";
		public static const ROOM_ATTRIBUTE_UPDATE	: String = NAME + "_roomAttributeUpdate";
		public static const ROOM_CLIENT_COUNT		: String = NAME + "_roomClientCount";
		
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		protected var logLevel						: String;
		
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		internal var _users							: Vector.<UserVO>;
		
		// ====================================
		// ACCESSOR/MUTATOR
		// ====================================
		
		/**
		 * @return 
		 */		
		public function get users():Vector.<UserVO>
		{
			return _users;
		}
		
		/**
		 * Constructor.
		 * 
		 * @param data
		 */		
		public function PresenceProxy ( data:Object = null ) 
        {
            super ( NAME, data );
        }
		
		// ====================================
		// PUBLIC/PROTECTED METHODS
		// ====================================
		
		/**
		 * Connect to the server.
		 *  
		 * @param host
		 * @param port
		 */		
		public function createConnection( host:String=null, port:int=80 ):void
		{
			sendNotification( CONNECTING );
		}
		
		/**
		 * Triggered when the connection is established and ready for use.
		 */		
		protected function connectionReady():void
		{
			sendNotification( CONNECTION_SUCCESS );
		}
		
		/**
		 * @param data
		 */		
		protected function roomJoined( data:* ):void
		{
			sendNotification( ROOM_JOINED, data );
		}
		
		/**
		 * @param data
		 */		
		protected function roomAdded( data:* ):void
		{
			sendNotification( ROOM_ADDED, data );
		}
		
		/**
		 * @param data
		 */		
		protected function roomRemoved( data:* ):void
		{
			sendNotification( ROOM_REMOVED, data );
		}
		
		/**
		 * @param data
		 */		
		protected function roomAttributeUpdate( data:* ):void
		{
			sendNotification( ROOM_ATTRIBUTE_UPDATE, data );
		}
		
		/**
		 * @param data
		 */		
		protected function roomClientCount( data:* ):void
		{
			sendNotification( ROOM_CLIENT_COUNT, data );
		}
		
	}
}