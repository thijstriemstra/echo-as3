/*
Echo project.

Copyright (C) 2003-2011 Collab

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
package com.collab.echo.containers.scrollpane
{
	import com.collab.cabin.containers.scrollpane.FlashScrollPane;
	import com.collab.cabin.display.util.DrawingUtils;
	import com.collab.cabin.display.util.StyleDict;
	import com.collab.echo.containers.panels.UserPanel;
	import com.collab.echo.core.rooms.IRoom;
	import com.collab.echo.model.UserVO;
	
	import fl.controls.ScrollPolicy;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * Scrollpane containing UserPanel instances.
	 * 
	 * @see com.collab.echo.containers.panels.UserPanel UserPanel
	 * 
	 * @author Thijs Triemstra
	 * @langversion 3.0
 	 * @playerversion Flash 10
	 */	
	public class UserScrollPane extends FlashScrollPane implements IRoom
	{
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _panels				: Vector.<UserPanel>;
		private var _background			: Sprite;
		private var _item				: UserPanel;
		private var _index				: int;
		private var _panelSkin			: Class;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
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
		public function UserScrollPane( width:Number=10, height:Number=200, skin:Class=null )
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
		 * Add new user.
		 * 
		 * @param client
		 */		
		public function addOccupant( client:UserVO ):void
		{
			//trace( "UserScrollPane.addOccupant: " + client );
			
			// panel
			_item = new _panelSkin();
			_item.data = client;
			
			// XXX: figure out how to measure the height of the scrollpane's
			// scrollbar instead of hardcoding it here
			_item.setSize( UserPanel.WIDTH, height - 15 );
			add( _item );
		}
		
		/**
		 * Remove existing user.
		 * 
		 * @param client
		 */		
		public function removeOccupant( client:UserVO ):void
		{
			//Logger.debug( "UserScrollPane.removeOccupant: " + client );
			
			// remove by id
			for each ( _item in _panels )
			{
				if ( _item.data && _item.data.id == client.id )
				{
					remove( _item );
					break;
				}
			}
		}
		
		/**
		 * Joined the room.
		 * 
		 * @param client
		 */		
		public function joinedRoom( client:UserVO ):void
		{
			//Logger.debug( "UserScrollPane.joinedRoom: " + client );
		}
		
		/**
		 * Total clients in room updated.
		 * 
		 * @param total
		 */		
		public function numClients( total:int ):void
		{
			//Logger.debug( "UserScrollPane.numClients: " + total );
		}
		
		/**
		 * @param client
		 * @param attr
		 */		
		public function clientAttributeUpdate( client:UserVO, attr:Object ):void
		{
			// update by id
			for each ( _item in _panels )
			{
				if ( _item.data && _item.data.id == client.id )
				{
					_item.data = client;
					break;
				}
			}
		}
		
		/**
		 * Set the size of this scrollpane.
		 *  
		 * @param arg0
		 * @param arg1
		 * @private
		 */		
		override public function setSize( arg0:Number, arg1:Number ):void
		{
			// XXX: look into this background redraw mess?
			// background
			super.remove( _background );
			_background = DrawingUtils.drawFill( arg0, arg1,
												 0, StyleDict.PURPLE1, 1 ); 
			super.add( _background );
			super.setSize( arg0, arg1 );
		}
		
		/**
		 * Add a new <code>UserPanel</code> instance.
		 * 
		 * @param child
		 * @return 
		 * @private
		 */		
		override public function add( child:DisplayObject ):Boolean
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
		 * @private
		 */		
		override public function layoutChildren():void
		{
			if ( _panels )
			{
				if ( _panels.length > 1 )
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
				else if ( _panels.length == 1 )
				{
					_item = _panels[ 0 ];
					_item.x = 0;
				}
			}
		}
		
		/**
		 * Remove a <code>UserPanel</code>.
		 * 
		 * @param child
		 * @return
		 * @private
		 * @see #removeAt()
		 * @see #removeAll()
		 */		
		override public function remove( child:DisplayObject ):Boolean
		{
			var success:Boolean = false;
			
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
				success = true;
			}
			
			return success;
		}
		
		/**
		 * Remove all <code>UserPanel</code> instances.
		 * 
		 * @return 
		 * @private
		 * @see #remove()
		 */		
		override public function removeAll():Boolean
		{
			var success:Boolean = false;
			
			if ( _panels && _panels.length > 0 )
			{
				// remove existing panels
				for each ( _item in _panels )
				{
					super.remove( _item );
				}
				
				success = true;
				_panels = new Vector.<UserPanel>();
			}
			
			return success;
		}
		
		/**
		 * Remove a <code>UserPanel</code> at a specified index.
		 * 
		 * @param index
		 * @return
		 * @private
		 * @see #remove()
		 * @see #removeAll()
		 */		
		override public function removeAt( index:int ):Boolean
		{
			var success:Boolean = false;
			
			try
			{
				_item = _panels[ index ];
				_panels.splice( index, 1 );
				success = remove( _item );
			}
			catch ( e:Error )
			{
			}

			return success;
		}
		
	}
}