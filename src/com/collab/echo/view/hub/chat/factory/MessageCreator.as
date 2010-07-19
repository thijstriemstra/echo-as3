﻿/*Echo project.Copyright (C) 2003-2010 CollabThis program is free software: you can redistribute it and/or modifyit under the terms of the GNU General Public License as published bythe Free Software Foundation, either version 3 of the License, or(at your option) any later version.This program is distributed in the hope that it will be useful,but WITHOUT ANY WARRANTY; without even the implied warranty ofMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See theGNU General Public License for more details.You should have received a copy of the GNU General Public Licensealong with this program.  If not, see <http://www.gnu.org/licenses/>.*/package com.collab.echo.view.hub.chat.factory{	import com.collab.echo.view.hub.chat.messages.BaseChatMessage;		import flash.errors.IllegalOperationError;
		/**	 * Note: ABSTRACT Class (should be subclassed and not instantiated).	 *  	 * @author Thijs Triemstra	 */		public class MessageCreator	{ 		// ====================================		// PUBLIC/PROTECTED METHODS		// ====================================				/**		 * Create a new chat message.		 * 		 * @param data		 */				public function create( type:String, data:String, includeSelf:Boolean=false ) : BaseChatMessage		{			var message:BaseChatMessage;						if ( data )			{				message = createMessage( type, data, includeSelf );			}						return message;		}				/**		 * ABSTRACT Method (must be overridden in a subclass).		 *  		 * @param data		 * @return 		 */				protected function createMessage( type:String, data:String, includeSelf:Boolean=false ):BaseChatMessage		{ 			throw new IllegalOperationError( "Abstract method: must be overridden in a subclass" );			return null;		}			}}