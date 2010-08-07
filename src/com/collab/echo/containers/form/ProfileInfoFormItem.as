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
package com.collab.echo.containers.form
{
	import com.collab.echo.display.BaseView;
	import com.collab.echo.display.util.StyleDict;
	import com.collab.echo.display.util.TextUtils;
	
	import flash.text.TextField;

	/**
	 * @author Thijs Triemstra
	 */	
	public class ProfileInfoFormItem extends BaseView
	{
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		protected var labelField	: TextField;
		protected var valueField	: TextField;
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _label			: String;
		private var _value			: String;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		/**
		 * The form item's label.
		 *  
		 * @return 
		 */		
		public function get label():String
		{
			return _label;
		}
		public function set label( val:String ):void
		{
			_label = val;
			invalidate();
		}	

		/**
		 * The form item's value.
		 *  
		 * @return 
		 */		
		public function get value():String
		{
			return _value;
		}
		public function set value( val:String ):void
		{
			_value = val;
			invalidate();
		}	
		
		/**
		 * Constructor.
		 *  
		 * @param width
		 * @param height
		 */		
		public function ProfileInfoFormItem( width:Number=0, height:Number=0 )
		{
			super( width, height );
			show();
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		override protected function draw():void
		{
			// label
			labelField = TextUtils.createTextField( null, _label, 12, StyleDict.BLACK,
													false, false );
			labelField.border = false;
			labelField.borderColor = StyleDict.RED1;
			addChild( labelField );
			
			// value
			valueField = TextUtils.createTextField( null, _value, 12, StyleDict.BLACK,
												    false, false );
			valueField.selectable = true;
			valueField.mouseEnabled = true;
			valueField.border = false;
			valueField.borderColor = StyleDict.RED1;
			addChild( valueField );
		}
		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( labelField );
			removeChildFromDisplayList( valueField );
			
			super.invalidate();
		}
		
		override protected function layout():void
		{
			// label
			labelField.x = 0;
			labelField.y = 0;
			
			// value
			valueField.x = 0;
			valueField.y = labelField.y + labelField.height - 5;
		}

	}
}