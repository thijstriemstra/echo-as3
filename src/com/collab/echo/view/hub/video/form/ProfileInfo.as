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
	import com.collab.echo.view.display.util.DrawingUtils;
	import com.collab.echo.view.display.util.StyleDict;
	import com.collab.echo.view.hub.video.form.item.ProfileInfoFormItem;
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * @author Thijs Triemstra
	 */	
	public class ProfileInfo extends BaseView
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		public static const	OPEN_SPEED	: Number = .4;
		
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		protected var background		: Sprite;
		protected var backgroundMask	: Sprite;
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
		private var _opened				: Boolean;
		
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
			_opened = false;
			
			super( width, height );
			show();
		}
		
		/**
		 * @private 
		 */		
		override public function show():void
		{
			super.show();
			
			if ( backgroundMask )
			{
				var h:int = viewHeight;
				
				if ( _opened )
				{
					h = 0;
					_opened = false;
				}
				else
				{
					_opened = true;
				}
				
				TweenLite.to( backgroundMask, OPEN_SPEED, { height: h });
			}
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================

		/**
		 * @private 
		 */		
		override protected function draw():void
		{
			// background
			background = DrawingUtils.drawFill( viewWidth, viewHeight, 0,
												StyleDict.WHITE, .6 );
			addChild( background );
			
			// form items
			var formHeight:int = 70;
			fields = new Vector.<ProfileInfoFormItem>();
			
			// XXX: localize
			if ( _data )
			{
				// location
				locationField = createFormItem( viewWidth, formHeight, "Location", _data.location );
				background.addChild( locationField );
				fields.push( locationField );
				
				// website
				websiteField = createFormItem( viewWidth, formHeight, "Website", _data.website );
				background.addChild( websiteField );
				fields.push( websiteField );
				
				// email
				emailField = createFormItem( viewWidth, formHeight, "Email", _data.email );
				background.addChild( emailField );
				fields.push( emailField );
				
				// age
				ageField = createFormItem( viewWidth, formHeight, "Age", _data.age );
				background.addChild( ageField );
				fields.push( ageField );
			}
			
			// mask
			backgroundMask = DrawingUtils.drawFill( viewWidth, viewHeight, 0, StyleDict.RED1 );
			backgroundMask.mouseEnabled = false;
			backgroundMask.height = 0;
			addChild( backgroundMask );
			background.mask = backgroundMask;
		}
		
		/**
		 * @private 
		 */		
		override protected function layout():void
		{
			var prevItem:ProfileInfoFormItem;
			var index:int;
			
			// background
			background.x = 0;
			background.y = 0;
			
			// mask
			backgroundMask.x = 0;
			backgroundMask.y = 0;
			
			// profile items
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
			// profile items
			if ( fields )
			{
				for each ( _item in fields )
				{
					removeChildFromDisplayList( _item );
				}
			}
			
			removeChildFromDisplayList( backgroundMask );
			removeChildFromDisplayList( background );
			
			super.invalidate();
		}
		
		// ====================================
		// INTERNAL METHODS
		// ====================================
		
		/**
		 * Create and return a new form item.
		 * 
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