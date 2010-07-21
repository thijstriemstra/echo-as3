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
	import net.user1.reactor.AttributeEvent;
	import net.user1.reactor.Room;
	import net.user1.reactor.RoomEvent;
	import net.user1.reactor.RoomModuleType;
	import net.user1.reactor.RoomModules;
	import net.user1.reactor.RoomSettings;
	import net.user1.reactor.UpdateLevels;
	
	import org.osflash.thunderbolt.Logger;
	
	/**
	 * @author Thijs Triemstra
	 */	
	public class UnionRoom extends BaseRoom
	{
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		/**
		 * Used to specify the room modules that should be attached to a
		 * server-side room at creation time.
		 */		
		protected var modules					: RoomModules;
		
		/**
		 * A data container describing the configuration settings for
		 * this room.
		 */		
		protected var settings					: RoomSettings;
		
		/**
		 * Specifies the amount of information a client wishes to
		 * receive from the server about a room it has either joined
		 * or is observing.
		 */		
		protected var updateLevels				: UpdateLevels;
		
		/**
		 * A place for clients to engage in group communication.
		 */		
		protected var room						: Room;
		
		/**
		 * Constructor. 
		 * 
		 * @param id
		 * @param autoJoin
		 * @param password
		 */		
		public function UnionRoom( id:String, autoJoin:Boolean=false, password:String=null )
		{
			super( id, autoJoin );
			
			this.password = password;
			this.modules = new RoomModules();
			
			// specify that the rooms should not "die on empty"; otherwise,
			// each room would automatically be removed when its last occupant leaves
			settings = new RoomSettings();
			settings.dieOnEmpty = false;
			settings.maxClients = -1;
			
			updateLevels = new UpdateLevels();
			updateLevels.roomMessages = true;
		}
		
		/**
		 * Join the <code>Room</code>.
		 */		
		override public function join():void
		{
			room.join( password, updateLevels );
		}
		
		/**
		 * Leave the <code>Room</code>.
		 */		
		override public function leave():void
		{
			room.leave();
		}
		
		/**
		 * Create a new <code>Room</code>.
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
			
			if ( _autoJoin )
			{
				log( "Auto-joining: " + id );
				join();
			}
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
		 * Log a message.
		 * 
		 * @param msg
		 */		
		protected function log( msg:* ):void
		{
			org.osflash.thunderbolt.Logger.debug( msg );
		}
		
	}
}