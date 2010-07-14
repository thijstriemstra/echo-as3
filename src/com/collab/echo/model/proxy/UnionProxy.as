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
	import net.user1.logger.Logger;
	import net.user1.reactor.AttributeEvent;
	import net.user1.reactor.ConnectionManager;
	import net.user1.reactor.HTTPConnection;
	import net.user1.reactor.Reactor;
	import net.user1.reactor.ReactorEvent;
	import net.user1.reactor.Room;
	import net.user1.reactor.RoomEvent;
	import net.user1.reactor.RoomManagerEvent;
	import net.user1.reactor.RoomModules;
	import net.user1.reactor.RoomSettings;
	import net.user1.reactor.XMLSocketConnection;
	
	import org.osflash.thunderbolt.Logger;

	/**
	 * Presence <code>Proxy</code> for the Union platform.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class UnionProxy extends PresenceProxy
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		/**
		 * Cannonical name of this <code>Proxy</code>.
		 */    
		public static const NAME				: String = "UnionProxy";
		
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		/**
		 * The core Reactor object that connects to Union Server. 
		 */		
		protected var reactor					: Reactor;
		
		/**
		 * 
		 */		
		protected var connectionManager			: ConnectionManager;
		
		/**
		 * 
		 */		
		protected var modules					: RoomModules;

		/**
		 * Use a RoomSettings object to specify it's features.
		 */		
		protected var roomSettings				: RoomSettings;

		// ====================================
		// ACCESSOR/MUTATOR
		// ====================================
		
		override public function get isReady():Boolean
		{
			return reactor.isReady();
		}
		
		/**
		 * Constructor.
		 * 
		 * @param data
		 */		
		public function UnionProxy( data:Object=null )
		{
			super( data );
			
			logLevel = net.user1.logger.Logger.INFO;
			modules = new RoomModules();
		}

		// ====================================
		// PUBLIC/PROTECTED METHODS
		// ====================================

		/**
		 * Create the Reactor object and connect to the Union Server.
		 *  
		 * @param url
		 * @param port
		 * @param logging
		 */		
		override public function createConnection( url:String="localhost",
												   port:int=80, logging:Boolean=true ):void
		{
			super.createConnection( url, port );
			
			log( "Connecting to Union server on " + url + ":" + port );
			
			reactor = new Reactor( "", logging );
			reactor.getLog().setLevel( logLevel );
			reactor.addEventListener( ReactorEvent.READY, unionConnectionReady );
			reactor.addEventListener( ReactorEvent.CLOSE, unionConnectionClose );
			
			try
			{
				connectionManager = reactor.getConnectionManager();
				connectionManager.addConnection( new XMLSocketConnection( url, 9110 ));
				connectionManager.addConnection( new XMLSocketConnection( url, 80 ));
				connectionManager.addConnection( new XMLSocketConnection( url, 443 ));
				connectionManager.addConnection( new HTTPConnection( url, 80 ));
				connectionManager.addConnection( new HTTPConnection( url, 443 ));
				connectionManager.addConnection( new HTTPConnection( url, 9110 ));
				reactor.connect();
			}
			catch ( e:Error )
			{
				trace('hey: ' + e);
			}
		}
		
		/**
		 * Add <code>RoomModule</code>s.
		 * 
		 * @param moduleObjects
		 */		
		protected function addRoomModules( ...moduleObjects:Array ):void
		{
			var module:Object;
			for each ( module in moduleObjects )
			{
				log( "Adding '" + module.type + "' RoomModule: '" + module.alias + "'" );
				modules.addModule( module.alias, module.type );
			}
		}
		
		/**
		 * Ask to be notified when a room with the qualifier
		 * <code>roomQualifier</code> is added to or removed from the server. 
		 * 
		 * @param roomQualifier
		 */		
		protected function watchForRooms( roomQualifier:String ):void
		{
			reactor.getRoomManager().watchForRooms( roomQualifier );

			// in response to this watchForRooms() call, the RoomManager will trigger 
			// RoomManagerEvent.ROOM_ADDED and RoomManagerEvent.ROOM_REMOVED events.
			reactor.getRoomManager().addEventListener( RoomManagerEvent.ROOM_ADDED,
													   roomAddedListener );
			reactor.getRoomManager().addEventListener( RoomManagerEvent.ROOM_REMOVED,
													   roomRemovedListener );
		}
		
		/**
		 * Create and return a new <code>Room</code>.
		 * 
		 * @param roomQualifier
		 * @param settings
		 * @param modules
		 * @param attrs
		 * @return 
		 */		
		protected function createRoom( roomQualifier:String, settings:RoomSettings,
									   modules:RoomModules=null, attrs:XML=null ):Room
		{
			var room:Room = reactor.getRoomManager().createRoom( roomQualifier, roomSettings, 
																 attrs, modules );
			log( "Creating new Room: " + roomQualifier );
			
			return room;
		}
		
		/**
		 * 
		 */		
		protected function createRooms():void
		{
		}
		
		/**
		 * @param msg
		 */		
		protected function log( msg:* ):void
		{
			org.osflash.thunderbolt.Logger.debug( msg );
		}
			
		// ====================================
		// EVENT HANDLERS
		// ====================================

		/**
		 * Triggered when the connection is established and ready for use.
		 *  
		 * @param event
		 */		
		protected function unionConnectionReady( event:ReactorEvent ):void 
		{
			event.preventDefault();
			
			connectionReady();
		}
		
		/**
		 * Triggered when the connection is closed.
		 *  
		 * @param event
		 */		
		protected function unionConnectionClose( event:ReactorEvent ):void 
		{
			event.preventDefault();
			
			connectionClosed();
		}
		
		/**
		 * Triggered when the connection is established and ready for use.
		 */		
		override protected function connectionReady():void
		{
			super.connectionReady();
			
			// specify that the rooms should not "die on empty"; otherwise,
			// each room would automatically be removed when its last occupant leaves
			roomSettings = new RoomSettings();
			roomSettings.dieOnEmpty = false;
		}

		/**
		 * Triggered when one of the room's attributes changes.
		 *  
		 * @param event
		 */		
		protected function roomAttributeUpdateListener( event:AttributeEvent ):void
		{
			event.preventDefault();
			
			roomAttributeUpdate( event );
		}

		/**
		 * Event listener triggered when a room is added to the 
	     * room manager's room list.
	 	 *	 
		 * @param event
		 */		
		protected function roomAddedListener( event:RoomManagerEvent ):void
		{
			event.preventDefault();
			
			roomAdded( event );
		}

		/**
		 * Event listener triggered when a room is removed from the 
	     * room manager's room list.
	 	 * 
		 * @param event
		 */		
		protected function roomRemovedListener( event:RoomManagerEvent ):void
		{
			event.preventDefault();
			
			roomRemoved( event );
		}

		/**
		 * The number of clients in one of the rooms changed, so update 
	     * the on-screen room list to show the new client count.
		 * 
		 * @param event
		 */		
		protected function roomClientCountListener( event:RoomEvent ):void
		{
			event.preventDefault();
			
			roomClientCount( event );
		}

	}
}