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
	import com.collab.echo.model.UserVO;
	
	import flash.system.Capabilities;

	/**
	 * Chat message displayed when joining the chatroom.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class JoinChatMessage extends TextChatMessage
	{
		/**
		 * Constructor.
		 * 
		 * @param type
		 * @param data
		 * @param room
		 */		
		public function JoinChatMessage( type:String, data:String, room:BaseRoom )
		{
			super( type, data, room, false, true, false, true );
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
			var user:UserVO = room.parseUser( _sender );
			var username:String = user.username;
			var clientID:String = user.id;
			
			// local client
			if ( _receiver == _sender )
			{
				// XXX: move rank to parseUser
				var clientVar:String;
				var value:String;
				
				// XXX: move this
				for each ( clientVar in UserVO.fields )
				{
					// XXX: fix cookie
					//value = Echo.userCookie.data[ clientVar ];
					
					// SO already contains the var
					if ( value != null )
					{
						_sender.setAttribute( clientVar, value );
						//user[ clientVar ] = value;
					}
				}
				
				// set user rank
				_sender.setAttribute( "rank", user.rank );
				
				// XXX: move elsewhere
				/* increment personal visitor counter
				if ( Echo.userCookie.data.counter != null )
				{
					Echo.userCookie.data.counter++;
				}
				else
				{
					Echo.userCookie.data.counter = 0;
				}
				*/
				
				message = "<b><font color='#000000'>" + getWelcomeLine() + " " + username + "!</font></b><br>";
				// XXX: localize
				message += "<b><font color='#4F4F4F'>Chat is now active...</font></b><br>";
				message += "<b><font color='#4F4F4F'>Type /help for options.</font></b><br>";
			}
			else
			{
				// XXX: move ranks to constant
				if ( user.rank == "admin" )
				{
					message = "<font color='#1D5EAB'>" + message + "</font>";
				}
				else if ( user.rank == "moderator")
				{
					message = "<font color='#1892AF'>" + message + "</font>";
				}
				
				// XXX: localize
				message = "<b>" + username + " has joined.</b>";
			}
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * @private 
		 * @return 
		 */		
		override public function toString():String
		{
			return "<JoinChatMessage data='" + data + "' local='" + local + "' type='" + type + "' />";	
		}
		
		// ====================================
		// PRIVATE METHODS
		// ====================================
		
		/**
		 * Create a welcome message depending on the computer locale.
		 * 
		 * @return
		 */
		private function getWelcomeLine():String
		{
			// XXX: localize
			var welcome:String = "Welcome";
			
			switch ( Capabilities.language )
			{
				case "fr":
					welcome = "Bienvenue";
					break;
				
				case "de":
					welcome = "Willkommen";
					break;
				
				case "nl":
					welcome = "Welkom";
					break;
				
				case "it":
					welcome = "Benvenuto";
					break;
				
				case "pt":
					welcome = "Boa vinda";
					break;
				
				case "es":
					welcome = "Recepción";
					break;
			}
			
			return welcome;
		}
		
	}
}