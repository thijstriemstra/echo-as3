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
	import com.collab.echo.view.hub.display.BaseCommunicationPanel;
	
	import net.user1.reactor.AttributeEvent;
	import net.user1.reactor.RoomEvent;
	import net.user1.reactor.RoomManagerEvent;
	import net.user1.reactor.UpdateLevels;
	
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
		
		internal var _rooms					: Array;
		
		// ====================================
		// ACCESSOR/MUTATOR
		// ====================================
		
		public function get rooms()			: Array
		{
			return _rooms;
		}
		public function set rooms( val:Array ):void
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
		 * 
		 */		
		protected function createRooms():void
		{
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
						PresenceProxy.ROOM_ADDED,
						PresenceProxy.ROOM_REMOVED,
						PresenceProxy.ROOM_JOINED,
						PresenceProxy.ROOM_ATTRIBUTE_UPDATE,
						PresenceProxy.ROOM_CLIENT_COUNT
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
			var managerEvent:RoomManagerEvent;
			var roomEvent:RoomEvent;
			var attributeEvent:AttributeEvent;
			
			switch ( name )
			{
				case PresenceProxy.CONNECTING:
					// TODO
					break;
				
				case PresenceProxy.CONNECTION_SUCCESS:
					// TODO
					break;
				
				case PresenceProxy.ROOM_ADDED:
					managerEvent = RoomManagerEvent( note.getBody() );
					
					// There's a new room, so update the on-screen room list.
					updateRoomList();
					
					// Ask to be notified when the new room's client-count changes. Once the
					// room is observed, if other clients join the room, this client will
					// be notified. UpdateLevel values specify how much information this
					// client should be told about the room. This is a lobby, so we want
					// the room's occupant count only.
					var updateLevels:UpdateLevels = new UpdateLevels();
					updateLevels.clearAll();
					updateLevels.occupantCount = true;
					managerEvent.getRoom().observe( null, updateLevels );
					
					// XXX
					// Register to be notified any time the new room's client count changes.
					//managerEvent.getRoom().addEventListener( RoomEvent.OCCUPANT_COUNT, 
					// roomClientCountListener );
					break;

				case PresenceProxy.ROOM_REMOVED:
					managerEvent = RoomManagerEvent( note.getBody() );
					updateRoomList();
					break;
				
				case PresenceProxy.ROOM_JOINED:
					roomEvent = RoomEvent( note.getBody() );
					break;
				
				case PresenceProxy.ROOM_ATTRIBUTE_UPDATE:
					attributeEvent = AttributeEvent( note.getBody() );
					
					/*
					var magnetData:Array;
					var magnet:Magnet;
					
					// If the changed attribute's name begins with "magnet"
					if (e.getChangedAttr().name.indexOf("magnet") == 0)
						{
						// If a magnet by the specified name exists in the magnets hash...
						magnet = magnets[e.getChangedAttr().name];
						if (magnet != null)
						{
						// The magnet exists. Check if it is being dragged. If not, 
						// move it to the location specified by the room attribute value.
						if (!magnet.isDragging()) {
						magnetData = e.getChangedAttr().value.split(",");
						magnet.x = parseInt(magnetData[1]);
						magnet.y = parseInt(magnetData[2]);
						}
						}
					}
					*/
					break;
				
				case PresenceProxy.ROOM_CLIENT_COUNT:
					roomEvent = RoomEvent( note.getBody() );
					
					updateRoomList();
					break;
			}
        }

		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * The number of clients in one of the rooms changed, so update 
		 * the on-screen room list to show the new client count.
		 * 
		 * @param event
		 */		
		protected function roomClientCountListener( event:RoomEvent ):void
		{
			trace( "Users connected: " + event.getNumClients() );
		}

		// ====================================
		// INTERNAL METHODS
		// ====================================
		
		/**
		 * Display the list of rooms in a text field. 
		 */		
		internal function updateRoomList():void
		{
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