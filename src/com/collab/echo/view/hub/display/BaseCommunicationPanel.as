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
package com.collab.echo.view.hub.display
{
	import com.collab.echo.model.vo.UserVO;
	import com.collab.echo.view.containers.panels.Panel;
	import com.collab.echo.view.containers.scrollpane.FlashScrollPane;
	import com.collab.echo.view.controls.buttons.BaseExpandButton;
	import com.collab.echo.view.events.CommunicationPanelEvent;
	import com.collab.echo.view.hub.chat.Chat;
	import com.collab.echo.view.hub.display.skins.BaseCommunicationPanelSkin;
	import com.collab.echo.view.hub.translator.Translator;
	import com.collab.echo.view.hub.video.VideoScrollPane;
	import com.collab.echo.view.hub.whiteboard.display.Whiteboard;
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	
	import fl.events.ScrollEvent;
	
	import org.osflash.thunderbolt.Logger;

	/**
	 * Communication hub view..
	 * 
	 * <p>Internal <code>FlashScrollPane</code> contains:</p>
	 * <p><ul>
	 * <li><code>Whiteboard</code></li>
	 * <li><code>Chat</code></li>
	 * <li><code>Translator</code></li>
	 * <li><code>VideoScrollPane</code></li>
	 * <li><code>BaseExpandButton</code></li>
	 * </ul></p>
	 * 
	 * @see com.collab.echo.view.containers.scrollpane.FlashScrollPane FlashScrollPane
	 * @see com.collab.echo.view.hub.chat.Chat Chat
	 * @see com.collab.echo.view.hub.translator.Translator Translator
	 * @see com.collab.echo.view.hub.whiteboard.Whiteboard Whiteboard
	 * @see com.collab.echo.view.hub.VideoScrollPane VideoScrollPane
	 * @see com.collab.echo.view.controls.buttons.BaseExpandButton BaseExpandButton
	 * 
	 * @author Thijs Triemstra
	 */	
	public class BaseCommunicationPanel extends Panel
	{
		// ====================================
		// STATIC VARS
		// ====================================
		
		internal static const PANEL_WIDTH_MIN	: int = 140;
		
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		internal var _pane						: FlashScrollPane;
		internal var _whiteboard				: Whiteboard;
		internal var _chat						: Chat;
		internal var _translator				: Translator;
		internal var _videoPane					: VideoScrollPane;
		internal var _expandButton				: BaseExpandButton;
		internal var _skin						: Object;
		internal var _paddingLeft				: int;
		internal var _data						: Vector.<UserVO>;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		/**
		 * Panel skin.
		 *  
		 * @param val
		 */		
		public function set skin( val:Object ):void
		{
			_skin = val;
			invalidate();
		}

		/**
		 * Padding on the left side.
		 *  
		 * @param val
		 */		
		public function set paddingLeft( val:int ):void
		{
			_paddingLeft = val;
			invalidate();
		}
		
		/**
		 * Constructor.
		 *  
		 * @param width
		 * @param height
		 * @param skin
		 * @param paddingLeft
		 */		
		public function BaseCommunicationPanel( width:int, height:int, skin:Object=null,
												paddingLeft:int=0 )
		{
			super( true, width, height );
			
			if ( skin == null )
			{
				_skin = BaseCommunicationPanelSkin.getSkin();
			}
			else
			{
				_skin = skin;
			}
			
			_paddingLeft = paddingLeft;
			
			show();
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * Add a new occupant to the <code>Room</code>.
		 *  
		 * @param client
		 */		
		public function addOccupant( client:* ):void
		{
			trace( 'BaseCommunicationPanel.addOccupant: ' + client );
			
			// XXX: _videoPane (and others) need a addOccupant method
			
			/*
			// Retrieve the username for the client that just joined.
			var remoteuser:RemoteClient = client.getRemoteClientManager().getClient(e.getClientID());
			// Retrieve the client-attributes.
			var userID:String = e.getClientID();
			//create the local Shared Object
			var user_SO:SharedObject = SharedObject.getLocal("collab");
			var username:String = remoteuser.getAttribute(null, "username");
			var location:String = remoteuser.getAttribute(null, "location");
			var url:String = remoteuser.getAttribute(null, "website");
			var rank:String = remoteuser.getAttribute(null, "rank");
			var age:String = remoteuser.getAttribute(null, "age");
			var email:String = remoteuser.getAttribute(null, "email");
			var avatar:String = remoteuser.getAttribute(null, "avatar");
			var trivia:String = remoteuser.getAttribute(null, "trivia");
			
			var chatMC:MovieClip = client.getTargetMC().chat.menu_accordion.panel_mc.chatPanel_mc.content.chat_accordion.chat_mc;
			var welcomeLine:String = getWelcomeLine();
			
			// Use the client id as a user name if the user hasn't set a name.
			if (username == undefined)
			{
			username = "user" + userID;
			}
			
			// Use "..." as a location if the user hasn't set a location.
			if (location == undefined)
			{
			location = "...";
			}
			
			// Use "..." as a location if the user hasn't set a location.
			if (age == undefined)
			{
			age = "...";
			}
			
			// Use "..." as a email address if the user hasn't set one.
			if (email == undefined)
			{
			email = "...";
			}
			
			// Use "..." if the user hasn't given a URL.
			if (url == undefined) {
			var hyperlinked:String = "...";
			} 
			else
			{
			var hyperlinked:String = createHyperlink(url);
			}
			
			// add videoImage to videoPanel
			var newVideo:MovieClip = client.getTargetMC().chat.video_mcs.content.attachMovie("videoImage", "clientVideo"+userID,  client.getNewTargetDepth());
			
			// init
			newVideo.opener = userID;
			newVideo.gotoAndStop("open");
			
			var totalWindows:Number = client.getTargetMC().chat.video_mcs.content.panels.length;
			
			newVideo._x = totalWindows*newVideo._width;
			newVideo.screen.username = username;
			newVideo.screen.location = location;
			newVideo.screen.website = hyperlinked;
			newVideo.screen.email = email;
			newVideo.screen.age = age;
			newVideo.screen.origPos = totalWindows;
			newVideo.screen.curPos = totalWindows+1;
			
			// show rank icon
			newVideo.screen.header_mc.gotoAndStop(rank);
			
			// show trivia icon
			if (trivia == "true")
			{
			newVideo.screen.header_mc.trivia_icon._visible = true;
			}
			else
			{
			newVideo.screen.header_mc.trivia_icon._visible = false;
			}
			
			// admin or mod
			if (_root.userMode == "guest")
			{
			newVideo.screen.header_mc.kick_icon._visible = false;
			}
			else
			{
			newVideo.screen.header_mc.kick_icon._visible = true;
			}
			
			// print welcome message for this client
			if (userID == client.getClientID()) 
			{
			chatMC.chat_txt.text += "<b><FONT COLOR='#000000'>" + welcomeLine + " " + username + "!</FONT></b><br>";
			chatMC.chat_txt.text += "<b><FONT COLOR='#4F4F4F'>Chat is now active...</FONT></b><br>";
			chatMC.chat_txt.text += "<b><FONT COLOR='#4F4F4F'>Type /help for options.</FONT></b><br>";
			
			// Get country name if this user hasn't set a location.
			if (location == "..." || location == undefined || location == "undefined")
			{
			client.getTargetMC().ipaddress = remoteuser.getAttribute(null, "_IP");
			client.getTargetMC().getLocationByIP();
			}
			
			// Hide the pm button 
			newVideo.screen.header_mc.pm_mc._visible = false;
			newVideo.screen.header_mc.kick_icon._visible = false;
			}
			
			// add whiteboard for client
			addWhiteboard(userID, username); 
			
			// add to panels array
			client.getTargetMC().chat.video_mcs.content.panels.push(newVideo);
			
			// redraw component
			client.getTargetMC().chat.video_mcs.redraw(true);
			*/
		}
		
		/**
		 * Remove an existing occupant from the room.
		 *  
		 * @param client
		 */		
		public function removeOccupant( client:* ):void
		{
			trace( 'BaseCommunicationPanel.removeOccupant: ' + client );
			
			// XXX: _videoPane (and others) need a removeOccupant method
			
			/*
			var chatMC:MovieClip = client.getTargetMC().chat.menu_accordion.panel_mc.chatPanel_mc.content.chat_accordion.chat_mc;
			// Retrieve the username for the client that just joined.
			var clientID:String = e.getClientID();
			var remoteuser:RemoteClient = client.getRemoteClientManager().getClient(clientID);
			var username:String = remoteuser.getAttribute(null, "username");
			var rank:String = remoteuser.getAttribute(null, "rank");
			var panelname:String = "clientVideo" + clientID;
			var allVideos:Array = client.getTargetMC().chat.video_mcs.content.panels;
			var timestamp:Boolean = client.getTargetMC().chat.menu_accordion.preferences_mc.timestamp_cb.selected;
			
			// Use the client id as a user name if the user hasn't set a name.
			if (username == undefined)
			{
			username = "user" + clientID;
			}
			
			// remove videoPanel
			for (var g:Number=0; g<allVideos.length; g++)
			{
			if (allVideos[g]._name == panelname)
			{
			removeMovieClip(allVideos[g]);
			allVideos.splice(g,1);
			break;
			}
			}
			
			// remove user cursor
			removeMovieClip(client.getTargetMC().chat.menu_accordion.panel_mc.chatPanel_mc.content.whiteboard_accordion.whiteboard_mc["cursor"+clientID]);
			
			// reposition videoPanels
			for (var f:Number=0; f<allVideos.length; f++)
			{
			// re-order windows
			allVideos[f]._x = f*170;
			
			allVideos[f].screen.origPos = f+1;
			allVideos[f].screen.curPos = f+1;
			allVideos[f].screen.pos_stepper.value = f+1;
			allVideos[f].screen.pos_stepper.maximum = allVideos.length;
			
			//trace(allVideos[f].windowID + ", " + f);
			//trace("===================== ");
			}
			
			// redraw component
			client.getTargetMC().chat.video_mcs.redraw(true);
			
			// add Timestamp
			if (timestamp)
			{
			var addStamp:String = _root.sc.createClientStamp();
			}
			else
			{
			var addStamp:String = "";
			}
			
			// add to chat_txt : client left
			if (rank == "admin")
			{
			chatMC.chat_txt.text += addStamp + " <font color = '#1D5EAB'><b>"+ username +" has left.</b></font>";
			}
			else if (rank == "moderator")
			{
			chatMC.chat_txt.text += addStamp + " <font color = '#1892AF'><b>"+ username +" has left.</b></font>";
			}
			else
			{
			chatMC.chat_txt.text += addStamp + " <b>"+ username +" has left.</b>";
			}
			
			chatMC.chat_txt.vPosition = chatMC.chat_txt.maxVPosition; 
			*/
		}
		
		/**
		 * Total clients in room updated.
		 * 
		 * @param totalClients
		 */		
		public function numClients( totalClients:int ):void
		{
			trace("BaseCommunicationPanel.numClients: " + totalClients );
		}
		
		/**
		 * Joined the room.
		 * 
		 * @param data
		 */		
		public function joinedRoom( data:* ):void
		{
			trace("BaseCommunicationPanel.joinedRoom: " + data );
			
			// chatRoom
			//var roomsControl:MovieClip = client.getTargetMC().chat.menu_accordion.preferences_mc;
			
			// client vars
			var clientVars:Array = ["username", "location", "website", "email", "age"];
			var clientID:String = data.getClientID();
			
			// set clientVars
			for (var p:int=0; p<clientVars.length; p++)
			{
				var clientVar:String = clientVars[p];
				
				/*
				// SO already contains the var
				if (user_SO.data[clientVar] != null)
				{
				client.setClientAttribute(clientVar, 
				user_SO.data[clientVar], 
				null, 
				true, 
				false, 
				false);
				roomsControl[clientVar+"_txt"].text = user_SO.data[clientVar];
				}
				else
				{
				// SO does not contain a name
				if (clientVar == "username")
				{
				roomsControl[clientVar+"_txt"].text = "user"+clientID;
				
				}
				else
				{
				roomsControl[clientVar+"_txt"].text = "...";
				}
				}
				*/
			}
			
			/* Set user rank
			client.setClientAttribute("rank", 
			_root.userMode, 
			null, true,  false, false);
			
			// Increment personal visitor counter
			if (user_SO.data.counter != null)
			{
			user_SO.data.counter = user_SO.data.counter+1;
			}
			else
			{
			user_SO.data.counter = 0;
			}
			
			// set countryFlag on users
			if (user_SO.data.countryCode == null) {	
			//Set countryFlag
			client.setClientAttribute("countryFlag", 
			user_SO.data.countryCode, 
			null, 
			true, 
			false, 
			false);
			} else {
			
			}
			//trace("visitor counter: " + user_SO.data.counter);
			
			// set scroll content
			client.getTargetMC().chat.video_mcs.contentPath = "eenVideo";
			client.getTargetMC().chat.video_mcs.content.screen.details_comp.contentPath = "videoDetails";
			
			// create array for videoPanels
			var thePanel:MovieClip = client.getTargetMC().chat.video_mcs.content;
			thePanel.panels = new Array();
			
			var coloredName:String = roomsControl.username_txt.text;
			
			// Notify room of arrival.
			if (_root.userMode == "admin")
			{
			coloredName = "<font color = '#1D5EAB'>"+ roomsControl.username_txt.text +"</font>";
			
			}
			else if (_root.userMode == "moderator")
			{
			coloredName = "<font color = '#1892AF'>"+ roomsControl.username_txt.text +"</font>";
			}
			
			// Send the message to the server.
			var safeMsg:String = '<![CDATA[' + ("<b>"+ coloredName +" has joined. </b>") + ']]>';
			client.invokeOnRoom("joinMessage", AppSettings.fnsid, false, safeMsg);
			//client.invokeOnNamespace("joinMessage", "collab", false, safeMsg);
			
			// Connect to flashcom
			client.getTargetMC().connectFCS(roomsControl.username_txt.text);
			*/
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * Instantiate and add child(ren) to display list.
		 */	
		override protected function draw() : void
		{
			// pane
			_pane = _skin.pane;
			_pane.setSize( PANEL_WIDTH_MIN, viewHeight );
			_pane.addEventListener( ScrollEvent.SCROLL, scrollHandler, false, 0, true );
			addChild( _pane );
			
			// video pane
			_videoPane = _skin.videoPane;
			_videoPane.panelSkin = _skin.userPanel;
			_videoPane.data = _data;
			_videoPane.setSize( viewWidth, 200 );
			_pane.add( _videoPane );
			
			// whiteboard
			_whiteboard = _skin.whiteboard;
			_whiteboard.hide();
			_pane.add( _whiteboard );
			
			// chat
			_chat = _skin.chat;
			_chat.setSize( 350, 520 );
			_pane.add( _chat );
			
			// translator
			_translator = _skin.translator;
			_translator.setSize( 250, 520 );
			_pane.add( _translator );
			
			// expand button
			_expandButton = _skin.expandButton;
			_expandButton.width = _pane.width;
			_expandButton.addEventListener( CommunicationPanelEvent.EXPAND, onExpandPanel,
										    false, 0, true );
			_expandButton.addEventListener( CommunicationPanelEvent.COLLAPSE, onExpandPanel,
										    false, 0, true );
			addChild( _expandButton );
		}
		
		/**
		 * Position child(ren) on display list.
		 */
		override protected function layout():void
		{
			// expand button
			_expandButton.y = _pane.height;
			
			// video pane
			_videoPane.x = 0;
			_videoPane.y = 0;
			
			// whiteboard
			_whiteboard.x = 0;
			_whiteboard.y = _videoPane.y + _videoPane.height;
			
			// chat
			_chat.x = 0;
			_chat.y = _videoPane.y + _videoPane.height;
			
			// translator
			_translator.x = _chat.width;
			_translator.y = _videoPane.y + _videoPane.height;
		}
		
		/**
		 * Remove and redraw child(ren).
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( _whiteboard );
			removeChildFromDisplayList( _chat );
			removeChildFromDisplayList( _translator );
			removeChildFromDisplayList( _videoPane );
			removeChildFromDisplayList( _pane );
			removeChildFromDisplayList( _expandButton );
			
			super.invalidate();
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * Invoked when the panel is expanded and collapsed.
		 * 
		 * @param event
		 */		
		protected function onExpandPanel( event:CommunicationPanelEvent ):void
		{
			Logger.debug( event.toString() );
			
			switch ( event.type )
			{
				case CommunicationPanelEvent.EXPAND:
					TweenLite.to( _pane, 1, { x: -(viewWidth - (PANEL_WIDTH_MIN + _paddingLeft)), ease: Quad.easeOut,
											 setSize:{ width: viewWidth - PANEL_WIDTH_MIN }}); 
					break;
				
				case CommunicationPanelEvent.COLLAPSE:
					TweenLite.to( _pane, 1, { x: 0, setSize:{ width: PANEL_WIDTH_MIN }, ease: Quad.easeIn }); 
					break;
			}
		}
		
		/**
		 * @param event
		 */		
		protected function scrollHandler( event:ScrollEvent ):void
		{
		}
		
	}
}