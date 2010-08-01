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
	import com.collab.echo.view.hub.video.display.UserInfoBar;
	import com.collab.echo.view.hub.video.display.UserNameBar;
	import com.collab.echo.view.hub.video.form.ProfileInfo;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
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
		protected var nameBar			: UserNameBar;
		protected var infoBar			: UserInfoBar;
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
			}
		}
		
		/**
		 * @return 
		 */		
		public function get title():UserNameBar
		{
			var value:String;
			
			if ( _data )
			{
				value = _data.username;
			}
			
			return new UserNameBar( viewWidth, 30, value );
		}
		
		/**
		 * @return 
		 */		
		public function get profile():ProfileInfo
		{
			var h:Number = viewHeight - ( nameBar.height + infoBar.height );
			var profileInfo:ProfileInfoVO = new ProfileInfoVO();
			
			if ( _data )
			{
				profileInfo.age = _data.age;
				profileInfo.email = _data.email;
				profileInfo.location = _data.location;
				profileInfo.website = _data.website;
			}
			
			return new ProfileInfo( viewWidth, h, profileInfo );
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
			
			// info
			infoBar = new UserInfoBar( viewWidth, 30 );
			addChild( infoBar );
			
			// name
			nameBar = title;
			nameBar.addEventListener( MouseEvent.CLICK, onNameClick,
									  false, 0, true );
			addChild( nameBar );
			
			// icon
			var h:Number =  viewHeight - ( infoBar.height + nameBar.height );
			icon = DrawingUtils.drawFill( viewWidth, h, 0, StyleDict.GREY2 );
			icon.buttonMode = true;
			icon.addEventListener( MouseEvent.CLICK, onVideoClick,
								   false, 0, true );
			addChild( icon );
			
			// profile info
			profileInfo = profile;
			addChild( profileInfo );
		}
		
		/**
		 * @private 
		 */		
		override protected function layout():void
		{
			// info
			infoBar.x = 0;
			infoBar.y = viewHeight - infoBar.height;
			
			// name 
			nameBar.x = 0;
			nameBar.y = infoBar.y - nameBar.height;
			
			// icon
			icon.x = 0;
			icon.y = 0;
			
			// profile info
			profileInfo.x = 0;
			profileInfo.y = 0;
		}
		
		/**
		 * @private 
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( panel );
			removeChildFromDisplayList( nameBar );
			removeChildFromDisplayList( infoBar );
			removeChildFromDisplayList( icon );
			removeChildFromDisplayList( profileInfo );
			
			super.invalidate();
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * @private 
		 * @param event
		 */		
		protected function onNameClick( event:MouseEvent ):void
		{
			profileInfo.toggle();
		}
		
		/**
		 * @private 
		 * @param event
		 */		
		protected function onVideoClick( event:MouseEvent ):void
		{
		}
		
	}
}