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
package com.collab.echo.containers.scrollpane
{
	import fl.containers.ScrollPane;
	import fl.controls.ScrollBarDirection;
	import fl.controls.ScrollPolicy;
	import fl.events.ScrollEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Customizable <code>fl.containers.ScrollPane</code> with a <code>children</code> list.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class FlashScrollPane extends ScrollPane
	{
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _children		: Array;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		/**
		 * The panel's children.
		 * 
		 * @return 
		 */		
		public function get children():Array
		{
			return _children;
		}
		public function set children( val:Array ):void
		{
			_children = val;
		}
		
		/**
		 * Constructor. 
		 *  
		 * @param width
		 * @param height
		 */		
		public function FlashScrollPane( width:int=100, height:int=100 )
		{
			super();
			
			_children = [];
			
			name = getQualifiedClassName( this );
			scrollDrag = false;
			horizontalScrollPolicy = ScrollPolicy.ON;
			verticalScrollPolicy = ScrollPolicy.OFF;
			source = new Sprite();
			setSize( width, height );
			
			// listen for events
			addEventListener( Event.COMPLETE, onLoadComplete, false, 0, true );
			addEventListener( ScrollEvent.SCROLL, onScroll, false, 0, true );
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * @private 
		 */		
		override public function update():void
		{
			layoutChildren();
			
			super.update();
		}
		
		/**
		 * Add specified <code>child</code>.
		 * 
		 * @param child
		 * @return 
		 */		
		public function add( child:DisplayObject ):DisplayObject
		{
			if ( child && source )
			{
				source.addChild( child );
				_children.push( child );
				update();
			}
			
			return child;
		}
		
		/**
		 * Remove specified <code>child</code>.
		 * 
		 * @param child
		 */		
		public function remove( child:DisplayObject ):void
		{
			if ( child && source && source.contains( child ))
			{
				var d:int = 0;
				
				for ( d; d<_children.length;d++)
				{
					if ( _children[ d ] == child )
					{
						_children.splice( d, 1 );
					}
				}
				
				source.removeChild( child );
				update();
			}
		}
		
		/**
		 * Remove child at specified <code>index</code>.
		 * 
		 * @param index
		 * @return 
		 */		
		public function removeAt( index:int ):void
		{
			var child:DisplayObject;
			
			try
			{
				child = _children[ index ];
			}
			catch ( e:Error )
			{
				return;
			}
			
			remove( child );
			_children.splice( index, 1 );
		}
		
		/**
		 * Remove all children.
		 */		
		public function removeAll():void
		{
			if ( _children && _children.length > 0 )
			{
				// remove existing children
				for each ( var child:* in _children )
				{
					remove( child );
				}
				
				_children = [];
			}
		}
		
		/**
		 * Layout children.
		 */		
		public function layoutChildren():void
		{
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * @param event
		 */		
		protected function onLoadComplete( event:Event ):void
		{
			trace( "ScrollPane Load complete" );
		}
		
		/**
		 * @param arg0
		 */		
		override protected function keyUpHandler( arg0:KeyboardEvent ):void
		{
			super.keyUpHandler( arg0 );
		}
		
		/**
		 * @param arg0
		 */		
		override protected function keyDownHandler( arg0:KeyboardEvent ):void
		{
			super.keyDownHandler( arg0 );
		}
		
		/**
		 * @param event
		 */		
		protected function onScroll( event:ScrollEvent ):void
		{
			switch ( event.direction )
			{
				case ScrollBarDirection.HORIZONTAL:
					//trace( "horizontal scroll: " +  event.position + " of " +
					//			  event.currentTarget.maxHorizontalScrollPosition);
					break;
				
				case ScrollBarDirection.VERTICAL:
					// HACK: to prevent vertical scrolling with keyboard
					if ( verticalScrollPolicy == ScrollPolicy.OFF )
					{
						verticalScrollPosition = 0;
					}
					else
					{
						//trace( "vertical scroll: " + event.position + " of " +
						//		event.currentTarget.maxVerticalScrollPosition );
					}
					break;
			}
		}
		
	}
}