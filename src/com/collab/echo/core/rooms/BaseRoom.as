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
		 * Join the room.
		 */		
		public function join():void
		{
		}
		
		/**
		 * Leave the room.
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