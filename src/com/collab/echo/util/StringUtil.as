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
	 * String utilities.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class StringUtil
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		internal static const DELIMITER:String					= "%s";
		
		// ====================================
		// PUBLIC STATIC METHODS
		// ====================================
		
		/**
		 * Replace locale string using the '%s' delimiter.
		 * 
		 * <p>For example:</p>
		 * <p>
		 * <code>var test:String = LocaleKeyEnum.replace( YOUVE_FINISHED_LEVEL, 1 );
		 * trace( test ); // prints: You've finished level 1!
		 * </code>
		 * </p>
		 * 
		 * @param key
		 * @param params
		 * @return 
		 */		
		public static function replace( key:String, ...params:Array ):String
		{
			var ret:String = "";
			var sub:Array = params.slice();
			
			for ( var d:int=0; d<key.length; d++ )
			{
				if ( key.substr( d, 2 ) == DELIMITER )
				{
					ret += sub[ 0 ];
					sub.shift();
					d++;
				}
				else
				{
					ret += key.charAt( d );
				}
			}
			
			return ret;
		}
		
	}	
}