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
	public class ClearChatMessage extends TextChatMessage
	{
		/**
		 * Constructor.
		 *  
		 * @param data
		 */		
		public function ClearChatMessage( type:String, data:String, includeSelf:Boolean=false )
		{
			super( type, data, includeSelf );
		}
		
		override protected function parseCommand():void
		{
			// clear chat txt window
			//textArea.htmlText = "<b>Cleared.</b>";
		}
		
		override protected function execute( message:String ):void
		{
		}
		
		override public function toString():String
		{
			return "<ClearChatMessage data='" + data + "' />";	
		}
		
	}
}