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
package com.collab.echo.view.hub.chat.messages
{
	import com.collab.echo.model.proxy.PresenceProxy;
	
	import flash.events.EventDispatcher;
	
	import net.user1.reactor.IClient;

	/**
	 * ABSTRACT Class (should be subclassed and not instantiated).
	 *  
	 * @author Thijs Triemstra
	 */	
	public class BaseChatMessage extends EventDispatcher
	{
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		protected var data							: String;
		
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		// XXX: no union specific references here.
		/**
		 * @private 
		 */		
		internal var _receiver						: IClient;
		
		/**
		 * @private 
		 */		
		internal var _sender						: IClient;
		
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
		private var _presence						: PresenceProxy;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		/**
		 * @return 
		 */		
		public function get presence():PresenceProxy
		{
			return _presence;
		}
		public function set presence( val:PresenceProxy ):void
		{
			if ( val )
			{
				_presence = val;
			}
		}
		
		/**
		 * @return 
		 */		
		public function get sender():IClient
		{
			return _sender;
		}
		public function set sender( val:IClient ):void
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
		 * @return 
		 */		
		public function get receiver():IClient
		{
			return _receiver;
		}
		public function set receiver( val:IClient ):void
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
		
		public function get type():String
		{
			return _type;
		}
		
		public function get includeSelf():Boolean
		{
			return _includeSelf;
		}
		
		/**
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
		 * @param presence
		 * @param includeSelf
		 * @param local
		 * @param privateMessage
		 * @param append
		 */		
		public function BaseChatMessage( type:String=null,
										 data:String=null,
										 presence:PresenceProxy=null,
										 includeSelf:Boolean=false,
										 local:Boolean=false,
										 privateMessage:Boolean=false,
										 append:Boolean=true )
		{
			_type = type;
			_message = data;
			_presence = presence;
			_privateMessage = privateMessage;
			_includeSelf = includeSelf;
			_local = local;
			_append = append;

			this.data = data;
			
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
		
		override public function toString():String
		{
			return "<BaseChatMessage data='" + data + "' local='" + _local +
				   "' append='" + append + "' />";	
		}
		
	}
}