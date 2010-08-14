/* * Echo project. * * Copyright (C) 2003-2010 Collab * * This program is free software: you can redistribute it and/or modify * it under the terms of the GNU General Public License as published by * the Free Software Foundation, either version 3 of the License, or * (at your option) any later version. * * This program is distributed in the hope that it will be useful, * but WITHOUT ANY WARRANTY; without even the implied warranty of * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the * GNU General Public License for more details. * * You should have received a copy of the GNU General Public License * along with this program.  If not, see <http://www.gnu.org/licenses/>. */package com.collab.echo.core{    import com.collab.echo.core.rooms.BaseRoom;    import com.collab.echo.events.BaseConnectionEvent;    import com.collab.echo.events.BaseRoomEvent;        import net.user1.logger.Logger;    import net.user1.reactor.Reactor;    import net.user1.reactor.ReactorEvent;    import net.user1.reactor.RoomManagerEvent;    import net.user1.reactor.XMLSocketConnection;    /**     * Observes clients.     *     * @author Thijs Triemstra     *      * @langversion 3.0 	 * @playerversion Flash 10     */    public class ClientManager implements IClientManager    {        // ====================================		// PRIVATE VARS		// ====================================        private var _connected      				: Boolean;        private var _clients      					: Array;		private var _hostUrl						: String;		private var _hostPort						: int;		private var _logging						: Boolean;		private var _watchingRooms					: Boolean;		private var _createRoomsOnWatch				: Boolean;		private var _roomQualifier					: String;		private var _rooms							: Vector.<BaseRoom>;		private var _conEvt							: BaseConnectionEvent;		        protected var logLevel						: String;                // XXX: move to union subclass        protected var reactor						: Reactor;        /**         * @return          */		        public function get connected():Boolean        {            return _connected;        }        /**         * Constructor.         *           * @param url         * @param port         * @param logging         */		        public function ClientManager( url:String="localhost", port:int=9110,        							   logging:Boolean=true ) : void        {            _hostPort = port;			_hostUrl = url;			_logging = logging;            _connected = false;            _watchingRooms = false;            _createRoomsOnWatch = true;            _clients = [];            			logLevel = Logger.DEBUG;			            connect();        }        /**         * Add a client.         *          * @param client         */		        public function subscribeClient( client : com.collab.echo.core.IClient ) : void        {            _clients.push( client );        }        /**         * Remove a client.         *           * @param client         */		        public function unsubscribeClient( client : com.collab.echo.core.IClient ) : void        {            for ( var ob:int = 0; ob < _clients.length; ob++ )            {                if ( _clients[ ob ] == client )                {                    _clients.splice( ob, 1 );                }            }        }        /**         * Notify all clients.         *           * @param notification         */		        public function notifyClient( notification:String, ...args:Array ) : void        {            for ( var notify:* in _clients )            {                _clients[ notify ].update( notification, args );            }        }                /**         * @param type         * @param method         * @param forRoomIDs         */                public function addMessageListener( type:String, method:Function, forRoomIDs:Array=null ):void        {        	if ( type )        	{        		if ( !reactor.getMessageManager().hasMessageListener( type, method ))        		{					reactor.getMessageManager().addMessageListener( type, method, forRoomIDs );        		}        	}        }                /**         * @param type         * @param method         */                public function removeMessageListener( type:String, method:Function ):void        {        	if ( type )        	{        		if ( reactor.getMessageManager().hasMessageListener( type, method ))        		{					reactor.getMessageManager().removeMessageListener( type, method );        		}        	}        }        /**         * XXX: DEMO METHOD         *           * @param q1         * @param q2         * @param q3         * @param q4         */		        public function setQuarter(q1 : Number, q2 : Number, q3 : Number, q4 : Number) : void        {            notifyClient( "foo" );        }                /**		 * Disconnect from server. 		 */				public function closeConnection():void		{			notifyClient( BaseConnectionEvent.DISCONNECTING );		}		/**		 * Ask to be notified when one or more rooms are updated on the server. 		 * 		 * <p>Optionally prevent the creation of the rooms when passing <code>false</code> for the		 * <code>create</code> flag.</p>		 * 		 * @param rooms		 * @param create		 */				public function watchForRooms( rooms:Vector.<BaseRoom>, create:Boolean=true ):void		{			_watchingRooms = true;			_createRoomsOnWatch = create;			_rooms = rooms;						// watch			if ( _connected )			{				watchRooms();			}		}				// ====================================		// PROTECTED METHODS		// ====================================				/**		 * Watch for rooms.		 */				protected function watchRooms():void		{			// watch for rooms			// XXX: find common room qualifier			reactor.getRoomManager().watchForRooms( "collab.rooms.*" );			// in response to this watchForRooms() call, the RoomManager will trigger 			// RoomManagerEvent.ROOM_ADDED and RoomManagerEvent.ROOM_REMOVED events.			reactor.getRoomManager().addEventListener( RoomManagerEvent.ROOM_ADDED, 	roomAddedListener );			reactor.getRoomManager().addEventListener( RoomManagerEvent.ROOM_REMOVED, 	roomRemovedListener );			reactor.getRoomManager().addEventListener( RoomManagerEvent.ROOM_COUNT, 	roomCountListener );						// create			if ( _createRoomsOnWatch )			{				createRooms();			}		}				/**		 * Create rooms.		 */				protected function createRooms():void		{			var room:BaseRoom;			for each ( room in _rooms )			{				// listen for events				room.addEventListener( BaseRoomEvent.ADD_OCCUPANT, addOccupant );				room.addEventListener( BaseRoomEvent.REMOVE_OCCUPANT, removeOccupant );				room.addEventListener( BaseRoomEvent.OCCUPANT_COUNT, numClients );				room.addEventListener( BaseRoomEvent.JOIN_RESULT, joinedRoom );				room.addEventListener( BaseRoomEvent.ATTRIBUTE_UPDATE, attributeUpdate );								// create				room.create( reactor );			}		}				/**         * Connect to server.         */		        protected function connect():void        {            if ( _hostUrl && _hostPort )            {            	// notify others				notifyClient( BaseConnectionEvent.CONNECTING );			                trace( "Connecting to Union server on " + _hostUrl + ":" + _hostPort );                // create reactor                reactor = new Reactor( "", _logging );                                // logging                if ( logLevel )                {                	reactor.getLog().setLevel( logLevel );                }                                // listeners                reactor.addEventListener( ReactorEvent.READY, unionConnectionReady );                reactor.addEventListener( ReactorEvent.CLOSE, unionConnectionClose );                                // XXX: xml connection                reactor.getConnectionManager().addConnection( new XMLSocketConnection( _hostUrl, _hostPort ));                                // connect                _connected = false;                reactor.connect();            }        }        		/**		 * Triggered when the connection is established and ready for use.		 */		protected function connectionReady():void		{			_connected = true;			notifyClient( BaseConnectionEvent.CONNECTION_SUCCESS );						if ( _watchingRooms )			{				watchRooms();			}		}		/**		 * Triggered when the connection is closed.		 */		protected function connectionClosed():void		{            _connected = false;			notifyClient( BaseConnectionEvent.CONNECTION_CLOSED );		}		        // ====================================		// EVENT HANDLERS		// ====================================        /**		 * Triggered when the connection is established and ready for use.		 *		 * @param event		 */		protected function unionConnectionReady( event:ReactorEvent ):void		{            if ( event )            {			    event.preventDefault();            }			connectionReady();		}		/**		 * Triggered when the connection is closed.		 *		 * @param event		 */		protected function unionConnectionClose( event:ReactorEvent ):void		{			if ( event )			{				event.preventDefault();			}						connectionClosed();		}				/**		 * Event listener triggered when a room is added to the          * room manager's room list.		 *	 		 * @param event		 */				protected function roomAddedListener( event:RoomManagerEvent ):void		{			event.preventDefault();						_conEvt = new BaseConnectionEvent( BaseConnectionEvent.ROOM_ADDED, event );			notifyClient( _conEvt.type, _conEvt );		}				/**		 * Event listener triggered when a room is removed from the          * room manager's room list.		 * 		 * @param event		 */				protected function roomRemovedListener( event:RoomManagerEvent ):void		{			event.preventDefault();						_conEvt = new BaseConnectionEvent( BaseConnectionEvent.ROOM_REMOVED, event );			notifyClient( _conEvt.type, _conEvt );						// XXX: cleanup corresponding baseroom instance		}				/**		 * Event listener triggered when the number of rooms has changed.		 * 		 * @param event		 */				protected function roomCountListener( event:RoomManagerEvent ):void		{			event.preventDefault();						_conEvt = new BaseConnectionEvent( BaseConnectionEvent.ROOM_COUNT, event );			notifyClient( _conEvt.type, _conEvt );		}		/**		 * Dispatched when the number of occupants in a room changes while the		 * current client is in, or observing, the room.		 *		 * @param event		 */		protected function numClients( event:BaseRoomEvent ):void		{			event.preventDefault();						notifyClient( event.type, event.data.getNumClients() );		}		/**		 * Add a new occupant to the room.		 *		 * @param event		 */		protected function addOccupant( event:BaseRoomEvent ):void		{			event.preventDefault();						notifyClient( event.type, event );		}		/**		 * Remove occupant from the room.		 *		 * @param event		 */		protected function removeOccupant( event:BaseRoomEvent ):void		{			event.preventDefault();						notifyClient( event.type, event );		}		/**		 * Joined room.		 *		 * @param event		 */		protected function joinedRoom( event:BaseRoomEvent ):void		{			event.preventDefault();						notifyClient( event.type, event );		}		/**		 * Triggered when one of the room's attributes changes.		 *		 * @param event		 */		protected function attributeUpdate( event:BaseRoomEvent ):void		{			event.preventDefault();			notifyClient( event.type, event );		}		    }}