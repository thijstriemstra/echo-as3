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
	 * URL utilities.
	 * 
	 * @author Tthijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class URLUtils
	{
		/**
		 * Create HTML anchor for URL.
		 *  
		 * @param url
		 * @return 
		 */		
		public static function createHyperlink( url:String ):String
		{
			// XXX: refactor
			if ( url.indexOf( "http://" ) > -1 )
			{
				return "<FONT COLOR='#0000FF'><U><A HREF='" + url + "' TARGET='_BLANK'>"+ url + "</A></U></FONT>";
			}
			else
			{
				return "<FONT COLOR='#0000FF'><U><A HREF='http://" + url + "' TARGET='_BLANK'>"+ url + "</A></U></FONT>";
			}
		}
		
		/**
		 * Hilite the urls in a message.
		 *  
		 * @param msg
		 * @return 
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
			var ltPos:Number = msg.indexOf(">");
			while (ltPos != -1) {
				escaped = msg.substring(0, ltPos) + "&gt;" + msg.substring(ltPos+1,msg.length);
				//trace ("escaped: "+escaped);
				msg = escaped;
				ltPos = msg.indexOf(">");
			}
			
			//+
			//highlight urls
			//-
			var url_begin:Number = msg.indexOf("http:");
			if ( url_begin == -1 )
				url_begin = msg.indexOf("www.");
			
			if ( url_begin == -1 )
				return msg;
			
			var hilited:String = msg.substring(0, url_begin);
			var url_end:Number = msg.indexOf( " ", url_begin );
			
			var urlstr:String = "";
			if ( url_end == -1 )
			{
				urlstr = msg.substring(url_begin);
			}
			else
			{
				urlstr = msg.substring(url_begin, url_end);
			}
			
			var urlref:String = urlstr;
			if ( urlstr.indexOf("www.") == 0 )
				urlref = "http://" + urlstr;
			
			var trailer:String = "";
			if ( url_end != -1 )
				trailer = URLUtils.hiliteURLs( msg.substring(url_end) );
			
			hilited += "<font color=\"#0000FF\"><u><a href=\"" + urlref + "\" target=\"_blank\">" + urlstr + "</a></u></font>" + trailer;
			//hilited += "<font color=\"#0000FF\"><u><a href=\"" + urlstr + "\">" + urlstr + "</a></u></font>" + trailer;
			
			return hilited;
		}
		
	}
}