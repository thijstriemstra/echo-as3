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
package com.collab.echo.view.hub.video
{
	import com.collab.echo.model.vo.UserVO;
	import com.collab.echo.view.containers.scrollpane.FlashScrollPane;
	import com.collab.echo.view.display.util.DrawingUtils;
	import com.collab.echo.view.display.util.StyleDict;
	import com.collab.echo.view.hub.interfaces.IPresence;
	import com.collab.echo.view.hub.video.panels.UserPanel;
	
	import fl.controls.ScrollPolicy;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * @author Thijs Triemstra
	 */	
	public class VideoScrollPane extends FlashScrollPane implements IPresence
	{
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		internal var _panels			: Vector.<UserPanel>;
		internal var _background		: Sprite;
		internal var _item				: UserPanel;
		internal var _user				: UserVO;
		internal var _index				: int;
		internal var _users				: Vector.<UserVO>;
		internal var _panelSkin			: Class;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		/**
		 * Active users.
		 *  
		 * @return 
		 */		
		public function get data():Vector.<UserVO>
		{
			return _users;
		}
		public function set data( val:Vector.<UserVO> ):void
		{
			if ( val && val.length > 0 )
			{
				// remove old panels
				removeAll();
				
				// add new panels
				_users = val;
				for each ( _user in _users )
				{
					// panel
					_item = new _panelSkin();
					_item.data = _user;
					_item.setSize( UserPanel.WIDTH, height );
					add( _item );
				}
			}
		}
		
		/**
		 * Skin for the <code>UserPanel</code>.
		 *  
		 * @return 
		 */		
		public function get panelSkin():Class
		{
			return _panelSkin;
		}
		public function set panelSkin( val:Class ):void
		{
			_panelSkin = val;
			invalidate();
		}
		
		/**
		 * Constructor.
		 * 
		 * @param width
		 * @param height
		 * @param skin
		 */		
		public function VideoScrollPane( width:Number=0, height:Number=200, skin:Class=null )
		{
			_panelSkin = skin;
			_panels = new Vector.<UserPanel>();
			
			super( width, height );
			
			horizontalScrollPolicy = ScrollPolicy.ON;
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * @param client
		 */		
		public function addUser( client:UserVO ):void
		{
			trace("VideoScrollPane.addUser: " + client );
			
			/*
			// init
			newVideo.opener = userID;
			newVideo.gotoAndStop("open");
			
			var totalWindows:Number = client.getTargetMC().chat.video_mcs.content.panels.length;
			
			newVideo._x = totalWindows*newVideo._width;
			newVideo.screen.username = username;
			newVideo.screen.location = location;
			newVideo.screen.website = hyperlinked;
			newVideo.screen.email = email;
			newVideo.screen.age = age;
			newVideo.screen.origPos = totalWindows;
			newVideo.screen.curPos = totalWindows+1;
			
			// show rank icon
			newVideo.screen.header_mc.gotoAndStop(rank);
			
			// show trivia icon
			if (trivia == "true")
			{
			newVideo.screen.header_mc.trivia_icon._visible = true;
			}
			else
			{
			newVideo.screen.header_mc.trivia_icon._visible = false;
			}
			
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
		
		/**
		 * @param client
		 */		
		public function removeUser( client:UserVO ):void
		{
			trace("VideoScrollPane.removeUser: " + client );
			
			/*
			// remove videoPanel
			for (var g:Number=0; g<allVideos.length; g++)
			{
			if (allVideos[g]._name == panelname)
			{
			removeMovieClip(allVideos[g]);
			allVideos.splice(g,1);
			break;
			}
			}
			
			// reposition videoPanels
			for (var f:Number=0; f<allVideos.length; f++)
			{
			// re-order windows
			allVideos[f]._x = f*170;
			
			allVideos[f].screen.origPos = f+1;
			allVideos[f].screen.curPos = f+1;
			allVideos[f].screen.pos_stepper.value = f+1;
			allVideos[f].screen.pos_stepper.maximum = allVideos.length;
			
			//trace(allVideos[f].windowID + ", " + f);
			//trace("===================== ");
			}
			
			// redraw component
			client.getTargetMC().chat.video_mcs.redraw(true);

			*/
		}
		
		/**
		 * Set the size of this <code>FlashScrollPane</code>.
		 *  
		 * @param arg0
		 * @param arg1
		 */		
		override public function setSize( arg0:Number, arg1:Number ):void
		{
			// XXX: look into this background redraw mess
			// background
			super.remove( _background );
			_background = DrawingUtils.drawFill( arg0, arg1,
												 0, StyleDict.PURPLE1, 1 ); 
			super.add( _background );
			super.setSize( arg0, arg1 );
		}
		
		/**
		 * Add a new <code>UserPanel</code>.
		 * 
		 * @param child
		 * @return 
		 */		
		override public function add( child:DisplayObject ):DisplayObject
		{
			_index = 0;
			
			// cleanup
			for each ( _item in _panels )
			{
				if ( child == _item )
				{
					removeAt( _index );
					_panels.splice( _index, 1 );
					break;
				}
			}
			
			// add
			_item = child as UserPanel;
			if ( _item )
			{
				_panels.push( _item );
				super.add( _item );
			}
			
			return _item;
		}
		
		/**
		 * Position all <code>UserPanel</code> instances. 
		 */		
		override public function layoutChildren():void
		{
			if ( _panels && _panels.length > 1 )
			{
				var prevItem:UserPanel;
				_index = 0;
				
				for each ( _item in _panels )
				{
					prevItem = _panels[ _index ];
					_item.x = prevItem.width * _index;
					_index++;
				}
			}
		}
		
		/**
		 * Remove a <code>UserPanel</code>.
		 * 
		 * @param child
		 */		
		override public function remove( child:DisplayObject ):void
		{
			if ( child && _panels )
			{
				for ( _index=0; _index<_panels.length; _index++)
				{
					if ( _panels[ _index ] == child )
					{
						_panels.splice( _index, 1 );
					}
				}
				
				super.remove( child );
			}
		}
		
		/**
		 * Remove all <code>UserPanel</code> instances.
		 */		
		override public function removeAll():void
		{
			if ( _panels && _panels.length > 0 )
			{
				// remove existing panels
				for each ( _item in _panels )
				{
					super.remove( _item );
				}
				
				_panels = new Vector.<UserPanel>();
			}
		}
		
		/**
		 * Remove a <code>UserPanel</code> at a specified index.
		 * 
		 * @param index
		 */		
		override public function removeAt( index:int ):void
		{
			try
			{
				_item = _panels[ index ];
			}
			catch ( e:Error )
			{
				return;
			}

			_panels.splice( index, 1 );
			remove( _item );
		}
		
	}
}