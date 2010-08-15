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
	import flash.events.EventDispatcher;
	
	import net.user1.reactor.IClient;

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
		// PROTECTED VARS
		// ====================================
		
		protected var data							: String;
		
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		// XXX: sender and receiver need to be refactored
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
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
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
		
		/**
		 * @return 
		 */		
		public function get type():String
		{
			return _type;
		}
		
		/**
		 * @return 
		 */		
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
		 * @param includeSelf
		 * @param local
		 * @param privateMessage
		 * @param append
		 */		
		public function ChatMessage( type:String=null,
									 data:String=null,
									 includeSelf:Boolean=false,
									 local:Boolean=false,
									 privateMessage:Boolean=false,
									 append:Boolean=true )
		{
			_type = type;
			_message = data;
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
		
		/**
		 * @private 
		 * @return 
		 */		
		override public function toString():String
		{
			return "<ChatMessage data='" + data + "' local='" + _local +
				   "' append='" + append + "' />";	
		}
		
	}
}