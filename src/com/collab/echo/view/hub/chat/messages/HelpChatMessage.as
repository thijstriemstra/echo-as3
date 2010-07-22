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
		protected var fields	: Array = [ TextChatMessage, NicknameChatMessage,
											MeChatMessage, ClearChatMessage,
											TimeOnlineMessage, IPChatMessage,
											KickMessage ];
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
			var field:Class;
			
			// XXX: localize
			data = "<b>Command List</b><br>";
			for each ( field in fields )
			{
				data += field["DOC"] + "<br/>";
			}
			
			execute( data.substr( 0, data.length -5 ));
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