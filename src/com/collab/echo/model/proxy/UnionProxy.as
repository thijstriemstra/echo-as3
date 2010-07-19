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
	import com.collab.echo.view.hub.chat.events.ChatMessageEvent;
	
	import net.user1.logger.Logger;
	import net.user1.reactor.ClientManager;
	import net.user1.reactor.ConnectionManager;
	import net.user1.reactor.HTTPConnection;
	import net.user1.reactor.IClient;
	import net.user1.reactor.MessageManager;
	import net.user1.reactor.Reactor;
	import net.user1.reactor.ReactorEvent;
	import net.user1.reactor.Room;
	import net.user1.reactor.RoomManager;
	import net.user1.reactor.RoomManagerEvent;
	import net.user1.reactor.XMLSocketConnection;
	
	import org.osflash.thunderbolt.Logger;
	
	/**
	 * Presence <code>Proxy</code> for the Union platform.
	 * 
	 * <p><Manages connection and rooms. Users are managed in <code>BaseRoom</code>s.</p>
	 * 
	 * @see com.collab.echo.view.rooms.BaseRoom BaseRoom
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
		// ACCESSOR/MUTATOR
		// ====================================
		
		override public function get isReady():Boolean
		{
			return Reactor( reactor ).isReady();
		}
		
		public function get self():IClient
		{
			return Reactor( reactor ).self();
		}
		
		public function get roomManager():RoomManager
		{
			return Reactor( reactor ).getRoomManager();
		}
		
		public function get clientManager():ClientManager
		{
			return Reactor( reactor ).getClientManager();
		}
		
		/**
		 *
		 * The ConnectionManager class manages all connections made by a
		 * Reactor application to the Union Server.
		 * 
		 * @return 
		 * 
		 */		
		public function get connectionManager():ConnectionManager
		{
			return Reactor( reactor ).getConnectionManager();
		}
		
		public function get messageManager():MessageManager
		{
			return Reactor( reactor ).getMessageManager();
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
			
			// create reactor
			reactor = new Reactor( "", logging );
			reactor.getLog().setLevel( logLevel );
			reactor.addEventListener( ReactorEvent.READY, unionConnectionReady );
			reactor.addEventListener( ReactorEvent.CLOSE, unionConnectionClose );
			
			// add fallover connections
			connectionManager.addConnection( new XMLSocketConnection( url, 9110 ));
			connectionManager.addConnection( new XMLSocketConnection( url, 80 ));
			connectionManager.addConnection( new XMLSocketConnection( url, 443 ));
			connectionManager.addConnection( new HTTPConnection( url, 80 ));
			connectionManager.addConnection( new HTTPConnection( url, 443 ));
			connectionManager.addConnection( new HTTPConnection( url, 9110 ));
			reactor.connect();
		}
		
		/**
		 * Ask to be notified when a room with the qualifier
		 * <code>roomQualifier</code> is added to or removed from the server. 
		 * 
		 * @param roomQualifier
		 */		
		protected function watchForRooms( roomQualifier:String ):void
		{
			// watch for rooms.
			roomManager.watchForRooms( roomQualifier );

			// in response to this watchForRooms() call, the RoomManager will trigger 
			// RoomManagerEvent.ROOM_ADDED and RoomManagerEvent.ROOM_REMOVED events.
			roomManager.addEventListener( RoomManagerEvent.ROOM_ADDED, 		roomAddedListener );
			roomManager.addEventListener( RoomManagerEvent.ROOM_REMOVED, 	roomRemovedListener );
			roomManager.addEventListener( RoomManagerEvent.ROOM_COUNT, 		roomCountListener );
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
		 * @param event
		 */		
		override protected function onMessageComplete( event:ChatMessageEvent ):void
		{
			super.onMessageComplete( event );
			
			if ( message.local )
			{
				// dont send with union
				trace( "Invoke local command");
				message.local = true;
				message.sender = self;
				sendNotification( RECEIVE_MESSAGE, message );
			}
			else
			{
				// send with union
				roomManager.sendMessage( message.type, [ "collab.global" ], message.includeSelf,
									 	 null, message.message );
			}
		}
		
		/**
		 * @param fromClient
		 * @param toRoom
		 * @param chatMessage
		 */		
		public function centralChatListener( fromClient:IClient, toRoom:Room,
											 chatMessage:String ):void
		{
			message = messageCreator.create( PresenceProxy.RECEIVE_MESSAGE, chatMessage );
			message.sender = fromClient;
			message.receiver = self;
			
			trace("centralChatListener: " + message);
			
			sendNotification( PresenceProxy.RECEIVE_MESSAGE, message );
		}
		
		/**
		 * Triggered when the connection is established and ready for use.
		 *  
		 * @param event
		 */		
		protected function unionConnectionReady( event:ReactorEvent ):void 
		{
			event.preventDefault();
			
			messageManager.addMessageListener( PresenceProxy.SEND_MESSAGE, centralChatListener );
			
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
		 * Event listener triggered when the number of rooms has changed.
		 * 
		 * @param event
		 */		
		protected function roomCountListener( event:RoomManagerEvent ):void
		{
			event.preventDefault();
			
			roomCount( event );
		}

	}
}