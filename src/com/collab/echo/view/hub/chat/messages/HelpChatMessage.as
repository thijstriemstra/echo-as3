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
	/**
	 * @author Thijs Triemstra
	 */	
	public class HelpChatMessage extends TextChatMessage
	{
		public var types	: Array;
		
		/**
		 * Constructor.
		 * 
		 * @param type
		 * @param data
		 */		
		public function HelpChatMessage( type:String, data:String )
		{
			super( type, data, null, false, true, false, true );
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * Compile list based on available commands. 
		 */		
		override protected function parseCommand():void
		{
			trace(types);
			
			// XXX: localize
			// XXX: compile list based on available commands, something like BaseChatMessage.help
			data = "<b>Command List</b><br>";
			data += "/msg [nickname] : [string]     ; send someone a private message.<br>";
			data += "/nick [nickname]   ; change your nickname.<br>";
			data += "/stats    ; Application bandwidth stats.<br>";
			data += "/clear     ; clear the text in the chat window.<br>";
			data += "/timeOnline [nickname]  ; find out how long the user has been online.<br>";
			data += "/quote    ; random quote from 'famous' people.<br>";
			data += "/me [message] <br>";
			data += "/eliza [string]   ; Eliza is a 24/7 psychotherapist.<br>";
			data += "/alice [message]   ; A.L.I.C.E. is a natural language robot.<br>";
			data += "/mrtrivia [message]   ; QuizMaster bot.";
			
			// XXX: add additional app items
			//if (_root.userMode != "guest")
			//{
				//data += "/ip [nickname]   ; get user's IP address.<br>";
				//data += "/kick [nickname]   ; kick a user.<br>";
			//}
			
			execute( data );
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		override public function toString():String
		{
			return "<HelpChatMessage type='" + type + "' data='" + data +
				   "' local='" + local + "' append='" + append + "' />";		
		}
		
	}
}