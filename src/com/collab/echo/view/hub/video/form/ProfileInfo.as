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
package com.collab.echo.view.hub.video.form
{
	import com.collab.echo.model.vo.ProfileInfoVO;
	import com.collab.echo.view.display.BaseView;
	import com.collab.echo.view.hub.video.form.item.ProfileInfoFormItem;
	
	import flash.display.DisplayObject;
	
	/**
	 * @author Thijs Triemstra
	 */	
	public class ProfileInfo extends BaseView
	{
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		protected var locationField		: ProfileInfoFormItem;
		protected var websiteField		: ProfileInfoFormItem;
		protected var emailField		: ProfileInfoFormItem;
		protected var ageField			: ProfileInfoFormItem;
		protected var fields			: Vector.<ProfileInfoFormItem>;
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _item				: ProfileInfoFormItem;
		private var _data				: ProfileInfoVO;

		// ====================================
		// GETTER/SETTER
		// ====================================
		
		/**
		 * @return 
		 */		
		public function get data()		: ProfileInfoVO
		{
			return _data;
		}
		public function set data( val:ProfileInfoVO ):void
		{
			_data = val;
			invalidate();
		}
		
		/**
		 * Constructor.
		 *  
		 * @param width
		 * @param height
		 * @param data
		 */		
		public function ProfileInfo( width:Number=0, height:Number=0,
									 data:ProfileInfoVO=null )
		{
			_data = data;
			
			super( width, height );
			show();
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * @param child
		 * @return 
		 */		
		override public function addChild( child:DisplayObject ):DisplayObject
		{
			fields.push( child );
			
			return super.addChild( child );
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================

		/**
		 * @private 
		 */		
		override protected function draw():void
		{
			var formHeight:int = 70;
			fields = new Vector.<ProfileInfoFormItem>();
			
			// XXX: localize
			if ( _data )
			{
				// location
				locationField = createFormItem( viewWidth, formHeight, "Location", _data.location );
				addChild( locationField );
				
				// website
				websiteField = createFormItem( viewWidth, formHeight, "Website", _data.website );
				addChild( websiteField );
				
				// email
				emailField = createFormItem( viewWidth, formHeight, "Email", _data.email );
				addChild( emailField );
				
				// age
				ageField = createFormItem( viewWidth, formHeight, "Age", _data.age );
				addChild( ageField );
			}
		}
		
		/**
		 * @private 
		 */		
		override protected function layout():void
		{
			var prevItem:ProfileInfoFormItem;
			var index:int;
			
			// position profile items
			if ( fields )
			{
				for each ( _item in fields )
				{
					if ( index > 0 )
					{
						prevItem = fields[ index - 1 ];
						
						// location
						_item.x = prevItem.x;
						_item.y = prevItem.y + prevItem.height;
					}
					
					index++;
				}
			}
		}
		
		/**
		 * @private 
		 */		
		override protected function invalidate():void
		{
			if ( fields )
			{
				for each ( _item in fields )
				{
					removeChildFromDisplayList( _item );
				}
			}
			
			super.invalidate();
		}
		
		// ====================================
		// INTERNAL METHODS
		// ====================================
		
		/**
		 * @param width
		 * @param height
		 * @param label
		 * @param value
		 * @return 
		 */		
		internal function createFormItem( width:int=0, height:int=0,
										  label:String="Label", value:String="Value" ):ProfileInfoFormItem
		{
			var field:ProfileInfoFormItem = new ProfileInfoFormItem( width, height );
			field.label = label;
			field.value = value;
			
			return field;
		}
		
	}
}