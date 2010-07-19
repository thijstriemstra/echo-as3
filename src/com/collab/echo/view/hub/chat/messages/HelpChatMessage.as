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
		/**
		 * Constructor.
		 *  
		 * @param data
		 */		
		public function HelpChatMessage( type:String, data:String, includeSelf:Boolean=false )
		{
			super( type, data, includeSelf );
		}
		
		override protected function parseCommand():void
		{
			/*
			textArea.text += "<b>Command List</b><br>";
			textArea.text += "/msg [nickname] : [string]     ; send someone a private message.<br>";
			textArea.text += "/nick [nickname]   ; change your nickname.<br>";
			textArea.text += "/stats    ; FlashCom application bandwidth stats.<br>";
			textArea.text += "/clear     ; clear the text in the chat window.<br>";
			textArea.text += "/timeOnline [nickname]  ; find out how long the user has been online.<br>";
			textArea.text += "/quote    ; random quote from 'famous' people.<br>";
			textArea.text += "/me [message] <br>";
			textArea.text += "/eliza [string]   ; Eliza is a 24/7 psychotherapist.<br>";
			textArea.text += "/alice [message]   ; A.L.I.C.E. is a natural language robot.<br>";
			textArea.text += "/mrtrivia [message]   ; QuizMaster bot.<br>";
			// add staff items
			//if (_root.userMode != "guest")
			//{
			textArea.text += "/ip [nickname]   ; get user's IP address.<br>";
			textArea.text += "/kick [nickname]   ; kick a user.<br>";
			//}
			*/
		}
		
		override public function toString():String
		{
			return "<HelpChatMessage data='" + data + "' />";	
		}
		
	}
}