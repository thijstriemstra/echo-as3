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
	/**
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class ClearChatMessage extends TextChatMessage
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		// XXX: localize
		public static const DOC	: String = "/clear     ; clear the text in the chat window.";
		
		/**
		 * Constructor.
		 * 
		 * @param type
		 * @param data
		 */		
		public function ClearChatMessage( type:String, data:String )
		{
			super( type, data, false, true, false, false );
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * @private 
		 */		
		override protected function parseCommand():void
		{
			// XXX: localize
			execute( "<b>Cleared chat.</b>" );
		}

		/**
		 * @private
		 * @param command
		 */		
		override protected function execute( command:String ):void
		{
			message = command;
		}		
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		override public function toString():String
		{
			return "<ClearChatMessage type='" + type + "' data='" + data +
				   "' local='" + local + "' />";		
		}
		
	}
}