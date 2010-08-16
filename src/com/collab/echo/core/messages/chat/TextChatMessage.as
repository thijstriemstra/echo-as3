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
	import com.collab.echo.events.ChatMessageEvent;

	/**
	 * Simple text chat message.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class TextChatMessage extends ChatMessage
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		// XXX: localize
		public static const DOC	: String = "/msg [nickname] : [string]     ; send someone a private message.";
		
		/**
		 * Construct a new text chat message.
		 *  
		 * @param type
		 * @param data
		 * @param room
		 * @param includeSelf
		 * @param local
		 * @param privateMessage
		 * @param append
		 */		
		public function TextChatMessage( type:String=null, data:String=null,
										 room:BaseRoom=null,
										 includeSelf:Boolean=false, local:Boolean=false,
										 privateMessage:Boolean=false, append:Boolean=true )
		{
			super( type, data, room, includeSelf, local, privateMessage, append );
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * @private 
		 */		
		override protected function parseCommand():void
		{
			if ( _sender && _receiver )
			{
				execute( data );
			}
		}
		
		/**
		 * @private
		 * @param command
		 */		
		override protected function execute( command:String ):void
		{
			var username:String = room.parseUser( _sender ).username;
			
			// check it's a private message
			checkForPrivateMessage( username );
			
			// XXX: add hyperlinks to msg	
			//data = hiliteURLs( command );
			
			if ( privateMessage )
			{
				message = data;
			}
			else if ( _sender == _receiver )
			{
				// local message
				message = '<font color="#990000"><b>' + username + ': </b>' + command + '</font><br/>';
			}
			else
			{
				/* XXX: add tags for staff 
				if (rank == "admin")
				{
					username = '<font color="#1D5EAB">'+username+'</font>';
				}
				else if (rank == "moderator")
				{
					username = '<font color="#1892AF">'+username+'</font>';
				}
				*/
				
				// remote message
				message = "<b>"+ username + ": </b>" + command;
			}
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		override public function load():void
		{
			// XXX: addd logging
			// XXX: dispatch after async completed
			var evt:ChatMessageEvent = new ChatMessageEvent( ChatMessageEvent.LOAD_COMPLETE );
			evt.data = this;
			dispatchEvent( evt );
		}
		
		/**
		 * @private 
		 * @return 
		 */		
		override public function toString():String
		{
			return "<TextChatMessage data='" + data + "' local='" + local + "' type='" + type + "' />";	
		}
		
		// ====================================
		// PRIVATE METHODS
		// ====================================
		
		/**
		 * Check whether it's a private message and give it a receiver.
		 * 
		 * @param myName
		 */		
		private function checkForPrivateMessage( myName:String ):void
		{
			var msgsplit:Array = data.substr( 5 ).split( " : ", 2 );
			var userName:String = msgsplit[ 0 ];
			var msg:String = msgsplit[ 1 ];
			var foundIt:Object;
			
			// if its not an empty message
			if ( msg && msg.length > 0 )
			{
				privateMessage = true;
			}
			else
			{
				// empty message
				data = "<b>Please fill in a message.</b>";
			}
			
			if ( privateMessage )
			{
				// lookup username			
				foundIt = room.findUserName( userName );
			
				// if the username wasnt found
				if ( foundIt == null )
				{
					// XXX: localize
					data = "<b>Username '" + userName + "' not found.</b>";
				}
				else
				{
					// if youre not sending it to yourself
					if ( foundIt && foundIt.clientID != room.getClientId() )
					{
						data = '<font color="#B1661D"><b>' + myName + ' (private)</b>: ' + msg + '</font>';
						
						// XXX: print message on own client
						//data = "<font color='#990000'><b>" + myName + ' ('+ userName +')</b>: ' + msg + "</font>";
					}
					else
					{
						data = "<b>You can't send yourself private messages.</b>";
					}
				}
			}
		}
		
	}
}