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
package com.collab.echo.core.messages
{
	/**
	 * Chat message displaying the available chat commands.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class HelpChatMessage extends TextChatMessage
	{
		protected var doc_fields	: Array;
		
		/**
		 * Constructor.
		 * 
		 * @param type
		 * @param data
		 * @param doc
		 */		
		public function HelpChatMessage( type:String, data:String, doc:Array )
		{
			this.doc_fields = doc;
			
			super( type, data, null, false, true, false, true );
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * Compile list based on available commands. 
		 * 
		 * @private
		 */		
		override protected function parseCommand():void
		{
			var field:Class;
			
			// XXX: localize
			data = "<b>Command List</b><br>";
			for each ( field in doc_fields )
			{
				data += field["DOC"] + "<br/>";
			}
			
			execute( data.substr( 0, data.length - 5 ));
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
			return "<HelpChatMessage type='" + type + "' data='" + data +
				   "' local='" + local + "' append='" + append + "' />";		
		}
		
	}
}