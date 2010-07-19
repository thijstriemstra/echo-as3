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
package com.collab.echo.util
{
	/**
	 * Utilities for manipulating file paths.
	 *  
	 * @author Thijs Triemstra
	 */	
	public class PathUtils
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		private static const FORWARD_SLASH	: String = "/";
		
		// ====================================
		// PUBLIC STATIC METHODS
		// ====================================
		
		/**
		 * Join a list of array elements into a forward-slash seperated path.
		 * 
		 * @param parts
		 * @return Path
		 */		
		public static function join( ...parts:Array ):String
		{
			var validParts:Array = [];
			
			for each ( var part:String in parts )
			{
				if ( part.length > 0 && part != null )
				{
					validParts.push( part );
				}
			}
			
			return validParts.join( FORWARD_SLASH );
		}
		
		/**
		 * Get filename from path.
		 *  
		 * @param path
		 * @return Filename
		 */		
		public static function basename( path:String ):String
		{
			try
			{
				var parts:Array = path.split( FORWARD_SLASH );
			}
			catch ( e:TypeError )
			{
				return "?";
			}
			
			return parts[ parts.length - 1 ];
		}
		
		/**
		 * Hilite the urls in a message
		 */
		public static function hiliteURLs( msg:String ):String
		{
			//+
			//escape all <
			//-
			var escaped:String = "";
			var ltPos:Number = msg.indexOf("<");
			while (ltPos != -1) {
				escaped = msg.substring(0, ltPos) + "&lt;" + msg.substring(ltPos+1,msg.length);
				//trace ("escaped: "+escaped);
				msg = escaped;
				ltPos = msg.indexOf("<");
			}
			
			//+
			//escape all >
			//-
			var escaped:String = "";
			var ltPos = msg.indexOf(">");
			while (ltPos != -1) {
				escaped = msg.substring(0, ltPos) + "&gt;" + msg.substring(ltPos+1,msg.length);
				//trace ("escaped: "+escaped);
				msg = escaped;
				ltPos = msg.indexOf(">");
			}
			
			//+
			//highlight urls
			//-
			var url_begin = msg.indexOf("http:");
			if ( url_begin == -1 )
				url_begin = msg.indexOf("www.");
			
			if ( url_begin == -1 )
				return msg;
			
			var hilited = msg.substring(0, url_begin);
			var url_end = msg.indexOf( " ", url_begin );
			
			var urlstr = "";
			if ( url_end == -1 )
				urlstr = msg.substring(url_begin);
			else
				urlstr = msg.substring(url_begin, url_end);
			
			var urlref = urlstr;
			if ( urlstr.indexOf("www.") == 0 )
				urlref = "http://" + urlstr;
			
			var trailer = "";
			if ( url_end != -1 )
				trailer = this.hiliteURLs( msg.substring(url_end) );
			
			hilited += "<font color=\"#0000FF\"><u><a href=\"" + urlref + "\" target=\"_blank\">" + urlstr + "</a></u></font>" + trailer;
			//hilited += "<font color=\"#0000FF\"><u><a href=\"" + urlstr + "\">" + urlstr + "</a></u></font>" + trailer;
			
			return hilited;
		}

	}
}