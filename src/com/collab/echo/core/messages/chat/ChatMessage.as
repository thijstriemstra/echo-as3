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
package com.collab.echo.core.messages.chat
{
	import com.collab.echo.core.rooms.BaseRoom;
	
	import flash.events.EventDispatcher;

	/**
	 * Abstract class for chat message.
	 * 
	 * @author Thijs Triemstra
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class ChatMessage extends EventDispatcher
	{
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		// XXX: sender and receiver need to be refactored
		/**
		 * @private 
		 */		
		internal var _receiver						: *;
		
		/**
		 * @private 
		 */		
		internal var _sender						: *;
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _message						: String;
		private var _type							: String;
		private var _doc							: String;
		private var _privateMessage					: Boolean;
		private var _includeSelf					: Boolean;
		private var _local							: Boolean;
		private var _append							: Boolean;
		private var _room							: BaseRoom;
		private var _data							: String;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		/**
		 * @return 
		 */		
		public function get data():String
		{
			return _data;
		}
		public function set data( val:String ):void
		{
			_data = val;
		}
		
		/**
		 * The target room for this message.
		 * 
		 * @return 
		 */		
		public function get room():BaseRoom
		{
			// XXX: make this rooms?
			return _room;
		}
	
		/**
		 * The sending client.
		 * 
		 * @return 
		 */		
		public function get sender():*
		{
			return _sender;
		}
		public function set sender( val:* ):void
		{
			if ( val )
			{
				_sender = val;
				
				if ( _sender == _receiver )
				{
					_local = true;
				}
				
				parseCommand();
			}
		}
		
		/**
		 * The receiving client.
		 * 
		 * @return 
		 */		
		public function get receiver():*
		{
			return _receiver;
		}
		public function set receiver( val:* ):void
		{
			if ( val )
			{
				_receiver = val;
				
				if ( _receiver == _sender )
				{
					_local = true;
				}
					
				parseCommand();
			}
		}
		
		/**
		 * @return 
		 */		
		public function get append():Boolean
		{
			return _append;
		}
		
		/**
		 * Whether or not to send this message to the server.
		 * 
		 * @return 
		 */		
		public function get local():Boolean
		{
			return _local;
		}	
		public function set local( val:Boolean ):void
		{	
			_local = val;
		}
		
		/**
		 * Message type.
		 * 
		 * @return 
		 */		
		public function get type():String
		{
			return _type;
		}
		public function set type( val:String ):void
		{
			_type = val;
		}
		
		/**
		 * Whether or not to include the own client when the server sends the message to the
		 * room clients.
		 * 
		 * @return 
		 */		
		public function get includeSelf():Boolean
		{
			return _includeSelf;
		}
		
		/**
		 * This is a private message and only targeted at the <code>_receiver</code>
		 * client.
		 * 
		 * @return 
		 */		
		public function get privateMessage():Boolean
		{
			return _privateMessage;
		}
		public function set privateMessage( val:Boolean ):void
		{
			if ( val )
			{
				_privateMessage = val;
			}
		}
		
		/**
		 * Output data.
		 *  
		 * @return 
		 */		
		public function get message():String
		{
			return _message;
		}
		public function set message( val:String ):void
		{
			if ( val )
			{
				_message = val;
			}
		}
		
		/**
		 * Documentation.
		 *  
		 * @return 
		 */		
		public function get doc():String
		{
			return _doc;
		}
		public function set doc( val:String ):void
		{
			if ( val )
			{
				_doc = val;
			}
		}
		
		/**
		 * Constructor.
		 *  
		 * @param type
		 * @param data
		 * @param room
		 * @param includeSelf
		 * @param local
		 * @param privateMessage
		 * @param append
		 */		
		public function ChatMessage( type:String=null,
									 data:String=null,
									 room:BaseRoom=null,
									 includeSelf:Boolean=false,
									 local:Boolean=false,
									 privateMessage:Boolean=false,
									 append:Boolean=true )
		{
			_type = type;
			_message = data;
			_room = room;
			_privateMessage = privateMessage;
			_includeSelf = includeSelf;
			_local = local;
			_append = append;

			this._data = data;
			
			super();
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * 
		 */		
		protected function parseCommand():void
		{
			// override in subclass
		}
		
		/**
		 * @param command
		 */		
		protected function execute( command:String ):void
		{
			// override in subclass
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * 
		 */		
		public function load():void
		{
			// override in subclass
		}
		
		/**
		 * Check whether it's a private message and give it a receiver.
		 * 
		 * @return result
		 */		
		public function checkForPrivateMessage():String
		{
			// override
			return null;
		}
		
		/**
		 * @private 
		 * @return 
		 */		
		override public function toString():String
		{
			return "<ChatMessage data='" + _data + "' local='" + _local +
				   "' append='" + append + "' />";	
		}
		
	}
}