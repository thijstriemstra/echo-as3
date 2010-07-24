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
package com.collab.echo.view.mediators
{
	import com.collab.echo.model.proxy.PresenceProxy;
	import com.collab.echo.model.vo.RoomVO;
	import com.collab.echo.model.vo.UserVO;
	import com.collab.echo.util.URLUtils;
	import com.collab.echo.view.events.BaseRoomEvent;
	import com.collab.echo.view.hub.chat.events.ChatEvent;
	import com.collab.echo.view.hub.chat.factory.ChatMessageCreator;
	import com.collab.echo.view.hub.chat.factory.ChatMessageTypes;
	import com.collab.echo.view.hub.chat.messages.BaseChatMessage;
	import com.collab.echo.view.hub.display.BaseCommunicationPanel;
	import com.collab.echo.view.rooms.BaseRoom;
	
	import net.user1.reactor.IClient;
	import net.user1.reactor.RoomEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;

    /**
     * A <code>Mediator</code> for interacting with the <code>BaseCommunicationPanel</code>
     * component.
     *  
     * @author Thijs Triemstra
     */	
    public class CommunicationPanelMediator extends BaseMediator
    {
    	// ====================================
		// CONSTANTS
		// ====================================
		
        /**
         * Cannonical name of this <code>Mediator</code>.
         */    	
        public static const NAME			: String = "CommunicationPanelMediator";
        
		protected static const EMPTY_FIELD	: String = "...";
		
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		protected var messageCreator		: ChatMessageCreator;
		protected var user					: UserVO;
		protected var roomEvent				: RoomEvent;
		protected var joined				: Boolean;
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _rooms					: Vector.<RoomVO>;
		
		// ====================================
		// ACCESSOR/MUTATOR
		// ====================================
		
		/**
		 * Rooms.
		 *  
		 * @return 
		 */		
		public function get rooms()			: Vector.<RoomVO>
		{
			return _rooms;
		}
		public function set rooms( val:Vector.<RoomVO> ):void
		{
			_rooms = val;
		}
		
        /**
         * Constructor.
         * 
         * @param viewComponent
         */
        public function CommunicationPanelMediator( viewComponent:BaseCommunicationPanel ) 
        {
            super( NAME, viewComponent );
			
			// init vars
			messageCreator = new ChatMessageCreator();
			joined = false;
			
			// listen for component events
			panel.addEventListener( ChatEvent.SUBMIT, onSubmitChatMessage, false, 0, true );
			
			// XXX: localize
			panel.welcomeMessage = "Hello!";
			panel.sendLabel = "Submit"; 
        }
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * Create presence connection.
		 */		
		override public function onRegister():void
		{
			super.onRegister();
			
			// connect
			presence.createConnection( config.config.presenceHost,
									   config.config.presencePort,
									   config.config.logging );
		}
		
        /**
         * List all notifications this <code>Mediator</code> is interested in.
         * 
         * @return Array the list of Notification names
         */
        override public function listNotificationInterests():Array 
        {
            return [ 
						PresenceProxy.CONNECTING,
						PresenceProxy.CONNECTION_SUCCESS,
						PresenceProxy.CONNECTION_CLOSED,
						PresenceProxy.DISCONNECTING,
						PresenceProxy.RECEIVE_MESSAGE
					];
        }
		
        /**
         * Handle all notifications this <code>Mediator</code> is interested in.
         * 
         * @param note A notification 
         */
        override public function handleNotification( note:INotification ):void 
        {
        	var name:String = note.getName();
			
			switch ( name )
			{
				case PresenceProxy.CONNECTING:
					// TODO
					break;
				
				case PresenceProxy.CONNECTION_SUCCESS:
					createRooms();
					break;
				
				case PresenceProxy.CONNECTION_CLOSED:
					// TODO
					break;
				
				case PresenceProxy.RECEIVE_MESSAGE:
					panel.addMessage( BaseChatMessage( note.getBody() ));
					break;
			}
        }
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * Create rooms and listen for events.
		 */		
		protected function createRooms():void
		{
			var newRooms:Vector.<BaseRoom> = new Vector.<BaseRoom>();
			var room:BaseRoom;
			var item:RoomVO;
			
			for each ( item in _rooms )
			{
				// create new room and listen for events
				room = new item.type( item.id );
				room.addEventListener( BaseRoomEvent.ADD_OCCUPANT, addOccupant );
				room.addEventListener( BaseRoomEvent.REMOVE_OCCUPANT, removeOccupant );
				room.addEventListener( BaseRoomEvent.OCCUPANT_COUNT, numClients );
				room.addEventListener( BaseRoomEvent.JOIN_RESULT, joinedRoom );
				room.addEventListener( BaseRoomEvent.ATTRIBUTE_UPDATE, attributeUpdate );
				newRooms.push( room );
			}
			
			if ( presence )
			{
				presence.rooms = newRooms;
			}
		}
		
		/**
		 * Helper function to parse a user.
		 * 
		 * @param note
		 * @param event
		 * @return 
		 */		
		protected function parseEvent( note:String, event:BaseRoomEvent ):UserVO
		{
			var user:UserVO;
		
			if ( event == null )
			{
				return user;
			}
			
			event.preventDefault();
			
			// notify others
			sendNotification( note, event );
			
			roomEvent = RoomEvent( event.data );
			if ( roomEvent )
			{
				// parse user
				user = parseUser( roomEvent.getClient() );
			}
			
			return user;
		}
		
		/**
		 * @param occupant
		 * @return 
		 */		
		protected function parseUser( occupant:IClient ):UserVO
		{
			var user:UserVO;
			
			try
			{
				user = new UserVO( occupant.getClientID() );
			}
			catch ( e:TypeError )
			{
				return user;
			}
			
			user.client = occupant;
			
			// retrieve the client-attributes
			user.username = occupant.getAttribute( UserVO.USERNAME );
			user.email = occupant.getAttribute( UserVO.EMAIL );
			user.website = occupant.getAttribute( UserVO.WEBSITE );
			user.location = occupant.getAttribute( UserVO.LOCATION );
			user.age = occupant.getAttribute( UserVO.AGE );
			//user.rank = occupant.getAttribute( AppUserVO.RANK );
			
			/*
			var avatar:String = remoteuser.getAttribute(null, "avatar");
			var trivia:String = remoteuser.getAttribute(null, "trivia");
			*/
			
			// use the client id as a user name if the user hasn't set a name.
			if ( user.username == null )
			{
				// XXX: localize
				user.username = "user" + user.id;
			}
			
			// use "..." as a location if the user hasn't set a location.
			if ( user.location == null )
			{
				user.location = EMPTY_FIELD;
			}
			
			// get country name if this user hasn't set a location.
			/*
			if (location == EMPTY_FIELD || location == undefined || location == "undefined")
			{
			ipaddress = occupant.getIP();
			getLocationByIP();
			}
			*/
			
			// use "..." as the age if the user hasn't set one.
			if ( user.age == null )
			{
				user.age = EMPTY_FIELD;
			}
			
			// use "..." as a email address if the user hasn't set one.
			if ( user.email == null )
			{
				user.email = EMPTY_FIELD;
			}
			
			// use "..." if the user hasn't given a URL.
			if ( user.website == null )
			{
				user.website = EMPTY_FIELD;
			} 
			else
			{
				user.website = URLUtils.createHyperlink( user.website );
			}
			
			return user;
		}

		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * Dispatched when a new chat message wants to be send.
		 * 
		 * @param event
		 */		
		protected function onSubmitChatMessage( event:ChatEvent ):void
		{
			event.stopPropagation();
			
			var msg:BaseChatMessage = messageCreator.create( presence, PresenceProxy.SEND_MESSAGE,
															 event.data, true );
			presence.sendMessage( msg );
		}
		
		/**
		 * Dispatched when the number of occupants in a room changes while the
		 * current client is in, or observing, the room.
		 * 
		 * @param event
		 */		
		protected function numClients( event:BaseRoomEvent ):void
		{
			var totalClients:int;
			
			user = parseEvent( PresenceProxy.ROOM_CLIENT_COUNT, event );
			
			if ( user )
			{
				totalClients = event.data.getNumClients();
				
				// update view
				panel.numClients( totalClients );
			}
		}
		
		/**
		 * Add a new occupant to the <code>viewComponent</code>.
		 * 
		 * @param event
		 */		
		protected function addOccupant( event:BaseRoomEvent ):void
		{
			var user:UserVO = parseEvent( PresenceProxy.ROOM_CLIENT_ADD, event );
			
			if ( user )
			{
				// update view
				panel.addOccupant( user );
				
				// show join message for:
				// - users that are added *after* the local user *joined*
				// - local user
				if ( joined || user.client.isSelf() )
				{
					var msg:BaseChatMessage = messageCreator.create( presence, PresenceProxy.SEND_MESSAGE,
																	 ChatMessageTypes.JOIN, true );
					msg.sender = user.client;
					msg.receiver = user.client;
					presence.sendMessage( msg );
				}
			}
		}
		
		/**
		 * Remove occupant from the <code>viewComponent</code>.
		 *  
		 * @param event
		 */		
		protected function removeOccupant( event:BaseRoomEvent ):void
		{
			user = parseEvent( PresenceProxy.ROOM_CLIENT_REMOVE, event );
			
			if ( user )
			{
				// update view
				panel.removeOccupant( user );
				
				// show leave message
				var msg:BaseChatMessage = messageCreator.create( presence, PresenceProxy.SEND_MESSAGE,
																 ChatMessageTypes.LEAVE, false );
				msg.sender = user.client;
				msg.receiver = user.client;
				presence.sendMessage( msg );
			}
		}
		
		/**
		 * Joined room.
		 *  
		 * @param event
		 */		
		protected function joinedRoom( event:BaseRoomEvent ):void
		{
			// Note: union returns null for roomEvent.getClient(),
			// so we use presence.self instead, this may change in
			// a future version of union. We invoke the parseEvent
			// anyway to get a notification etc
			user = parseEvent( PresenceProxy.ROOM_JOINED, event );
			user = parseUser( presence.self );
			
			if ( user )
			{
				panel.joinedRoom( user );
				
				// connect to RTMP server
				presence.connectRTMP();
				
				// the local user joined the room
				// XXX: this should be a property on instances in the 'rooms' vector?
				joined = true;
			}
		}
		
		/**
		 * Triggered when one of the room's attributes changes.
		 *  
		 * @param event
		 */		
		protected function attributeUpdate( event:BaseRoomEvent ):void
		{
			event.preventDefault();
			
			sendNotification( PresenceProxy.ROOM_ATTRIBUTE_UPDATE, event );
		}
		
		/**
		 * Cast the <code>viewComponent</code> to its actual type.
		 * 
		 * @return BaseCommunicationPanel the viewComponent cast to com.collab.echo.hub.display.BaseCommunicationPanel
		 */
		protected function get panel():BaseCommunicationPanel
		{
			return viewComponent as BaseCommunicationPanel;
		}
		
    }
}