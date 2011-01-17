/*
Echo project.

Copyright (C) 2003-2011 Collab

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
	import com.collab.echo.core.rooms.BaseRoom;
	
	/**
	 * Kick a user.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class KickMessage extends TextChatMessage
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		// XXX: localize
		public static const DOC	: String = "/kick [nickname]   ; kick a user.";
		
		/**
		 * Constructor.
		 * 
		 * @param type
		 * @param data
		 * @param room
		 */		
		public function KickMessage( type:String, data:String, room:BaseRoom )
		{
			super( type, data, room, false, true, true, true );
		}
		
		/**
		 * @private 
		 */		
		override protected function parseCommand():void
		{
			// change the users nickname
			var userName:String = data.substr( 6 );
			execute( userName );
		}
		
		/**
		 * @private 
		 * @return 
		 */		
		override public function toString():String
		{
			return "<KickMessage data='" + data + "' />";	
		}
		
		/**
		 * Kick a client
		 */
		internal function kickUser (userName:String):void
		{
			/*
			var clientList						= getRoomManager().getRoom(AppSettings.fnsid).getClientIDs();
			var attrList 						= getRemoteClientManager().getAttributeForClients(clientList,null, "username");
			
			var kickClientID = undefined;
			
			for (var i = 0; i < attrList.length; i++) 
			{
				var clientName:String = attrList[i].value;
				
				// give user generic name
				if (clientName == undefined) {
					clientName = "user"+attrList[i].clientID;
				}
				
				if (clientName.toLowerCase() == userName.toLowerCase()) {
					// the to be kicked user was found
					kickClientID = attrList[i].clientID;
				}
				
				if (getClientID() == attrList[i].clientID) {
					// identify the kicker
					var kicker:String = attrList[i].value;
				}
			}
			
			//trace("kicking: "+kickClientID+", by " + kicker);
			
			// if the username wasnt found
			if (kickClientID == undefined) 
			{
				chatMC.chat_txt.text += addStamp + " <b>Username not found.</b>";
			} 
			else
			{
				// user is found
				if (userName != kicker) {
					// Invoke the function on the client.
					invokeOnClient("beingKicked", kickClientID, userName, kicker);
					
					// Retrieve the IPAddress for the client.
					var remoteuser:RemoteClient = getRemoteClientManager().getClient(kickClientID);
					var ipaddress:String = remoteuser.getAttribute(null, "_IP");
					
					// log the kick
					var logMessage_pc:PendingCall = getTargetMC().mainService.logMessage(kicker, userName, ipaddress, 2); 
					logMessage_pc.responder = new RelayResponder(this, "logMessage_Result", "onCategoryFault" );
					
				} else {
					chatMC.chat_txt.text += addStamp + " <b>Don't kick yourself!</b>";
				}
				
				chatMC.chat_txt.vPosition = chatMC.chat_txt.maxVPosition;
			}
			*/
		}
		
		/**
		 * Receiving the boot and telling the others who did it.
		 */
		internal function beingKicked (clientID:String, userName:String, kicker:String):void
		{
			//trace("kicking: "+userName+" , " + kicker);
			// Send the message to the server.
			var safeMsg:String = "<font color='#CE0000'><b>"+ userName +" was kicked by " +  '!</b></font>';
			
			// Tell this client he's been kicked by an admin.
			//chatMC.chat_txt.text += "<font color='#CE0000'><b>You were kicked by " + kicker + "!</b></font>";
			
			// Disconnect user from server.
			//disconnect();
		}
		
	}
}