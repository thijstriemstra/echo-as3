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
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * Text utilities.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class TextUtils
	{
		/**
		 * Create a styled text field.
		 * 
		 * @param font
		 * @param text
		 * @param size
		 * @param color
		 * @param ml
		 * @param bold
		 * @param leading
		 * @param align
		 * 
		 * @return A new <code>TextField</code> instance
		 */		
		private static function createStyledTextField( font:Font, text:String="", size:Number=16,
											   		   color:uint=0x000000, ml:Boolean=false,
													   bold:Boolean=false, leading:Number=0,
													   align:String="center" ) : TextField
		{
			var debug:Boolean = false;
			
			var format:TextFormat = new TextFormat();
			format.size = size;
			format.align = align;
			format.color = color;
			format.leading = leading;
			format.bold = false;
			format.kerning = false;
			if ( font )
			{
				format.font = font.fontName;
			}
			
			var tf:TextField = new TextField();
			tf.tabEnabled = false;
			tf.doubleClickEnabled = false;
			tf.mouseEnabled = false;
			tf.mouseWheelEnabled = false;
			tf.selectable = false;
			tf.antiAliasType = AntiAliasType.ADVANCED;
			tf.defaultTextFormat = format;
			tf.background = debug;
			tf.backgroundColor = StyleDict.GREY1;
			tf.textColor = format.color as uint;
			tf.wordWrap = ml;
			tf.border = debug;
			tf.borderColor = StyleDict.RED1;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.multiline = ml;
			if ( font )
			{
				tf.embedFonts = true;
			}
			
			if ( text )
			{
				tf.htmlText = text;
			}
			
			return tf;
		}
		
		/**
		 * Create textfield with standard font.
		 * 
		 * @param font
		 * @param text
		 * @param size
		 * @param color
		 * @param ml
		 * @param bold
		 * @param leading
		 * @param align
		 * @return 
		 */		
		public static function createTextField( font:Font=null, text:String="", size:Number=15,
												color:uint=0x000000, ml:Boolean=false,
												bold:Boolean=false, leading:Number=0,
												align:String="left" ) : TextField
		{
			return createStyledTextField( font, text, size, color, ml,
									      bold, leading, align );
		}
		
		/**
		 * Create textformat with standard font.
		 * 
		 * @param font
		 * @param size
		 * @param color
		 * @param bold
		 * @param leading
		 * @param align
		 * @return 
		 */		
		public static function createTextFormat( font:Font=null, size:Number=12,
										  		 color:uint=0x000000,
												 bold:Boolean=false, leading:Number=0,
												 align:String="left" ) : TextFormat
		{
			var format:TextFormat = new TextFormat();
			format.size = size;
			format.align = align;
			format.color = color;
			format.leading = leading;
			format.bold = false;
			format.kerning = false;
			if ( font)
			{
				format.font = font.fontName;
			}
			
			return format;
		}
		
		/**
		 * Get colorized HTML text.
		 * 
		 * @param color
		 * @param text
		 * @return 
		 */		
		public static function getHTMLFontString( color:uint, text:String ):String
		{
			return "<font color='#" + color.toString( 16 ) + "'>" + text + "</font>";
		}
		
	}
}