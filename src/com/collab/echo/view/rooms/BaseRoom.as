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
package com.collab.echo.view.rooms
{
	import com.collab.echo.view.events.BaseRoomEvent;
	
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Thijs Triemstra
	 */	
	public class BaseRoom extends EventDispatcher
	{
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		internal var _id		: String;
		internal var _reactor	: *;
		internal var _autoJoin	: Boolean;
		internal var _evt		: BaseRoomEvent;
		
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		protected var name		: String;
		
		// ====================================
		// ACCESSOR/MUTATOR
		// ====================================
		
		public function get id():String
		{
			return _id;
		}
		
		public function get reactor():*
		{
			return _reactor;
		}
		public function set reactor( val:* ):void
		{
			_reactor = val;
		}
		
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
			
			name =  getQualifiedClassName( this ).split("::")[1]
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * Create a new <code>Room</code>.
		 * 
		 * @param reactor
		 * @return 
		 */		
		public function create( reactor:* ):void
		{
		}
		
		/**
		 * 
		 */		
		public function join():void
		{
		}
		
		/**
		 * Leave the <code>Room</code>. 
		 */		
		public function leave():void
		{
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * Join the <code>Room</code>.
		 *  
		 * Note: called *after* <code>addOccupant</code>. 
		 * 
		 * @param event
		 */		
		protected function joinResult( event:*=null ):void
		{
			_evt = new BaseRoomEvent( BaseRoomEvent.JOIN_RESULT, event );
			dispatchEvent( _evt );
		}
		
		/**
		 * @param event
		 */		
		protected function occupantCount( event:*=null ):void
		{
		}
		
		/**
		 * @param event
		 */		
		protected function addOccupant( event:*=null ):void
		{
			_evt = new BaseRoomEvent( BaseRoomEvent.ADD_OCCUPANT, event );
			dispatchEvent( _evt );
		}
		
		/**
		 * @param event
		 */		
		protected function removeOccupant( event:*=null ):void
		{
			_evt = new BaseRoomEvent( BaseRoomEvent.REMOVE_OCCUPANT, event );
			dispatchEvent( _evt );
		}
		
		/**
		 * @param event
		 */		
		protected function attributeUpdate( event:*=null ):void
		{
			_evt = new BaseRoomEvent( BaseRoomEvent.ATTRIBUTE_UPDATE, event );
			dispatchEvent( _evt );
		}
		
	}
}