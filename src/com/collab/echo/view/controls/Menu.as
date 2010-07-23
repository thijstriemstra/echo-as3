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
	import com.collab.echo.view.controls.menu.MenuItem;
	import com.collab.echo.view.display.BaseView;
	import com.collab.echo.view.events.MenuItemClickEvent;
	
	/**
	 * Vertical list of <code>MenuItem</code> instances.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class Menu extends BaseView
	{
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		internal var items					: Array;
		internal var selectedMenuIndex		: int;
		internal var selectedMenuItem		: MenuItem;
		internal var menuType				: Class;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
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
		
		public function get selectedIndex():int
		{
			return selectedMenuIndex;
		}
		
		public function get selectedItem():MenuItem
		{
			return selectedMenuItem;
		}
		
		/**
		 * Constructor. 
		 * 
		 * @param itemType Type of menu item.
		 */		
		public function Menu( itemType:Class=null )
		{
			if ( itemType == null )
			{
				menuType = MenuItem;
			}
			else
			{
				menuType = itemType;
			}
			
			selectedMenuIndex = -1;
			
			super();
			show();
		}
		
		override protected function draw():void
		{
			var label:String;
			
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
		
		override protected function layout():void
		{
			var label:String;
			
			if ( items )
			{
				for ( var d:int=0; d<items.length; d++ )
				{
					label = String( items[ d ]).toLowerCase();
					var item:* = menuType( getChildByName( label ));
	
					if ( item )
					{
						item.x = 0;
						item.y = item.buttonHeight * d;
					}
				}
			}
		}
		
		override protected function invalidate():void
		{
			var label:String;
			
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