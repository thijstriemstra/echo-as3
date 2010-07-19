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
	public class NicknameChatMessage extends TextChatMessage
	{
		/**
		 * Constructor.
		 *  
		 * @param data
		 */		
		public function NicknameChatMessage( data:String=null )
		{
			super( data );
		}
		
		override protected function parseCommand():void
		{
			// change the users nickname
			var userName:String = data.substr( 6 );
			execute( userName );
		}
		
		override protected function execute( message:String ):void
		{
			if ( message.length > 0 )
			{
				// change name in panel
				//this.getTargetMC().chat.menu_accordion.preferences_mc.username_txt.text = userNaam;
				
				// send change to Unity
				//setName();
			}
		}
		
		override public function toString():String
		{
			return "<NicknameChatMessage data='" + data + "' />";	
		}
		
	}
}