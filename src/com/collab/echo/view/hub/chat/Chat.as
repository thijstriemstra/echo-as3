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
package com.collab.echo.view.hub.chat
{
	import com.collab.echo.model.vo.UserVO;
	import com.collab.echo.view.display.BaseView;
	import com.collab.echo.view.display.util.DrawingUtils;
	import com.collab.echo.view.display.util.StyleDict;
	import com.collab.echo.view.hub.interfaces.IPresence;
	
	import fl.controls.TextArea;
	
	import flash.display.Sprite;
	import flash.system.Capabilities;
	
	/**
	 * @author Thijs Triemstra
	 */	
	public class Chat extends BaseView implements IPresence
	{
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		internal var _background		: Sprite;
		internal var _textArea			: TextArea;
		internal var _inputField		: ChatInputField;
		
		/**
		 * Constructor.
		 *  
		 * @param width
		 * @param height
		 */		
		public function Chat( width:Number=0, height:Number=0 )
		{
			super( width, height );
			show();
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * @param client
		 */		
		public function addUser( client:UserVO ):void
		{
			trace("Chat.addUser: " + client );
			
			// show welcome message for this client
			/*
			if ( occupant.isSelf() )
			{
				trace("ME!");
				chatMC.chat_txt.text += "<b><FONT COLOR='#000000'>" + getWelcomeLine() + " " + username + "!</FONT></b><br>";
				chatMC.chat_txt.text += "<b><FONT COLOR='#4F4F4F'>Chat is now active...</FONT></b><br>";
				chatMC.chat_txt.text += "<b><FONT COLOR='#4F4F4F'>Type /help for options.</FONT></b><br>";
			}
			*/
		}
		
		/**
		 * @param client
		 */		
		public function removeUser( client:UserVO ):void
		{
			trace("Chat.removeUser: " + client );
			
			/*
			// add Timestamp
			var timestamp:Boolean = client.getTargetMC().chat.menu_accordion.preferences_mc.timestamp_cb.selected;
			
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
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * Instantiate and add child(ren) to display list.
		 */	
		override protected function draw() : void
		{
			// background
			_background = DrawingUtils.drawFill( viewWidth, viewHeight,
												0, StyleDict.GREEN1, 1 ); 
			addChild( _background );
			
			// inputField
			_inputField = new ChatInputField( _background.width );
			addChild( _inputField );
			
			// text
			_textArea = new TextArea();
			_textArea.setSize( viewWidth, viewHeight - _inputField.height ); 
			_textArea.condenseWhite = true; 
			_textArea.editable = false;
			// XXX: dynamic
			_textArea.htmlText = "<b>Welcome!</b>";
			addChild( _textArea );
		}
		
		/**
		 * Position child(ren) on display list.
		 */
		override protected function layout():void
		{
			// background
			_background.x = 0;
			_background.y = 0;
			
			// textArea
			_textArea.x = 0;
			_textArea.y = 0;
			
			// inputField
			_inputField.x = 0;
			_inputField.y = _textArea.y + _textArea.height;
		}
		
		/**
		 * Remove and redraw child(ren).
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( _background );
			removeChildFromDisplayList( _inputField );
			removeChildFromDisplayList( _textArea );
			
			super.invalidate();
		}
		
		/**
		 * Create a welcome message depending on the nationality.
		 * 
		 * @return
		 */
		protected function getWelcomeLine():String
		{
			var welcome:String = "Welcome";
			
			switch ( Capabilities.language )
			{
				case "fr":
					welcome = "Bienvenue";
					break;
				
				case "de":
					welcome = "Willkommen";
					break;
				
				case "nl":
					welcome = "Welkom";
					break;
				
				case "it":
					welcome = "Benvenuto";
					break;
				
				case "pt":
					welcome = "Boa vinda";
					break;
				
				case "es":
					welcome = "Recepción";
					break;
			}
			
			return welcome;
		}
		
	}
}