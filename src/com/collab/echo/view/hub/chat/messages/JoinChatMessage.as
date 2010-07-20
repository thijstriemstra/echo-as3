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
	import com.collab.echo.view.hub.chat.factory.ChatMessageTypes;
	
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
		public function JoinChatMessage( type:String=null, data:String=null,
										 presence:PresenceProxy=null )
		{
			super( type, data, presence, true, false, false, true );
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		override protected function parseCommand():void
		{
			var name:String = data.substr( ChatMessageTypes.JOIN.length + 1 );
			
			execute( name );
		}
		
		override protected function execute( command:String ):void
		{
			var coloredName:String = command;
			
			if ( local )
			{
				// XXX: localize
				message = "<b><FONT COLOR='#000000'>" + getWelcomeLine() + " " + coloredName + "!</FONT></b><br>";
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
				message = "<b>"+ coloredName +" has joined.</b>";
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