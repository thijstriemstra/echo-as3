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
	import com.collab.echo.events.BaseRoomEvent;
	import com.collab.echo.events.ChatMessageEvent;
	import com.collab.echo.model.vo.UserVO;
	
	import net.user1.logger.Logger;
	import net.user1.reactor.ClientManager;
	import net.user1.reactor.ConnectionManager;
	import net.user1.reactor.IClient;
	import net.user1.reactor.MessageManager;
	import net.user1.reactor.Reactor;
	import net.user1.reactor.ReactorEvent;
	import net.user1.reactor.Room;
	import net.user1.reactor.RoomManager;
	import net.user1.reactor.RoomManagerEvent;
	
	import org.osflash.thunderbolt.Logger;
	
	/**
	 * Presence <code>Proxy</code> for the Union platform.
	 * 
	 * <p>Manages connection and rooms. Users are managed in <code>BaseRoom</code>
	 * instances.</p>
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
		
		/**
		 * @private 
		 * @return 
		 */		
		override public function get isReady():Boolean
		{
			return Reactor( reactor ).isReady();
		}
		
		/**
		 * @private 
		 * @return 
		 */		
		override public function get self():*
		{
			return Reactor( reactor ).self();
		}
		
		/**
		 * @return 
		 */		
		public function get roomManager():RoomManager
		{
			return Reactor( reactor ).getRoomManager();
		}
		
		/**
		 * @return 
		 */		
		public function get clientManager():ClientManager
		{
			return Reactor( reactor ).getClientManager();
		}
		
		/**
		 * The ConnectionManager class manages all connections made by a
		 * Reactor application to the Union Server.
		 * 
		 * @return 
		 */		
		public function get connectionManager():ConnectionManager
		{
			return Reactor( reactor ).getConnectionManager();
		}
		
		/**
		 * @return 
		 */		
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
		 * @param message
		 */		
		override public function sendLine( message:String ):void
		{
			super.sendLine( message );
			
			// send remotely
			// XXX: remove hardcoded room name, target rooms[].id instead
			roomManager.sendMessage( BaseRoomEvent.SEND_LINE, [ "collab.global" ],
									 false, null, message );
		}
		/**
		 * 
		 * @param name
		 * @return 
		 */		
		override public function getIPByUserName( name:String ):String
		{
			var ip:String;
			var client:IClient;
			var id:String = name.substr( 4 );
			
			if ( id )
			{
				// XXX: remove hardcoded name length
				var poss:Array = [ getClientByAttribute( UserVO.USERNAME, name ),
								   getClientById( id ) ];
				
				for each ( client in poss )
				{
					if ( client )
					{
						// UNION BUG: this only works for own client
						ip = client.getIP();
						break;
					}
				}
			}
			
			return ip;
		}
		
		/**
		 * Get user's client by attribute.
		 * 
		 * @param attrName
		 * @param attrValue
		 * @return 
		 */		
		override public function getClientByAttribute( attrName:String,
													   attrValue:String ):*
		{
			return clientManager.getClientByAttribute( attrName, attrValue );
		}
		
		/**
		 * @param id
		 * @return 
		 */		
		override public function getClientById( id:String ):*
		{
			return clientManager.getClient( id );
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
		 * @private
		 */		
		override protected function onMessageComplete( event:ChatMessageEvent ):void
		{
			super.onMessageComplete( event );
			
			if ( message.local )
			{
				// perform only locally
				message.local = true;
				message.sender = self;
				sendNotification( BaseRoomEvent.RECEIVE_MESSAGE, message );
			}
			else
			{
				// send remotely
				// XXX: remove hardcoded room name, target rooms[].id instead
				roomManager.sendMessage( message.type, [ "collab.global" ],
										 message.includeSelf, null, message.message );
			}
		}
		
		/**
		 * Dispatched when a remote chat message is received.
		 * 
		 * @param fromClient
		 * @param toRoom
		 * @param chatMessage
		 */		
		public function centralChatListener( fromClient:IClient, toRoom:Room,
											 chatMessage:String ):void
		{
			// XXX: implement toRoom in BaseChatMessage
			message = messageCreator.create( this, BaseRoomEvent.RECEIVE_MESSAGE, chatMessage );
			message.sender = fromClient;
			message.receiver = self;
			
			log( "UnionProxy.centralChatListener: " + message );
			
			sendNotification( BaseRoomEvent.RECEIVE_MESSAGE, message );
		}
		
		/**
		 * Dispatched when a remote line is received.
		 * 
		 * @param fromClient
		 * @param toRoom
		 * @param shape
		 */		
		public function whiteBoardListener( fromClient:IClient, toRoom:Room,
											shape:String ):void
		{
			log( "UnionProxy.whiteBoardListener: " + shape );
			
			// XXX: formalize this
			var obj:Object = new Object();
			obj.shape = shape;
			obj.from = fromClient;
			
			sendNotification( BaseRoomEvent.RECEIVE_LINE, obj );
		}

	}
}