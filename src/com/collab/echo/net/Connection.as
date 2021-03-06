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
package com.collab.echo.net
{
	import com.collab.echo.core.messages.chat.ChatMessage;
	import com.collab.echo.core.rooms.BaseRoom;
	import com.collab.echo.events.BaseConnectionEvent;
	import com.collab.echo.events.BaseRoomEvent;
	import com.collab.echo.model.UserVO;
	
	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;
	
	// ====================================
	// EVENTS
	// ====================================
	
	/**
	 * Dispatched when an attempt to create a connection was initiated.
	 * 
	 * @eventType com.collab.echo.events.BaseConnectionEvent.CONNECTING
	 */
	[Event(name="connecting", type="com.collab.echo.events.BaseConnectionEvent")]
	
	/**
	 * Dispatched when the connection attempt was successful.
	 * 
	 * @eventType com.collab.echo.events.BaseConnectionEvent.CONNECTION_SUCCESS
	 */
	[Event(name="connectionSuccess", type="com.collab.echo.events.BaseConnectionEvent")]
	
	/**
	 * Dispatched when disconnecting from the server.
	 * 
	 * @eventType com.collab.echo.events.BaseConnectionEvent.DISCONNECTING
	 */
	[Event(name="disconnecting", type="com.collab.echo.events.BaseConnectionEvent")]
	
	/**
	 * Dispatched when the connection was closed.
	 * 
	 * @eventType com.collab.echo.events.BaseConnectionEvent.CONNECTION_CLOSED
	 */
	[Event(name="connectionClosed", type="com.collab.echo.events.BaseConnectionEvent")]
	
	/**
	 * Server connection.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 10
	 */	
	public class Connection extends EventDispatcher
	{
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		/**
		 * @private 
		 */		
		protected var _connected      		: Boolean;
		
		/**
		 * @private 
		 */		
		protected var _conEvt				: BaseConnectionEvent;
		
		/**
		 * @private 
		 */		
		protected var _roomEvt				: BaseRoomEvent;
		
		/**
		 * @private 
		 */		
		protected var _rooms				: Vector.<BaseRoom>;
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _hostUrl				: String;
		private var _hostPort				: int;
		private var _self					: *;
		private var _logLevel				: String;
		private var _logging				: Boolean;
		
		// ====================================
		// ACCESSOR/MUTATOR
		// ====================================
		
		/**
		 * Host URL.
		 */		
		public function get url():String
		{
			return _hostUrl;
		}
		
		/**
		 * Host port number.
		 */		
		public function get port():int
		{
			return _hostPort;
		}
		
		/**
		 * Enabled logging.
		 * 
		 * @default true
		 */		
		public function get logging():Boolean
		{
			return _logging;
		}
		
		/**
		 * Current log level.
		 * 
		 * @default info
		 */		
		public function get logLevel():String
		{
			return _logLevel;
		}
		
		/**
		 * Reference to local client.
		 */		
		public function get self():*
		{
			throw new IllegalOperationError("Implement self in subclass");
			return null;
		}
		
		/**
         * Connection status.
         * 
         * <p>Boolean indicating if the connection to the presence server
		 * has been successfully completed.</p>
		 * 
		 * @default false
		 * @see #connect()
		 * @see #disconnect()
         */		
        public function get connected():Boolean
        {
            return _connected;
        }
		
		/**
		 * Constructor.
		 * 
		 * @param host
		 * @param port
		 * @param logging
		 * @param logLevel
		 */		
		public function Connection( host:String, port:int,
									logging:Boolean=true, logLevel:String="info" )
		{
			if ( host == null )
			{
				throw new TypeError( "Invalid host specified: " + host );
			}
			
			if ( port <= 0 )
			{
				throw new TypeError( "Invalid port specified: " + port );
			}	
			
			_hostUrl = host;
			_hostPort = port;
			_logging = logging;
			_logLevel = logLevel;
			_connected = false;
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
         * Connect to server.
		 * 
		 * @see #disconnect()
		 * @see #connected
         */		
        public function connect():void
        {
            if ( _hostUrl && _hostPort )
            {
            	// notify others
            	_conEvt = new BaseConnectionEvent( BaseConnectionEvent.CONNECTING );
				dispatchEvent( _conEvt );
            }
        }
		
		/**
		 * Disconnect from server.
		 * 
		 * @see #connect()
		 * @see #connected
		 */		
		public function disconnect():void
		{
			if ( _hostUrl && _hostPort )
			{
				// notify others
				_conEvt = new BaseConnectionEvent( BaseConnectionEvent.DISCONNECTING );
				dispatchEvent( _conEvt );
			}
		}
        
        /**
         * Create one or more rooms.
         * 
         * @param rooms
		 * @see #createRoom()
		 * @see #watchRooms()
         */        
        public function createRooms( rooms:Vector.<BaseRoom> ):void
        {
        	throw new IllegalOperationError("Implement createRooms in subclass");
        }
		
		/**
		 * Create a new room.
		 *  
		 * @param id
		 * @param settings
		 * @param attrs
		 * @param modules
		 * @see #createRooms()
		 */        
		public function createRoom( id:String, settings:*, attrs:*, modules:* ):*
		{
			throw new IllegalOperationError("Implement createRoom in subclass");
			return null;
		}
        
        /**
		 * Watch for rooms.
		 * 
		 * @see #createRooms()
		 */		
		public function watchRooms():void
		{
			throw new IllegalOperationError("Implement watchRooms in subclass");
		}
		
		/**
		 * Parse user.
		 * 
		 * @param client
		 */		
		public function parseUser( client:* ):UserVO
		{
			throw new IllegalOperationError("Implement parseUser in subclass");
			return null;
		}
        
        /**
         * Registers a method or function to be executed when the specified type of message
         * is received from the server. 
         * 
         * <p>This method can be used to register listeners that handle messages centrally
         * for a group of rooms.</p>
         * 
         * @example For example, suppose a multi-room chat application
         * displays a notification icon when a new message is received in any room.
         * To catch all incoming messages for all rooms, the application registers a
         * single, centralized method for all "CHAT" messages. Here's the registration code:
		 * 
		 * <listing version="3.0">
		 * msgManager.addServerMessageListener(Messages.CHAT, centralChatListener);</listing>
         * 
         * @param type 		The name of the message the listener is registering to receive.
         * @param method 	The function or method that will be invoked when the specified
         *                  message is received.
         * @param forRoomIDs  A list of room IDs. If the message was sent to any of the
         *                    rooms in the list, the listener is executed. Otherwise, the
         *                    listener is not executed. Applies to messages sent to rooms
         *                    only, not to messages sent to specific individual clients or
         *                    the entire server.
         * @return 			  A Boolean indicating whether the listener was successfully
         *                    added.
		 * @see #removeServerMessageListener()
         */        
        public function addServerMessageListener( type:String, method:Function,
        										  forRoomIDs:Array=null ):Boolean
        {
        	throw new IllegalOperationError("Implement addServerMessageListener in subclass");
			return null;
        }
        
        /**
         * Unregisters a message listener method that was earlier registered for message
         * notifications via addServerMessageListener().
         * 
         * @param type 		The string ID of the message for which the listener is
         *                  unregistering.
         * @param method 	The function or method to unregister.
         * @return 			A Boolean indicating whether the listener was successfully
         *                  removed.
		 * @see #addServerMessageListener()
         */        
        public function removeServerMessageListener( type:String, method:Function ):Boolean
        {
        	throw new IllegalOperationError("Implement removeServerMessageListener in subclass");
			return null;
        }
        
        /**
         * Sends a message to clients in the room(s) specified by <code>forRoomIDs</code>.
         * 
         * <p>To send a message to clients in a single room only, use the sendRoomMessage()
         * method.</p>
         *  
         * @param message		The name of the message to send.
         * @param forRoomIDs	The room(s) to which to send the message.
         */		
        public function sendServerMessage( message:ChatMessage, forRoomIDs:Array=null ):void
        {
        	throw new IllegalOperationError("Implement sendServerMessage in subclass");
        }
        
        /**
         * Get a user's IP address by <code>name</code>.
         * 
		 * @param name
		 * @return 
		 */		
		public function getIPByUserName( name:String ):String
		{
			throw new IllegalOperationError("Implement getIPByUserName in subclass");
			return null;
		}
		
		/**
		 * Get user's client by attribute.
		 * 
		 * @param attrName
		 * @param attrValue
		 * @return 
		 * @see #getClientById()
		 */		
		public function getClientByAttribute( attrName:String, attrValue:String ):*
		{
			throw new IllegalOperationError("Implement getClientByAttribute in subclass");
			return null;
		}
		
		/**
		 * Returns an array of objects containing values for the specified attribute for
         * all clients in supplied <code>clientIDs</code>.
         * 
         * @param clientIDs
         * @param attrName
         * @param attrScope
         * @return 
         */        
        public function getAttributeForClients( clientIDs:Array, attrName:String,
        										attrScope:String ):Array
        {
        	throw new IllegalOperationError("Implement getAttributeForClients in subclass");
			return null;
        }
		
		/**
		 * Get client reference by id.
		 * 
		 * @param id
		 * @return 
		 * @see #getClientByAttribute()
		 */		
		public function getClientById( id:String ):*
		{
			throw new IllegalOperationError("Implement getClientById in subclass");
			return null;
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
        /**
		 * Triggered when the connection is established and ready for use.
		 */
		protected function connectionReady():void
		{
			_connected = true;
			
			_conEvt = new BaseConnectionEvent( BaseConnectionEvent.CONNECTION_SUCCESS );
			dispatchEvent( _conEvt );
		}
		
		/**
		 * Triggered when the connection is closed.
		 */
		protected function connectionClosed():void
		{
            _connected = false;

			_conEvt = new BaseConnectionEvent( BaseConnectionEvent.CONNECTION_CLOSED );
			dispatchEvent( _conEvt );
		}

	}
}