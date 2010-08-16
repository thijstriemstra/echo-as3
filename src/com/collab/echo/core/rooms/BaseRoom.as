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
package com.collab.echo.core.rooms
{
	import com.collab.echo.events.BaseRoomEvent;
	import com.collab.echo.net.Connection;
	
	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	// ====================================
	// EVENTS
	// ====================================
	
	/**
	 * @eventType com.collab.echo.events.BaseRoomEvent.JOIN_RESULT
	 */
	[Event(name="joinResult", type="com.collab.echo.events.BaseRoomEvent")]
	
	/**
	 * @eventType com.collab.echo.events.BaseRoomEvent.OCCUPANT_COUNT
	 */
	[Event(name="occupantCount", type="com.collab.echo.events.BaseRoomEvent")]
	
	/**
	 * @eventType com.collab.echo.events.BaseRoomEvent.ADD_OCCUPANT
	 */
	[Event(name="addOccupant", type="com.collab.echo.events.BaseRoomEvent")]
	
	/**
	 * @eventType com.collab.echo.events.BaseRoomEvent.REMOVE_OCCUPANT
	 */
	[Event(name="removeOccupant", type="com.collab.echo.events.BaseRoomEvent")]

	/**
	 * @eventType com.collab.echo.events.BaseRoomEvent.ATTRIBUTE_UPDATE
	 */
	[Event(name="attributeUpdate", type="com.collab.echo.events.BaseRoomEvent")]
	
	/**
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
		private var _listeners			: Dictionary;
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
		 * 
		 */		
		protected var joinedRoom		: Boolean;
		
		// ====================================
		// ACCESSOR/MUTATOR
		// ====================================
		
		/**
		 * @return 
		 */		
		public function get listeners():Dictionary
		{
			return _listeners;
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
		 * @return 
		 */		
		public function get self():*
		{
			return _connection.self;
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
		 * Auto join the room when it's created.
		 *  
		 * @return 
		 */		
		public function get autoJoin():Boolean
		{
			return _autoJoin;
		}
		
		/**
		 * Watch the room after it's created.
		 *  
		 * @return 
		 */		
		public function get watch():Boolean
		{
			return _watch;
		}
		
		/**
		 * Whether the local client joined the room.
		 *  
		 * @return 
		 */		
		public function get joined():Boolean
		{
			return joinedRoom;
		}
		
		/**
		 * Constructor.
		 *  
		 * @param id
		 * @param autoJoin
		 * @param watch
		 */		
		public function BaseRoom( id:String, autoJoin:Boolean=false, watch:Boolean=true )
		{
			super();
			
			_id = id;
			_autoJoin = autoJoin;
			_watch = watch;
			_listeners = new Dictionary();
			joinedRoom = false;
			
			name = getQualifiedClassName( this ).split( "::" )[ 1 ]
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * Create a new room.
		 * 
		 * @param connection The connection to the parent multi-user engine for the new room.
		 */		
		public function create( connection:Connection ):void
		{
			this.connection = connection;
		}
		
		/**
		 * Asks the server to place the current client in the server-side room represented by this
		 * BaseRoom object.
		 */		
		public function join():void
		{
		}
		
		/**
		 * Asks the server to remove the current client from the server-side room represented by
		 * this BaseRoom object.
		 */		
		public function leave():void
		{
		}
		
		/**
		 * @param type
		 * @param method
		 */		
		public function addMessageListener( type:String, method:Function ):void
        {
        	_listeners[ type ] = method;
        }
        
        /**
		 * @param type
		 * @param method
		 */		
		public function removeMessageListener( type:String, method:Function ):void
        {
        	_listeners[ type ] = null;
        }
        
        /**
         * @param type
         * @param message
         * @param includeSelf
         */        
        public function sendMessage( type:String, message:String, includeSelf:Boolean=false ):void
        {
        	throw new IllegalOperationError("Implement sendMessage in subclass");
        }
        
        /**
         * @return 
         */        
        public function getOccupants():Array
        {
        	throw new IllegalOperationError("Implement getOccupants in subclass");
			return null;
        }
        
        /**
         * @param clientIDs
         * @param attrName
         * @param attrScope
         * @return 
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
         * @param attrName
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
		 */		
		public function getClientId():String
		{
			throw new IllegalOperationError("Implement getClientId in subclass");
			return null;
		}
		
		/**
		 * @private 
		 */		
		override public function toString():String
		{
			return "<BaseRoom id='" + id + "' />";
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * Invoked when the room was joined.
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
		 * A room attribute was changed.
		 * 
		 * @param event
		 */		
		protected function attributeUpdate( event:*=null ):void
		{
			event.preventDefault();
			
			_evt = new BaseRoomEvent( BaseRoomEvent.ATTRIBUTE_UPDATE, event );
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