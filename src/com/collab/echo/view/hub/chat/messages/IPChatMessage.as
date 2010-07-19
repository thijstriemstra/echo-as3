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
	public class IPChatMessage extends TextChatMessage
	{
		/**
		 * Constructor.
		 * 
		 * @param data
		 */		
		public function IPChatMessage( data:String=null )
		{
			super( data );
		}
		
		override protected function parseCommand():void
		{
			// the username
			var username:String = data.substr( 4 );
			
			// get the users ip
			execute( username );
		}
		
		/**
		 * Check the IP address.
		 * 
		 * @param message
		 */
		override protected function execute( message:String ):void
		{
			var timestamp	: Boolean 	= true; //getTargetMC().chat.menu_accordion.preferences_mc.timestamp_cb.selected;
			var clientList	:Array =[]; 		//		= getRoomManager().getRoom(AppSettings.fnsid).getClientIDs();
			var attrList 	:Array=[];//			= getRemoteClientManager().getAttributeForClients(clientList,null, "username");
			var foundIt		:Boolean 				= null;
			
			for (var i = 0; i < attrList.length; i++)
			{
				var clientName:String = attrList[i].value;
				
				// give user generic name
				if (clientName == undefined) {
					clientName = "user"+attrList[i].clientID;
				}
				
				// find other name
				if (clientName.toLowerCase() == message.toLowerCase()) {
					foundIt = attrList[i].clientID;
					break;
				}
			}
			
			// add Timestamp
			var addStamp:String = "";
			if (timestamp) 
			{
				addStamp = createClientStamp() + " ";
			} 
			
			// if the username wasnt found
			if ( foundIt == undefined )
			{
				//textArea.htmlText += addStamp + " <b>Username not found.</b>";
				
			}
			else
			{
				// Retrieve the IPAddress for the client.
				var ipaddress:String = "";//remoteuser.getAttribute(null, "_IP");
				
				//textArea.htmlText += addStamp + "<b>IPAddress for " + clientName + ": "+ ipaddress +" </b>";
			}
			
			//textArea.verticalScrollPosition = textArea.maxVerticalScrollPosition;
		}
		
		override public function toString():String
		{
			return "<IPChatMessage data='" + data + "' />";	
		}
		
	}
}