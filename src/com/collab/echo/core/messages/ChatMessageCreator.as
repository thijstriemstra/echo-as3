﻿/*Echo project.Copyright (C) 2003-2010 CollabThis program is free software: you can redistribute it and/or modifyit under the terms of the GNU General Public License as published bythe Free Software Foundation, either version 3 of the License, or(at your option) any later version.This program is distributed in the hope that it will be useful,but WITHOUT ANY WARRANTY; without even the implied warranty ofMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See theGNU General Public License for more details.You should have received a copy of the GNU General Public Licensealong with this program.  If not, see <http://www.gnu.org/licenses/>.*/package com.collab.echo.core.messages{
	import com.collab.echo.core.messages.chat.ChatMessage;
	import com.collab.echo.core.messages.chat.ClearChatMessage;
	import com.collab.echo.core.messages.chat.HelpChatMessage;
	import com.collab.echo.core.messages.chat.IPChatMessage;
	import com.collab.echo.core.messages.chat.JoinChatMessage;
	import com.collab.echo.core.messages.chat.KickMessage;
	import com.collab.echo.core.messages.chat.LeaveChatMessage;
	import com.collab.echo.core.messages.chat.MeChatMessage;
	import com.collab.echo.core.messages.chat.NicknameChatMessage;
	import com.collab.echo.core.messages.chat.TextChatMessage;
	import com.collab.echo.core.messages.chat.TimeOnlineMessage;
		/**	 * Chat message creator.	 * 	 * @see ChatMessageTypes	 * 	 * @author Thijs Triemstra	 * @langversion 3.0 	 * @playerversion Flash 9	 */		public class ChatMessageCreator extends MessageCreator	{		/**		 * 		 */				protected var fields	: Array = [ TextChatMessage, NicknameChatMessage,											MeChatMessage, ClearChatMessage,											TimeOnlineMessage, IPChatMessage,											KickMessage ];				// ====================================		// PROTECTED METHODS		// ====================================				/**		 * Create a message.		 * 		 * @see ChatMessageTypes		 * 		 * @param presence		 * @param type		 * @param data		 * @param includeSelf		 * @return 		 */				override protected function createMessage( presence:*, type:String, data:String,												   includeSelf:Boolean=false ):ChatMessage		{			// XXX: non-command stuff below could use a refactor						// join			if ( data == ChatMessageTypes.JOIN )			{				return new JoinChatMessage( type, data, presence );			}			// leave			else if ( data == ChatMessageTypes.LEAVE )			{				return new LeaveChatMessage( type, data, presence );			}						var cmd:String = parseCommand( data );						// timeOnline			if ( findCommand( ChatMessageTypes.TIME_ONLINE, cmd ))			{				return new TimeOnlineMessage( type, data, presence );			}			// private message			else if ( findCommand( ChatMessageTypes.PRIVATE_MESSAGE, cmd ))			{				return new TextChatMessage( type, data, presence, includeSelf );			}			// nick			else if ( findCommand( ChatMessageTypes.NICK, cmd ))			{				return new NicknameChatMessage( type, data );			}			// me			else if ( findCommand( ChatMessageTypes.ME, cmd ))			{				return new MeChatMessage( type, data );			}			// kick			else if ( findCommand( ChatMessageTypes.KICK, cmd ))			{				return new KickMessage( type, data, presence );			}			// clear			else if ( findCommand( ChatMessageTypes.CLEAR, cmd ))			{				return new ClearChatMessage( type, data );			}			// ip			else if ( findCommand( ChatMessageTypes.IP, cmd ))			{				return new IPChatMessage( type, data, presence );			}			// help			else if ( findCommand( ChatMessageTypes.HELP1, cmd ) ||					  findCommand( ChatMessageTypes.HELP2, cmd ))			{				return new HelpChatMessage( type, data, fields );			}			// text			else			{				return new TextChatMessage( type, data, presence, includeSelf );			}		}				/**		 * @param data		 * @return 		 */				protected function parseCommand( data:String ):String		{			var command:String;						if ( data && data.length > 0 )			{				if ( data.charAt( 0 ) == "/" && data.length > 1 )				{					command = data.substr( 1 ).toLowerCase();				}								if ( command )				{					//trace("parseCommand: " + data + "; " + command );				}			}						return command;		}				/**		 * @param type		 * @param cmd		 * @return 		 */				protected function findCommand( type:String, cmd:String ):Boolean		{			var res:Boolean = false;						if ( cmd && cmd.length > 0 && cmd.length >= type.length )			{				res = cmd.substr( 0, type.length ) == type;				}						return res;		}			}}