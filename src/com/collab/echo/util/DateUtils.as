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
	 * Utilities for manipulating dates.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class DateUtils
	{
		// ====================================
		// STATIC METHODS
		// ====================================
		
		/**
		 * Create a timestamp: (12:00:00)
		 */
		public static function createClientStamp():String
		{
			var my_date:Date = new Date();
			var theTime:Array = [my_date.getHours(), my_date.getMinutes(), my_date.getSeconds()];
			var v:int = 0;
			
			for ( v; v<theTime.length; v++)
			{
				if (theTime[v] < 10) {
					theTime[v] = "0" + theTime[v];
				}
			}
			
			return "(" + theTime[0] + ":" + theTime[1] + ":" + theTime[2] + ")";
		}
		
	}
}