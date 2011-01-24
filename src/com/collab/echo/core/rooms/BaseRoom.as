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
package com.collab.echo.core.rooms
{
	import com.collab.cabin.util.ClassUtils;
	import com.collab.cabin.util.StringUtil;
	import com.collab.echo.events.BaseRoomEvent;
	import com.collab.echo.model.UserVO;
	import com.collab.echo.net.Connection;
	
	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	// ====================================
	// EVENTS
	// ====================================
	
	/**
	 * Dispatched when a client joined the room.
	 * 
	 * @eventType com.collab.echo.events.BaseRoomEvent.JOIN_RESULT
	 */
	[Event(name="joinResult", type="com.collab.echo.events.BaseRoomEvent")]
	
	/**
	 * Dispatched when the current client left the room.
	 * 
	 * @eventType com.collab.echo.events.BaseRoomEvent.LEAVE_RESULT
	 */
	[Event(name="leaveResult", type="com.collab.echo.events.BaseRoomEvent")]
	
	/**
	 * Dispatched when the room's total number of occupants changes.
	 * 
	 * @eventType com.collab.echo.events.BaseRoomEvent.OCCUPANT_COUNT
	 */
	[Event(name="occupantCount", type="com.collab.echo.events.BaseRoomEvent")]
	
	/**
	 * Dispatched when a new occupant is added to the room.
	 * 
	 * @eventType com.collab.echo.events.BaseRoomEvent.ADD_OCCUPANT
	 */
	[Event(name="addOccupant", type="com.collab.echo.events.BaseRoomEvent")]
	
	/**
	 * Dispatched when an existing occupant is removed from the room.
	 * 
	 * @eventType com.collab.echo.events.BaseRoomEvent.REMOVE_OCCUPANT
	 */
	[Event(name="removeOccupant", type="com.collab.echo.events.BaseRoomEvent")]

	/**
	 * Dispatched when a client attribute in the room is updated.
	 * 
	 * @eventType com.collab.echo.events.BaseRoomEvent.CLIENT_ATTRIBUTE_UPDATE
	 */
	[Event(name="clientAttributeUpdate", type="com.collab.echo.events.BaseRoomEvent")]
	
	/**
	 * Dispatched when the room has been synchronized to match the state of
	 * the server.
	 * 
	 * @eventType com.collab.echo.events.BaseRoomEvent.SYNCHRONIZE
	 */
	[Event(name="synchronize", type="com.collab.echo.events.BaseRoomEvent")]
	
	/**
	 * Base room.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class BaseRoom extends EventDispatcher
	{
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _id					: String;
		private var _connection			: Connection;
		private var _autoJoin			: Boolean;
		private var _watch				: Boolean;
		private var _evt				: BaseRoomEvent;
		private var _messageListeners	: Dictionary;
		private var _data				: *;
		
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		/**
		 * Room class name. 
		 */		
		protected var name				: String;
		
		/**
		 * The optional string password used to enter the room.
		 */		
		protected var password			: String;
		
		/**
		 * @private
		 */		
		protected var joinedRoom		: Boolean;
		
		// ====================================
		// ACCESSOR/MUTATOR
		// ====================================
		
		/**
		 * The room's message listeners.
		 * 
		 * @return 
		 */		
		public function get listeners():Dictionary
		{
			return _messageListeners;
		}
		
		/**
		 * Unique qualifier for the room.
		 *  
		 * @return 
		 */		
		public function get id():String
		{
			return _id;
		}
		
		/**
		 * Reference to own client.
		 * 
		 * @return 
		 */		
		public function get self():*
		{
			var result:*;
			
			if ( _connection )
			{
				result = _connection.self;
			}
			
			return result;
		}
		
		/**
		 * Room's connection to the server.
		 *  
		 * @return 
		 */		
		public function get connection():Connection
		{
			return _connection;
		}
		public function set connection( val:Connection ):void
		{
			_connection = val;
		}
		
		/**
		 * The room's data object.
		 * 
		 * @param val
		 * @return 
		 */		
		public function get data():*
		{
			return _data
		}
		public function set data( val:* ):void
		{
			_data = val;
		}
		
		/**
		 * Indicates if the room is automatically joined after it's been
		 * created.
		 *  
		 * @return 
		 */		
		public function get autoJoin():Boolean
		{
			return _autoJoin;
		}
		
		/**
		 * Boolean that indicates if the room is watched after it's been
		 * created.
		 *  
		 * @return 
		 */		
		public function get watch():Boolean
		{
			return _watch;
		}
		
		/**
		 * Boolean that indicates if the local client joined the room.
		 *  
		 * @return 
		 */		
		public function get joined():Boolean
		{
			return joinedRoom;
		}
		
		/**
		 * Creates a new BaseRoom.
		 *  
		 * @param id		Name of the room.
		 * @param autoJoin	Indicates if the room should be joined
		 * 					automatically.
		 * @param watch		Indicates if the room should be watched
		 * 					automatically.
		 * @see #id
		 * @see #autoJoin
		 * @see #watch
		 */		
		public function BaseRoom( id:String, autoJoin:Boolean=false,
								  watch:Boolean=true )
		{
			super();
			
			_id = id;
			_autoJoin = autoJoin;
			_watch = watch;
			_messageListeners = new Dictionary();
			joinedRoom = false;
			
			name = ClassUtils.className( this );
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * Setup the room connection.
		 * 
		 * @param connection The connection to the parent multi-user engine for
		 * 					 the new room.
		 * @see #disconnect()
		 */		
		public function connect( connection:Connection ):void
		{
			this.connection = connection;
		}
		
		/**
		 * Close the room connection.
		 * 
		 * @see #connect()
		 */		
		public function disconnect():void
		{
			this.connection = null;
		}
		
		/**
		 * Asks the server to place the current client in the server-side room
		 * represented by this BaseRoom object.
		 * 
		 * @see #leave()
		 * @see #joined
		 */		
		public function join():void
		{
		}
		
		/**
		 * Asks the server to remove the current client from the server-side
		 * room represented by this BaseRoom object.
		 * 
		 * @see #join()
		 */		
		public function leave():void
		{
		}
		
		/**
		 * Registers a listener to be notified when messages of the specified
		 * type are sent to the room.
		 * 
		 * @param type		A message name, such as "CHAT". When a message by this name is
		 * 					received, the specified listener will be executed.
		 * @param method	The function to be executed when the specified message is received.
		 * @see #removeMessageListener()
		 */		
		public function addMessageListener( type:String, method:Function ):void
        {
			_messageListeners[ type ] = method;
        }
        
        /**
         * Unregisters a message listener previously registered via addMessageListener().
         * 
		 * @param type
		 * @param method
		 * @see #addMessageListener()
		 */		
		public function removeMessageListener( type:String, method:Function ):void
        {
        	// XXX: doublecheck this
			_messageListeners[ type ] = null;
        }
        
        /**
         * Sends a message to clients in and observing this room.
         * 
         * @param type			The name of the message to send.
         * @param message		The string for the message.
         * @param includeSelf	Indicates whether to send the message to the current client.
         */        
        public function sendMessage( type:String, message:String, includeSelf:Boolean=false ):void
        {
        	throw new IllegalOperationError("Implement sendMessage in subclass");
        }
        
        /**
         * Returns an array of objects representing all clients currently in the room.
         * 
         * @return 
		 * @see #getOccupantIDs()
         */        
        public function getOccupants():Array
        {
        	throw new IllegalOperationError("Implement getOccupants in subclass");
			return null;
        }
        
        /**
         * Returns an array of IDs of all clients currently in the room.
         * 
         * @return 
		 * @see #getOccupants()
         */        
        public function getOccupantIDs():Array
        {
        	throw new IllegalOperationError("Implement getOccupantIDs in subclass");
			return null;
        }
        
        /**
         * Returns an array of objects containing values for the specified attribute for
         * all clients in supplied <code>clientIDs</code>.
         * 
         * @param clientIDs	 An array of client ids indicating the clients for which to
         * 					 retrieve the specified attribute.
         * @param attrName	 The name of the attribute to retrieve.
         * @param attrScope	 The scope of the attribute to retrieve.
         * @return 
		 * @see #setAttribute()
         */        
        public function getAttributeForClients( clientIDs:Array, attrName:String,
        										attrScope:String=null ):Array
        {
        	throw new IllegalOperationError("Implement getAttributeForClients in subclass");
			return null;
        }
        
        /**
         * Asks the server to set an attribute for this room.
         *  
         * @param attrName		The name of the attribute to set.
         * @param attrValue
         * @param isShared
         * @param isPersistent
         * @param evaluate
         */        
        public function setAttribute( attrName:String, attrValue:String, isShared:Boolean = true,
        							  isPersistent:Boolean = false, evaluate:Boolean = false ):void
        {
        	throw new IllegalOperationError("Implement setAttribute in subclass");
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
		public function getClientByAttribute( attrName:String,
													   attrValue:String ):*
		{
			throw new IllegalOperationError("Implement getClientByAttribute in subclass");
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
		
		/**
		 * Get own client id.
		 * 
		 * @return 
		 * @see #getClientIdByUsername()
		 */		
		public function getClientId():String
		{
			throw new IllegalOperationError("Implement getClientId in subclass");
			return null;
		}
		
		/**
		 * Look up the clientID of a selected client by username
		 * 
		 * @param username.
		 * @return
		 * @see #getClientId()
		 */
		public function getClientIdByUsername( userName:String ):String
		{
			throw new IllegalOperationError("Implement getClientIdByUsername in subclass");
			return null;
		}
		
		/**
		 * @private 
		 */		
		override public function toString():String
		{
			return StringUtil.replace( "<BaseRoom id='%s' />", id );
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * Invoked when a client joined the room.
		 * 
		 * @param event
		 */		
		protected function joinResult( event:*=null ):void
		{
			event.preventDefault();
			
			_evt = new BaseRoomEvent( BaseRoomEvent.JOIN_RESULT, event );
			dispatchEvent( _evt );
		}
		
		/**
		 * Invoked when the current client left the room.
		 * 
		 * @param event
		 */		
		protected function leaveResult( event:*=null ):void
		{
			event.preventDefault();
			
			_evt = new BaseRoomEvent( BaseRoomEvent.LEAVE_RESULT, event );
			dispatchEvent( _evt );
		}
		
		/**
		 * The amount of occupants in the room changed.
		 * 
		 * @param event
		 */		
		protected function occupantCount( event:*=null ):void
		{
			event.preventDefault();
			
			_evt = new BaseRoomEvent( BaseRoomEvent.OCCUPANT_COUNT, event );
			dispatchEvent( _evt );
		}
		
		/**
		 * A new occupant was added to the room.
		 * 
		 * @param event
		 */		
		protected function addOccupant( event:*=null ):void
		{
			_evt = new BaseRoomEvent( BaseRoomEvent.ADD_OCCUPANT, event );
			dispatchEvent( _evt );
		}
		
		/**
		 * An existing occupant was removed from the room.
		 * 
		 * @param event
		 */		
		protected function removeOccupant( event:*=null ):void
		{
			event.preventDefault();
			
			_evt = new BaseRoomEvent( BaseRoomEvent.REMOVE_OCCUPANT, event );
			dispatchEvent( _evt );
		}
		
		/**
		 * A client attribute was changed.
		 * 
		 * @param event
		 */		
		protected function clientAttributeUpdate( event:*=null ):void
		{
			event.preventDefault();
			
			_evt = new BaseRoomEvent( BaseRoomEvent.CLIENT_ATTRIBUTE_UPDATE, event );
			dispatchEvent( _evt );
		}
		
		/**
		 * The room has been synchronized to match the state of the server.
		 * 
		 * <p>A room is synchronized when the current client joins or observes it.</p>
		 * 
		 * @param event
		 */		
		protected function synchronize( event:*=null ):void
		{
			event.preventDefault();
			
			_evt = new BaseRoomEvent( BaseRoomEvent.SYNCHRONIZE, event );
			dispatchEvent( _evt );
		}
		
	}
}