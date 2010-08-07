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
package com.collab.echo.controls
{
	import com.collab.echo.controls.menu.MenuDirection;
	import com.collab.echo.controls.menu.MenuItem;
	import com.collab.echo.display.BaseView;
	import com.collab.echo.events.MenuItemClickEvent;
	
	import flash.geom.Point;
	
	/**
	 * List of <code>MenuItem</code> instances.
	 * 
	 * @see com.collab.echo.controls.menu.MenuItem
	 * 
	 * @author Thijs Triemstra
	 * @langversion 3.0
     * @playerversion Flash 9
	 */	
	public class Menu extends BaseView
	{
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		/**
		 * @private 
		 */		
		internal var items					: Array;
		
		/**
		 * @private 
		 */		
		internal var selectedMenuIndex		: int;
		
		/**
		 * @private 
		 */		
		internal var selectedMenuItem		: MenuItem;
		
		/**
		 * @private 
		 */		
		internal var menuType				: Class;
		
		/**
		 * @private 
		 */		
		internal var label					: String;
		
		/**
		 * @private 
		 */		
		internal var index					: int;
		
		/**
		 * @private 
		 */		
		internal var item					: *;
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _offSet					: Point;
		private var _horizontalGap			: int;
		private var _verticalGap			: int;
		private var _direction				: String;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		/**
		 * @return 
		 */		
		public function get horizontalGap():int
		{
			return _horizontalGap;
		}
		public function set horizontalGap( val:int ):void
		{
			if ( val )
			{
				_horizontalGap = val;
				invalidate();
			}
		}
		
		/**
		 * @return 
		 */		
		public function get verticalGap():int
		{
			return _verticalGap;
		}
		
		/**
		 * @return 
		 */		
		public function get dataProvider()	: Array
		{
			return items;
		}
		public function set dataProvider( val:Array ):void
		{
			if ( val )
			{
				items = val;
				invalidate();
			}
		}
		
		/**
		 * @return 
		 */		
		public function get selectedIndex()	: int
		{
			return selectedMenuIndex;
		}
		
		/**
		 * @return 
		 */		
		public function get selectedItem()	: MenuItem
		{
			return selectedMenuItem;
		}
		
		/**
		 * @return 
		 */		
		public function get direction()		: String
		{
			return _direction;
		}
		
		/**
		 * Constructor. 
		 * 
		 * @param itemType Type of menu item.
		 * @param direction
		 * @param offset
		 * @param horizontalGap
		 * @param verticalGap
		 */		
		public function Menu( itemType:Class=null, direction:String="vertical",
							  offset:Point=null, horizontalGap:int=0, verticalGap:int=0 )
		{
			if ( itemType == null )
			{
				menuType = MenuItem;
			}
			else
			{
				menuType = itemType;
			}
			
			this.selectedMenuIndex = -1;
			
			_direction = direction;
			_horizontalGap = horizontalGap;
			_verticalGap = verticalGap;
			
			if ( offset )
			{
				_offSet = offset;
			}
			else
			{
				_offSet = new Point();
			}
			
			super();
			show();
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * @private 
		 */		
		override protected function draw():void
		{
			if ( items )
			{
				index = 0;
				for ( index; index < items.length; index++ )
				{
					// XXX: switch to objects so all items are unique
					label = String( items[ index ]).toLowerCase();
					item = new menuType( index, label );
					item.addEventListener( MenuItemClickEvent.CLICK,
										   onItemClick, false, 0, true );
					addChild( item );
				}
			}
		}
		
		/**
		 * @private 
		 */		
		override protected function layout():void
		{
			var newX:int = 0;
			
			if ( items )
			{
				index = 0;
				for ( index; index < items.length; index++ )
				{
					label = String( items[ index ]).toLowerCase();
					item = menuType( getChildByName( label ));

					if ( item )
					{
						if ( _direction == MenuDirection.VERTICAL )
						{
							// position based on equal height
							item.x = _offSet.x;
							item.y = _offSet.y + (( item.buttonHeight + _verticalGap ) * index );
						}
						else if ( _direction == MenuDirection.HORIZONTAL )
						{
							// position based on variable width
							if ( item.width > 0 )
							{
								item.x = _offSet.x + newX;
								item.y = _offSet.y;
								newX += item.buttonWidth + _horizontalGap;
							}
						}
					}
				}
			}
		}
		
		/**
		 * @private 
		 */		
		override protected function invalidate():void
		{
			if ( items )
			{
				index = 0;
				for ( index; index<items.length; index++ )
				{
					label = String( items[ index ]).toLowerCase();
					item = menuType( getChildByName( label ));
					
					if ( item )
					{
						removeChild( item );
					}
				}
			}
			
			super.invalidate();
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * @private
		 * @param event
		 */		
		internal function onItemClick( event:MenuItemClickEvent ):void
		{
			if ( selectedMenuItem )
			{
				selectedMenuItem.deselect();
			}
			
			selectedMenuItem = menuType( event.target );
			selectedMenuIndex = selectedMenuItem.index;
			selectedMenuItem.select();
		}
		
	}
}