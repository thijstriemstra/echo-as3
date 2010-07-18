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
	import com.collab.echo.view.events.BaseRoomEvent;
	import com.collab.echo.view.hub.display.BaseCommunicationPanel;
	import com.collab.echo.view.rooms.BaseRoom;
	
	import net.user1.reactor.Client;
	
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
        
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		internal var _rooms					: Vector.<RoomVO>;
		
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
            // pass the viewComponent to the superclass where 
            // it will be stored in the inherited viewComponent property
            super( NAME, viewComponent );
        }

		// ====================================
		// PUBLIC/PROTECTED METHODS
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
		 * Create connection.
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
         * <P>Automatically called by the framework when the mediator
         * is registered with the view.</P>
         * 
         * @return Array the list of Notification names
         */
        override public function listNotificationInterests():Array 
        {
            return [ 
						PresenceProxy.CONNECTING,
						PresenceProxy.CONNECTION_SUCCESS,
						PresenceProxy.CONNECTION_CLOSED,
						PresenceProxy.DISCONNECTING
					];
        }
		
        /**
         * Handle all notifications this <code>Mediator</code> is interested in.
         * 
         * <p>Called by the framework when a notification is sent that
         * this mediator expressed an interest in when registered
         * (see <code>listNotificationInterests</code>).</p>
         * 
         * @param note A notification 
         */
        override public function handleNotification( note:INotification ):void 
        {
        	var name:String = note.getName();
			var baseRoomEvent:BaseRoomEvent;
			
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
			}
        }

		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * Dispatched when the number of occupants in a room changes while the
		 * current client is in or observing the room.
		 * 
		 * @param event
		 */		
		protected function numClients( event:BaseRoomEvent ):void
		{
			event.preventDefault();
			
			sendNotification( PresenceProxy.ROOM_CLIENT_COUNT, event );
		}
		
		/**
		 * @param event
		 */		
		protected function addOccupant( event:BaseRoomEvent ):void
		{
			event.preventDefault();
			
			sendNotification( PresenceProxy.ROOM_CLIENT_ADD, event );
		}
		
		/**
		 * Remove clients.
		 *  
		 * @param event
		 */		
		protected function removeOccupant( event:BaseRoomEvent ):void
		{
			event.preventDefault();
			
			sendNotification( PresenceProxy.ROOM_CLIENT_REMOVE, event );
		}
		
		/**
		 * Joined room.
		 *  
		 * @param event
		 */		
		protected function joinedRoom( event:BaseRoomEvent ):void
		{
			event.preventDefault();
			
			sendNotification( PresenceProxy.ROOM_JOINED, event );
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
		 * @param client
		 * @return 
		 */		
		protected function getUnionOccupant( client:* ):Client
		{
			return Client( client );	
		}
		
        /**
         * Cast the viewComponent to its actual type.
         * 
         * <p>Here, we cast the generic viewComponent to 
         * its actual type in a protected mode. This 
         * retains encapsulation, while allowing the instance
         * (and subclassed instance) access to a 
         * strongly typed reference with a meaningful
         * name.</p>
         * 
         * @return BaseCommunicationPanel the viewComponent cast to com.collab.echo.hub.display.BaseCommunicationPanel
         */
        protected function get panel():BaseCommunicationPanel
		{
            return viewComponent as BaseCommunicationPanel;
        }
		
    }
}