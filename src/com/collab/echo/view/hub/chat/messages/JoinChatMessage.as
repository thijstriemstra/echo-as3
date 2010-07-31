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
	import com.collab.echo.Echo;
	import com.collab.site.common.model.proxy.PresenceProxy;
	import com.collab.site.common.model.vo.UserVO;
	
	import flash.system.Capabilities;

	/**
	 * @author Thijs Triemstra
	 */	
	public class JoinChatMessage extends TextChatMessage
	{
		/**
		 * Constructor.
		 * 
		 * @param type
		 * @param data
		 * @param presence
		 */		
		public function JoinChatMessage( type:String, data:String,
										 presence:PresenceProxy )
		{
			super( type, data, presence, false, true, false, true );
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		override protected function parseCommand():void
		{
			if ( _sender && _receiver )
			{
				execute( data );
			}
		}
		
		override protected function execute( command:String ):void
		{
			// XXX: this should come from a populated UserVO
			var username:String = _receiver.getAttribute( UserVO.USERNAME );
			var clientID:String = _receiver.getClientID();
			
			// use the client id as a user name if the user hasn't set a name.
			if ( username == null )
			{
				username = "user" + clientID;
			}
			
			if ( _receiver == presence.self )
			{
				var rank:String = "guest";
				var clientVar:String;
				var value:String;
				
				// set clientVars
				for each ( clientVar in UserVO.fields )
				{
					value = Echo.userCookie.data[ clientVar ];
					
					// SO already contains the var
					if ( value != null )
					{
						_sender.setAttribute( clientVar, value );
						//user[ clientVar ] = value;
					}
				}
				
				// set user rank
				_sender.setAttribute( "rank", rank );
				
				// increment personal visitor counter
				if ( Echo.userCookie.data.counter != null )
				{
					Echo.userCookie.data.counter++;
				}
				else
				{
					Echo.userCookie.data.counter = 0;
				}
				
				// XXX: localize
				message = "<b><FONT COLOR='#000000'>" + getWelcomeLine() + " " + username + "!</FONT></b><br>";
				message += "<b><FONT COLOR='#4F4F4F'>Chat is now active...</FONT></b><br>";
				message += "<b><FONT COLOR='#4F4F4F'>Type /help for options.</FONT></b><br>";
			}
			else
			{
				/*
				if ( rank == "admin" )
				{
					coloredName = "<font color='#1D5EAB'>"+ coloredName +"</font>";
				}
				else if ( rank == "moderator")
				{
					coloredName = "<font color='#1892AF'>"+ coloredName +"</font>";
				}
				*/
				
				// XXX: localize
				message = "<b>"+ username +" has joined.</b>";
			}
		}
		
		override public function toString():String
		{
			return "<JoinChatMessage data='" + data + "' local='" + local + "' type='" + type + "' />";	
		}
		
		/**
		 * Create a welcome message depending on the computer locale.
		 * 
		 * @return
		 */
		internal function getWelcomeLine():String
		{
			var welcome:String = "Welcome";
			
			// XXX: localize
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