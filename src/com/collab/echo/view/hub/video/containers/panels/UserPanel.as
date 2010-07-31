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
package com.collab.echo.view.hub.video.containers.panels
{
	import com.collab.echo.model.vo.ProfileInfoVO;
	import com.collab.echo.model.vo.UserVO;
	import com.collab.echo.view.containers.panels.Panel;
	import com.collab.echo.view.display.util.DrawingUtils;
	import com.collab.echo.view.display.util.StyleDict;
	import com.collab.echo.view.display.util.TextUtils;
	import com.collab.echo.view.hub.video.form.ProfileInfo;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * Panel containing profile info, video and username.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class UserPanel extends Panel
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		internal static const COLOR1	: uint = 0xEFEFEF;
		
		public static const WIDTH		: int = 200;

		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _data				: UserVO;
		
		// ====================================
		// PROTECTED VARS
		// ====================================
			
		protected var panel				: Shape;
		protected var icon				: Sprite;
		protected var nameBar			: Sprite;
		protected var infoBar			: Sprite;
		protected var nameField			: TextField;
		protected var profileInfo		: ProfileInfo;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		/**
		 * @return 
		 */		
		public function get data():UserVO
		{
			return _data;
		}
		public function set data( val:UserVO ):void
		{
			if ( val )
			{
				_data = val;
				
				name = "userPanel" + _data.id;
				invalidate();
				
				/*
				// show rank icon
				newVideo.screen.header_mc.gotoAndStop(rank);
				
				// admin or mod
				if (_root.userMode == "guest")
				{
					newVideo.screen.header_mc.kick_icon._visible = false;
				}
				else
				{
					newVideo.screen.header_mc.kick_icon._visible = true;
				}
				
				if ( isSelf() )
				{
					// Hide the pm button 
					newVideo.screen.header_mc.pm_mc._visible = false;
					newVideo.screen.header_mc.kick_icon._visible = false;
				}
				*/
			}
		}
		
		/**
		 * @return 
		 */		
		public function get title():TextField
		{
			var value:String
			
			if ( _data )
			{
				value = _data.username;
			}
			return TextUtils.createTextField( null, value, 24,
										      StyleDict.WHITE, false, true );
		}
		
		/**
		 * @return 
		 */		
		public function get profile():ProfileInfo
		{
			var profileInfo:ProfileInfoVO = new ProfileInfoVO();
			
			if ( _data )
			{
				profileInfo.age = _data.age;
				profileInfo.email = _data.email;
				profileInfo.location = _data.location;
				profileInfo.website = _data.website;
			}
			
			return new ProfileInfo( viewWidth, viewHeight, profileInfo );
		}
		
		/**
		 * Constructor.
		 * 
		 * @param data
		 * @param width
		 * @param height
		 */		
		public function UserPanel( data:UserVO=null, width:int=WIDTH, height:int=0 )
		{
			super( true, width, height );
			show();

			_data = data;
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
												StyleDict.GREEN1, 1 );
			background.mouseChildren = false;
			addChild( background );
			
			// panel
			var lineThickness:Number = 1;
			panel = new Shape();
			with ( panel.graphics )
			{
				lineStyle( lineThickness, StyleDict.BLACK, 1 );
				beginFill( StyleDict.GREY3, 1 );
				drawRect( 0, 0, viewWidth, viewHeight );
				endFill();
			}
			addChild( panel );
			
			// icon
			
			
			// name
			nameField = title;
			addChild( nameField );
			
			// profile info
			profileInfo = profile;
			profileInfo.visible = false;
			addChild( profileInfo );
		}
		
		/**
		 * @private 
		 */		
		override protected function layout():void
		{
			// title 
			nameField.x = 10;
			nameField.y = 10;
			
			// profile info
			profileInfo.x = nameField.x;
			profileInfo.y = nameField.y + nameField.height;
		}
		
		/**
		 * @private 
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( panel );
			removeChildFromDisplayList( nameField );
			removeChildFromDisplayList( profileInfo );
			
			super.invalidate();
		}
		
	}
}