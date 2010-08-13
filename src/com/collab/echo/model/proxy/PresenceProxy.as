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
    import com.collab.echo.core.messages.BaseChatMessage;
    import com.collab.echo.core.messages.ChatMessageCreator;
    import com.collab.echo.core.rooms.BaseRoom;
    import com.collab.echo.events.ChatMessageEvent;
    import com.collab.echo.model.vo.UserVO;
    
    import org.osflash.thunderbolt.Logger;
    
    /**
     * A base <code>Proxy</code> for user presence.
	 * 
	 * <p>Note: should not be dependent on any third-party frameworks like Union.</p>
	 * 
	 * @author Thijs Triemstra
	 * @langversion 3.0
 	 * @playerversion Flash 10
     */
    public class PresenceProxy
    {
		// ====================================
		// CONSTANTS
		// ====================================
		
		/**
		 * Cannonical name of this <code>Proxy</code>.
		 */    
		public static const NAME					: String = "PresenceProxy";

		// ====================================
		// PUBLIC VARS
		// ====================================
		
		/**
		 * Creator chat messages. 
		 */		
		public var messageCreator					: ChatMessageCreator;
		
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		/**
		 * 
		 */		
		protected var reactor						: *;
		
		/**
		 * 
		 */		
		protected var message						: BaseChatMessage;
		
		/**
		 * 
		 */		
		protected var logLevel						: String;
		
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		/**
		 * @private 
		 */		
		internal var _users							: Vector.<UserVO>;
		
		/**
		 * @private 
		 */		
		internal var _hostUrl						: String;
		
		/**
		 * @private 
		 */		
		internal var _hostPort						: int;
		
		/**
		 * @private 
		 */		
		internal var _logging						: Boolean;
		
		/**
		 * @private 
		 */		
		internal var _rooms							: Vector.<BaseRoom>;
		
		/**
		 * @private 
		 */		
		internal var _ready							: Boolean;
		
		/**
		 * @private 
		 */		
		internal var _room							: BaseRoom;
		
		// ====================================
		// ACCESSOR/MUTATOR
		// ====================================
		
		/**
		 * The rooms we loaded into the reactor.
		 * 
		 * @return 
		 */		
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
		 * Users we're monitoring.
		 * 
		 * @return 
		 */		
		public function get users():Vector.<UserVO>
		{
			return _users;
		}
		
		/**
		 * True if the connection to the presence server has been successfully
		 * completed.
		 * 
		 * @return 
		 */		
		public function get isReady():Boolean
		{
			return _ready;
		}
		
		/**
		 * Get the application's own client object (i.e., the "current client").
		 * 
		 * @return 
		 */		
		public function get self():*
		{
			// override in subclass
			return null;
		}
		
		/**
		 * Constructor.
		 * 
		 * @param data
		 */		
		public function PresenceProxy ( data:Object = null ) 
        {
			_ready = false;
			messageCreator = new ChatMessageCreator();
        }
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * Send a message to a room.
		 * 
		 * @param message
		 */		
		public function sendMessage( message:BaseChatMessage ):void
		{
			//sendNotification( BaseRoomEvent.SEND_MESSAGE, message );
			
			// load the message (can be async)
			this.message = message;
			this.message.addEventListener( ChatMessageEvent.LOAD_COMPLETE,
										   onMessageComplete, false, 0, true );
			this.message.load();	
		}
		
		/**
		 * Send a line to a room.
		 * 
		 * @param message
		 */		
		public function sendLine( message:String ):void
		{
			//sendNotification( BaseRoomEvent.SEND_LINE, message );
		}
		
		/**
		 * 
		 */		
		public function connectRTMP():void
		{
			Logger.debug( "TODO: Connect to RTMP server.." );
		}
		
		/**
		 * Get user's IP address by username.
		 * 
		 * @param name
		 * @return 
		 */		
		public function getIPByUserName( name:String ):String
		{
			// override in subclass
			return null;
		}
		
		/**
		 * Get client by attribute.
		 * 
		 * @param attrName
		 * @param attrValue
		 * @return 
		 */		
		public function getClientByAttribute( attrName:String, attrValue:String ):*
		{
			// override in subclass
			return null;
		}
		
		/**
		 * @param id
		 * @return 
		 */		
		public function getClientById( id:String ):*
		{
			// override in subclass
			return null;
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * @param event
		 */		
		protected function onMessageComplete( event:ChatMessageEvent ):void
		{
			this.message = event.data;
		}
		
	}
}