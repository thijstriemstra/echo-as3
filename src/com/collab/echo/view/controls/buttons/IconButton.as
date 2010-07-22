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
package com.collab.echo.view.controls.buttons
{
	import com.collab.echo.view.display.util.StyleDict;
	import com.collab.echo.view.display.util.TextUtils;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;

	/**
	 * Button with an icon and label.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class IconButton extends Sprite
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		private static const HORIZONTAL_GAP	: int = 10;
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _icon					: Bitmap;
		private var _data					: BitmapData;
		private var _titleField				: TextField;
		private var _title					: String;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		public function get icon()	: Bitmap
		{
			return _icon;
		}
		
		public function set title( val:String ):void
		{
			if ( val )
			{
				_title = val;
				invalidate();
			}
		}
		
		/**
		 * Constructor. 
		 * 
		 * @param data
		 */		
		public function IconButton( data:BitmapData )
		{
			super();
			
			_data = data;
			_title = "";
			
			tabChildren = false;
			buttonMode = true;
			doubleClickEnabled = false;
			
			invalidate();
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		protected function draw():void
		{
			// icon
			_icon = new Bitmap( _data );
			addChild( _icon );
			
			// text
			_titleField = TextUtils.createStandardTextField( _title, 15, StyleDict.WHITE,
															 true, false, 3,
															 TextFormatAlign.LEFT );
			_titleField.width = 200;
			addChild( _titleField );
		}
		
		protected function layout():void
		{
			// text
			_titleField.x = _icon.x + _icon.width + HORIZONTAL_GAP;
			_titleField.y = ( _icon.y + _icon.height / 2 ) - _titleField.height / 2;
		}
		
		protected function invalidate():void
		{
			if ( _icon && contains( _icon ))
			{
				removeChild( _icon );
				_icon = null;
			}
			
			if ( _titleField && contains( _titleField ))
			{
				removeChild( _titleField );
				_titleField = null;
			}
			
			draw();
			layout();
		}
		
	}
}