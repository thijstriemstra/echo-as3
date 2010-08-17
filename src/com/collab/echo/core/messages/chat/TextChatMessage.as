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
	import com.collab.echo.core.messages.ChatMessageTypes;
	import com.collab.echo.core.rooms.BaseRoom;
	import com.collab.echo.events.ChatMessageEvent;
	import com.collab.echo.model.UserVO;

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
		
		// XXX: localize etc
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
		public function TextChatMessage( type:String=null,
										 data:String=null,
										 room:BaseRoom=null,
										 includeSelf:Boolean=false,
										 local:Boolean=false,
										 privateMessage:Boolean=false,
										 append:Boolean=true )
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
				trace("TextChatMessage.parseCommand()");
				execute( data );
			}
		}
		
		/**
		 * @private
		 * @param command
		 */		
		override protected function execute( command:String ):void
		{
			var user:UserVO = room.parseUser( _sender );
			var username:String = user.username;
			
			//data = username;
			
			// XXX: add hyperlinks to msg	
			//data = URLUtils.hiliteURLs( command );

			if ( _sender == _receiver )
			{
				// local message
				message = '<font color="#990000"><b>' + username + ': </b>' +
						  command + '</font><br/>';
			}
			else
			{
				// add tags for staff
				// XXX: move ranks to constant
				// XXX: decorator?
				if ( user.rank == "admin" )
				{
					username = '<font color="#1D5EAB">' + username + '</font>';
				}
				else if ( user.rank == "moderator" )
				{
					username = '<font color="#1892AF">' + username + '</font>';
				}
				
				// remote message
				message = "<b>"+ username + ": </b>" + command;
			}
			
			trace('exec: ' + this);
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * @private 
		 */		
		override public function load():void
		{
			// XXX: add logging
			
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
			return "<TextChatMessage data='" + data + "' private='" + privateMessage +
				   "', local='" + local + "' message='" + message + "' type='" + type + "' />";	
		}
		
		/**
		 * Check whether it's a private message and give it a receiver.
		 * 
		 * @return Private message parser result message.
		 */		
		override public function checkForPrivateMessage():String
		{
			var msgsplit:Array = data.substr( ChatMessageTypes.PRIVATE_MESSAGE.length + 2
											).split( " : ", 2 );
			var parsedName:String = msgsplit[ 0 ];
			var msg:String = msgsplit[ 1 ];
			var id:String;
			
			// XXX: check for messages with whitespace-only?
			if ( msg && msg.length > 0 && msg != " " )
			{
				privateMessage = true;
			}
			else
			{
				privateMessage = false;
				local = true;
				
				// empty message
				// XXX: localize
				return "<b>Please provide a message.</b>";
			}
			
			if ( privateMessage )
			{
				trace("===================");
				trace('remote: ' + parsedName);
				//trace('local: ' + localName);
				var localName:String = "thijs";
				id = room.getClientIdByUsername( parsedName );
				
				if ( _sender != room.self )
				{
					// message targeted at remote client
					_receiver = room.getClientById( id );
					trace("receiver: " + _receiver);
					
					if ( _receiver != undefined )
					{
						if ( _receiver != room.self )
						{
							msg = '<font color="#B1661D"><b>' + localName + ' (private)</b>: ' + msg + '</font>';
						}
						else
						{
							privateMessage = false;
							local = true;
							
							msg = "<b>You can't send yourself private messages.</b>";
						}
					}
					else
					{
						privateMessage = false;
						local = true;
						
						// the remote username was not found
						msg = "<b>Username '" + parsedName + "' not found.</b>";
					}
				}
				else
				{
					privateMessage = false;
					local = true;
				
					// message targeted at local client
					if ( id == null )
					{
						// the remote username was not found
						msg = "<b>Username '" + parsedName + "' not found.</b>";
					}
					else if ( id != room.getClientId() )
					{
						// show message for remote client on local client
						msg = "<font color='#990000'><b>" + localName + ' ('+ parsedName +')</b>: ' + msg + "</font>";
					}
					else
					{
						msg = "<b>You can't send yourself private messages.</b>";
					}
				}
			}
			
			trace('pm: ' + this);
			
			return msg;
		}
		
	}
}