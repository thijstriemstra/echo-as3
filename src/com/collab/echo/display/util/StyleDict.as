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
package com.collab.echo.display.util
{
	/**
	 * Common style and dimension constants.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class StyleDict
	{
		// ====================================
		// COLORS
		// ====================================
		
		public static const BLACK								: uint = 0x000000;
		public static const WHITE								: uint = 0xFFFFFF;

		public static const GREY1								: uint = 0xC5C5C9;
		public static const GREY2								: uint = 0x575D5C;
		public static const GREY3								: uint = 0x666666;
		public static const GREY4								: uint = 0x333333;
		
		public static const RED1								: uint = 0xFF0000;
		public static const BLUE1								: uint = 0x1C20FF;
		public static const GREEN1								: uint = 0x2FFF1C;
		public static const YELLOW1								: uint = 0xFFF71C;
		public static const PURPLE1								: uint = 0x6511ED;
		
		// ====================================
		// MISC
		// ====================================
		
		public static const COLORS								: Array = [ BLACK, WHITE, RED1 ];
		public static const ALPHAS								: Array = [ 1, 1, 1 ];
		public static const RATIOS								: Array = [ 20, 130, 255 ];
		public static const BACKGROUND_ALPHA					: Number = 1;
		
	}
}