/*
Echo project.

Copyright (C) 2011 Collab

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
package com.collab.echo.errors
{
	import com.collab.cabin.util.StringUtil;

	/**
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9
	 */
	public class UnknownConnectionError extends Error
	{
		/**
		 * Constructor.
		 *  
		 * @param connection	See Connection class.
		 * @param id
		 * 
		 * @see com.collab.echo.net.Connection Connection
		 */		
		public function UnknownConnectionError(connection:Class, id:*=0)
		{
			var message:String = StringUtil.replace( "Unknown connection type: %s",
													 connection );
			super( message, id );
		}
		
	}
}