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
	public class MeChatMessage extends TextChatMessage
	{
		/**
		 * Constructor.
		 * 
		 * @param data
		 */		
		public function MeChatMessage( type:String, data:String, includeSelf:Boolean=false )
		{
			super( type, data, includeSelf );
		}
		
		override protected function parseCommand():void
		{
			var bericht:String  = data.substr( 4 );
			
			if ( bericht.length > 0 )
			{
				execute( bericht );
			}
		}
		
		override protected function execute( message:String ):void
		{
			var safeMsg:String = '<![CDATA[' + message + ']]>';
			
			// Send the message to the server.
			//invokeOnRoom("meText", "collab.global", true, safeMsg);
			//invokeOnNamespace("meText", AppSettings.appNamespaceID, true, safeMsg);
		}
		
		/**
		 * Recieve special message!
		 */
		public function meText (clientID:String, msg:String):void
		{
			// Retrieve the username for the client that sent the message.
			//var remoteuser	: RemoteClient 	= getRemoteClientManager().getClient(clientID);
			//var username	: String 		= remoteuser.getAttribute(null, "username");
			
			// cutoff lines
			//truncateChatField(textArea);
			
			//textArea.htmlText +=  '<font color="#1B701F"><b>' + username + ' ' + msg + '</b></font><br>'
			//textArea.verticalScrollPosition = textArea.maxVerticalScrollPosition;
		}
		
		override public function toString():String
		{
			return "<MeChatMessage data='" + data + "' />";	
		}
		
	}
}