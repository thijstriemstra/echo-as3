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
	
	import flash.events.EventDispatcher;
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
		
		private var _id			: String;
		private var _engine		: *;
		private var _data		: *;
		private var _autoJoin	: Boolean;
		private var _evt		: BaseRoomEvent;
		
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		/**
		 * <code>Room</code> class name. 
		 */		
		protected var name		: String;
		
		/**
		 * The optional string password used to enter the room.
		 */		
		protected var password	: String;
		
		// ====================================
		// ACCESSOR/MUTATOR
		// ====================================
		
		/**
		 * Unique qualifier for this room.
		 *  
		 * @return 
		 */		
		public function get id():String
		{
			return _id;
		}
		
		/**
		 * Room's engine/connection to the server.
		 *  
		 * @return 
		 */		
		public function get engine():*
		{
			return _engine;
		}
		public function set engine( val:* ):void
		{
			_engine = val;
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
		 * Auto join room when it's created.
		 *  
		 * @return 
		 */		
		public function get autoJoin():Boolean
		{
			return _autoJoin;
		}
		
		/**
		 * Constructor.
		 *  
		 * @param id
		 * @param autoJoin
		 */		
		public function BaseRoom( id:String, autoJoin:Boolean=false )
		{
			super();
			
			_id = id;
			_autoJoin = autoJoin;
			
			name =  getQualifiedClassName( this ).split( "::" )[ 1 ]
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * Create a new <code>BaseRoom</code>.
		 * 
		 * @param engine The parent multi-user engine for the new room.
		 */		
		public function create( engine:* ):void
		{
			this.engine = engine;
		}
		
		/**
		 * Join the <code>BaseRoom</code>.
		 */		
		public function join():void
		{
		}
		
		/**
		 * Leave the <code>BaseRoom</code>. 
		 */		
		public function leave():void
		{
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * Invoked when the <code>BaseRoom</code> was joined.
		 * 
		 * @param event
		 */		
		protected function joinResult( event:*=null ):void
		{
			_evt = new BaseRoomEvent( BaseRoomEvent.JOIN_RESULT, event );
			dispatchEvent( _evt );
		}
		
		/**
		 * The amount of occupants in the <code>Room</code> changed.
		 * 
		 * @param event
		 */		
		protected function occupantCount( event:*=null ):void
		{
			_evt = new BaseRoomEvent( BaseRoomEvent.OCCUPANT_COUNT, event );
			dispatchEvent( _evt );
		}
		
		/**
		 * A new occupant was added to the <code>Room</code>.
		 * 
		 * @param event
		 */		
		protected function addOccupant( event:*=null ):void
		{
			_evt = new BaseRoomEvent( BaseRoomEvent.ADD_OCCUPANT, event );
			dispatchEvent( _evt );
		}
		
		/**
		 * An existing occupant was removed from the <code>Room</code>.
		 * 
		 * @param event
		 */		
		protected function removeOccupant( event:*=null ):void
		{
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
			_evt = new BaseRoomEvent( BaseRoomEvent.SYNCHRONIZE, event );
			dispatchEvent( _evt );
		}
		
	}
}