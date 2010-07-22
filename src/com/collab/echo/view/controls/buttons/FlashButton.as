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
package com.collab.echo.view.controls.buttons
{
	import com.collab.echo.view.display.util.StyleDict;
	import com.collab.echo.view.display.util.TextUtils;
	import com.greensock.TweenLite;
	
	import fl.controls.Button;
	
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.TextFormat;
	
	/**
	 * Customizable <code>fl.controls.Button</code> with a <code>DropShadow</code>.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class FlashButton extends Button
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		/**
		 * @private 
		 */		
		internal const SPEED	: Number = .3;
		
		// ====================================
		// ACCESSOR/MUTATOR
		// ====================================
		
		/**
		 * Creates the button's text style.
		 *  
		 * @return 
		 * 
		 */		
		public function get textFormat():TextFormat
		{
			return TextUtils.createTextFormat();
		}
		
		/**
		 * Creates the button's disabled text style.
		 *  
		 * @return 
		 */		
		public function get disabledTextFormat():TextFormat
		{
			return TextUtils.createTextFormat();
		}
		
		/**
		 * Constructor.
		 */		
		public function FlashButton()
		{
			super();
			
			// functionality
			doubleClickEnabled = false;
			buttonMode = false;
			visible = false;
			mouseChildren = false;
			
			// style
			filters = [ new DropShadowFilter( 3, 30, StyleDict.BLACK, .3) ];
			height = height + 6;
			alpha = 0;
			
			if ( textFormat.font )
			{
				setStyle( "embedFonts", true );
			}
			setStyle( "textFormat", textFormat );
			setStyle( "disabledTextFormat", disabledTextFormat );
			
			// listeners
			addEventListener( MouseEvent.MOUSE_UP, onMouseUp, false, 0, true );
			addEventListener( MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true );
			addEventListener( MouseEvent.CLICK, onClick, false, 0, true );
			addEventListener( MouseEvent.MOUSE_DOWN, onClick, false, 0, true );
		}

		// ====================================
		// PUBLIC/PROTECTED METHODS
		// ====================================
		
		/**
		 * Display component.
		 */		
		public function show():void
		{
			visible = true;
			alpha = 0;
			
			TweenLite.to( this, SPEED, { alpha: 1, onComplete: showComplete });
		}
		
		/**
		 * Hide component.
		 */		
		public function hide():void
		{
			TweenLite.to( this, SPEED, { alpha: 0, onComplete: hideComplete });
		}
		
		/**
		 * Resize button for name string. 
		 */		
		override protected function drawTextFormat():void
		{
			super.drawTextFormat();
			
			// resize
			var txtPad:Number = Number( getStyleValue( "textPadding" ));
			width = textField.textWidth + ( txtPad * 3 );
		}
		
		// ====================================
		// INTERNAL METHODS
		// ====================================
		
		/**
		 * Show transition completed. 
		 * 
		 * @private
		 */		
		internal function showComplete():void
		{
		}
		
		/**
		 * @private 
		 */		
		internal function hideComplete():void
		{
			visible = false;
		}
		
		/**
		 * Cleanup listeners. 
		 * 
		 * @private
		 */		
		internal function destroy():void
		{
			if ( hasEventListener( MouseEvent.MOUSE_UP ))
			{
				removeEventListener( MouseEvent.MOUSE_UP, onMouseUp, true );
				removeEventListener( MouseEvent.MOUSE_OUT, onMouseOut, true );
				removeEventListener( MouseEvent.CLICK, onClick, true );
				removeEventListener( MouseEvent.MOUSE_DOWN, onClick, true );
			}
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * @param event
		 */		
		public function onClick( event:MouseEvent ):void
		{
			event.stopImmediatePropagation();
		}
		
		/**
		 * @param event
		 */		
		public function onMouseOut( event:MouseEvent ):void
		{
			event.stopImmediatePropagation();
			
			hide();
		}
		
		/**
		 * @param event
		 */		
		public function onMouseUp( event:MouseEvent ):void
		{
			event.preventDefault();
			
			hide();
		}
		
	}
}