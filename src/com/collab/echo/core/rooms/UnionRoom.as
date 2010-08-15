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
	import net.user1.reactor.AttributeEvent;
	import net.user1.reactor.Room;
	import net.user1.reactor.RoomEvent;
	import net.user1.reactor.RoomModuleType;
	import net.user1.reactor.RoomModules;
	import net.user1.reactor.RoomSettings;
	import net.user1.reactor.UpdateLevels;
	
	import org.osflash.thunderbolt.Logger;
	
	/**
	 * Union-specific room.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class UnionRoom extends BaseRoom
	{
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		/**
		 * Used to specify the room modules that should be attached to a
		 * server-side Union room at creation time.
		 */		
		protected var modules					: RoomModules;
		
		/**
		 * A data container describing the configuration settings for
		 * this Union room.
		 */		
		protected var settings					: RoomSettings;
		
		/**
		 * Specifies the amount of information a client wishes to
		 * receive from the server about a room it has either joined
		 * or is observing.
		 */		
		protected var updateLevels				: UpdateLevels;
		
		/**
		 * A place for Union clients to engage in group communication.
		 */		
		protected var room						: Room;
		
		/**
		 * Constructor. 
		 * 
		 * @param id
		 * @param autoJoin
		 * @param watch
		 */		
		public function UnionRoom( id:String, autoJoin:Boolean=false, watch:Boolean=true )
		{
			super( id, autoJoin, watch );
			
			this.modules = new RoomModules();
			
			// specify that the rooms should not "die on empty"; otherwise,
			// each room would automatically be removed when its last occupant leaves
			settings = new RoomSettings();
			settings.dieOnEmpty = false;
			settings.maxClients = -1;
			
			updateLevels = new UpdateLevels();
			updateLevels.roomMessages = true;
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * Create a new Union room.
		 * 
		 * @param engine
		 * @return 
		 */		
		override public function create( engine:* ):void
		{
			super.create( engine );
			
			// create the room
			room = engine.getRoomManager().createRoom( id, settings, null, modules );
			
			// listen for events
			room.addEventListener( RoomEvent.JOIN_RESULT,		 joinResult );
			room.addEventListener( RoomEvent.OCCUPANT_COUNT,	 occupantCount );
			room.addEventListener( RoomEvent.ADD_OCCUPANT, 		 addOccupant );
			room.addEventListener( RoomEvent.REMOVE_OCCUPANT, 	 removeOccupant );
			room.addEventListener( AttributeEvent.UPDATE, 		 attributeUpdate );
			room.addEventListener( RoomEvent.SYNCHRONIZE,		 synchronize );
			
			log( "Creating new " + name + " called: " + id );
			
			if ( autoJoin )
			{
				// join
				log( "Auto-joining: " + id );
				join();
			}
		}
		
		/**
		 * Join the room.
		 */		
		override public function join():void
		{
			// union specific join command
			room.join( null, updateLevels );
		}
		
		/**
		 * Leave the room.
		 */		
		override public function leave():void
		{
			// union specific leave command
			room.leave();
		}
		
		/**
		 * @param type
		 * @param method
		 */		
		override public function addMessageListener( type:String, method:Function ):void
        {
        	super.addMessageListener( type, method );
        	
        	if ( room )
        	{
				room.addMessageListener( type, method );
        	}
        }
        
        /**
         * @param type
         * @param message
         * @param includeSelf
         */        
        override public function sendMessage( type:String, message:String,
        									  includeSelf:Boolean=false ):void
        {
        	room.sendMessage( type, includeSelf, null, message );
        }

		override public function toString():String
		{
			return "<UnionRoom id='" + id + "' />";
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * Invoked when the room was joined.
		 * 
		 * @param event
		 */		
		override protected function joinResult( event:*=null ):void
		{
			// register listeners
			registerListeners();
        									   
			super.joinResult( event );
		}
		
		/**
		 * Add <code>RoomModule</code> objects.
		 * 
		 * @param moduleObjects
		 */		
		protected function addModules( ...moduleObjects:Array ):void
		{
			var module:Object;
			for each ( module in moduleObjects )
			{
				if ( module.type == RoomModuleType.CLASS ||
					 module.type == RoomModuleType.SCRIPT )
				{
					log( "Adding '" + module.type + "' RoomModule: '" + module.alias + "'" );
					modules.addModule( module.alias, module.type );
				}
			}
		}
		
		/**
         * Register message listeners.
         */        
        protected function registerListeners():void
        {
        	var method:Function;
        	var type:Object;
        	
        	for ( type in listeners )
			{
				method = listeners[ type ];
				room.addMessageListener( type.toString(), method );
				
				log("addMessageListener: " + type + ", method: " + method );
			}
        }
		
		/**
		 * Log a message.
		 * 
		 * @param msg
		 */		
		protected function log( msg:* ):void
		{
			// XXX: don't use this logger
			org.osflash.thunderbolt.Logger.debug( msg );
		}
		
	}
}