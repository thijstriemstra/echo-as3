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
package com.collab.echo.view.controls
{
	import com.collab.echo.view.controls.menu.MenuDirection;
	import com.collab.echo.view.controls.menu.MenuItem;
	import com.collab.echo.view.display.BaseView;
	import com.collab.echo.view.events.MenuItemClickEvent;
	
	/**
	 * List of <code>MenuItem</code> instances.
	 * 
	 * @author Thijs Triemstra
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
		internal var direction				: String;
		
		/**
		 * @private 
		 */		
		internal var label:String;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		/**
		 * @return 
		 */		
		public function get dataProvider():Array
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
		public function get selectedIndex():int
		{
			return selectedMenuIndex;
		}
		
		/**
		 * @return 
		 */		
		public function get selectedItem():MenuItem
		{
			return selectedMenuItem;
		}
		
		/**
		 * Constructor. 
		 * 
		 * @param itemType Type of menu item.
		 * @param direction
		 */		
		public function Menu( itemType:Class=null, direction:String=MenuDirection.VERTICAL )
		{
			if ( itemType == null )
			{
				menuType = MenuItem;
			}
			else
			{
				menuType = itemType;
			}
			
			this.direction = direction;
			selectedMenuIndex = -1;
			
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
				for ( var d:int=0; d<items.length; d++ )
				{
					label = String( items[ d ]).toLowerCase();
					var item:* = new menuType( d, label );
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
			if ( items )
			{
				for ( var d:int=0; d<items.length; d++ )
				{
					label = String( items[ d ]).toLowerCase();
					var item:* = menuType( getChildByName( label ));

					if ( item )
					{
						if ( direction == MenuDirection.VERTICAL )
						{
							item.x = 0;
							item.y = item.buttonHeight * d;
						}
						else if ( direction == MenuDirection.HORIZONTAL )
						{
							item.x = item.buttonWidth * d;
							item.y = 0;
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
				for ( var d:int=0; d<items.length; d++ )
				{
					label = String( items[ d ]).toLowerCase();
					var item:* = menuType( getChildByName( label ));
					
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