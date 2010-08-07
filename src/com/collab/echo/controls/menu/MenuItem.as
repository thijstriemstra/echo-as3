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
package com.collab.echo.controls.menu
{
	import com.collab.echo.controls.buttons.LabelButton;
	import com.collab.echo.display.BaseView;
	import com.collab.echo.display.util.StyleDict;
	import com.collab.echo.events.MenuItemClickEvent;
	
	import flash.events.MouseEvent;
	
	// ====================================
	// EVENTS
	// ====================================
	
	/**
	 * Dispatched when the menu item is clicked.
	 *
	 * @eventType com.collab.echo.events.MenuItemClickEvent.CLICK
	 */
	[Event(name="MenuItemClickEvent_click", type="com.collab.echo.events.MenuItemClickEvent")]
	
	/**
	 * Menu item.
	 *  
	 * @author Thijs Triemstra
	 */	
	public class MenuItem extends BaseView
	{
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		protected var button				: LabelButton;
		protected var label					: String;
		protected var upColor				: uint;
		protected var selectColor			: uint;
		protected var backgroundColor		: uint;
		protected var backgroundAlpha		: int;
		
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		/**
		 * @private 
		 */		
		internal var itemIndex				: int;
		
		/**
		 * @private 
		 */		
		internal var selectedState			: Boolean;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		/**
		 * Height of the internal button.
		 * 
		 * @return 
		 */		
		public function get buttonHeight():Number
		{
			var h:Number = 0;
			
			if ( button )
			{
				h = button.height;
			}
			
			return h;
		}
		
		/**
		 * Width of the internal button.
		 * 
		 * @return 
		 */		
		public function get buttonWidth():Number
		{
			var w:Number = 0;
			
			if ( button )
			{
				w = button.viewWidth;
			}
			
			return w;
		}
		
		/**
		 * Selection state of this item.
		 * 
		 * @return 
		 */		
		public function get selected():Boolean
		{
			return selectedState;
		}
		
		/**
		 * Index of this item.
		 * 
		 * @return 
		 */		
		public function get index():int
		{
			return itemIndex;
		}
		
		/**
		 * Constructor.
		 *  
		 * @param index
		 * @param label
		 */		
		public function MenuItem( index:int=0, label:String=null )
		{
			// init vars
			this.label = label;
			this.name = label;
			this.itemIndex = index;
			
			this.upColor = StyleDict.BLACK;
			this.selectColor = StyleDict.GREY4;
			this.backgroundColor = StyleDict.YELLOW1;
			this.backgroundAlpha = 1;
			
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
			// button
			button = new LabelButton( 0, 15, upColor, backgroundColor, backgroundAlpha,
									  0, 0, 1 );
			button.addEventListener( MouseEvent.CLICK, onItemClick, false, 0, true );
			button.label = label;
			addChild( button );
		}
		
		/**
		 * @private 
		 */		
		override protected function layout():void
		{
			// button
			button.x = 0;
			button.y = 0;
		}
		
		/**
		 * @private 
		 * 
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( button );
			
			super.invalidate();
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * Select the menu item. 
		 */		
		public function select():void
		{
		}
		
		/**
		 * Deselect the menu item. 
		 */		
		public function deselect():void
		{
		}
		
		/**
		 * @private 
		 * @return 
		 */		
		override public function toString():String
		{
			return "<MenuItem label='" + label + "' index='" + itemIndex + "'/>";
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * Invoked when the menu item was clicked.
		 * 
		 * @param event
		 * @private
		 */		
		protected function onItemClick( event:MouseEvent ):void
		{
			event.stopImmediatePropagation();
			
			var evt:MenuItemClickEvent = new MenuItemClickEvent( MenuItemClickEvent.CLICK,
																 itemIndex, label, true, true );
			dispatchEvent( evt );
		}
		
	}
}