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
package com.collab.echo.controls.buttons
{
	import com.collab.cabin.display.util.StyleDict;
	import com.collab.echo.events.CommunicationPanelEvent;
	
	import flash.events.MouseEvent;
	import flash.text.Font;

	// ====================================
	// EVENTS
	// ====================================
	
	/**
	 * @eventType com.collab.echo.events.CommunicationPanelEvent.EXPAND
	 */
	[Event(name="expand", type="com.collab.echo.events.CommunicationPanelEvent")]
	
	/**
	 * @eventType com.collab.echo.events.CommunicationPanelEvent.COLLAPSE
	 */
	[Event(name="collapse", type="com.collab.echo.events.CommunicationPanelEvent")]
	
	/**
	 * Expands the communication panel.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class BaseExpandButton extends LabelButton
	{
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		internal var expanded	: Boolean;
		
		/**
		 * Constructor.
		 *  
		 * @param width
		 * @param font
		 * @param fontSize
		 * @param textUpColor
		 * @param backgroundColor
		 * @param backgroundAlpha
		 * @param cornerRadius
		 * @param padding
		 * @param alpha
		 * @param bold
		 */		
		public function BaseExpandButton( width:Number=123, font:Font=null,
										  fontSize:int=15,
										  textUpColor:uint=StyleDict.BLACK,
										  backgroundColor:uint=StyleDict.YELLOW1,
										  backgroundAlpha:Number=1,
										  cornerRadius:Number=0, padding:Number=4,
										  alpha:Number=1, bold:Boolean=false  )
		{
			super( width, fontSize, textUpColor, backgroundColor, backgroundAlpha,
				   cornerRadius, padding, alpha, bold, font );
			
			doubleClickEnabled = false;
			
			// listen for events
			addEventListener( MouseEvent.CLICK, onMouseClick, false, 0, true );
			
			expand( true );
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * @private 
		 * @param event
		 */		
		protected function onMouseClick( event:MouseEvent ):void
		{
			event.preventDefault();
			
			expand( !expanded );
		}
		
		/**
		 * @param event
		 * @private
		*/		
		override protected function onMouseOver( event:MouseEvent ):void
		{
			event.preventDefault();
		}
		
		/**
		 * @param event
		 * @private
		 */		
		override protected function onMouseOut( event:MouseEvent ):void
		{
			event.preventDefault();
		}
		
		// ====================================
		// INTERNAL METHODS
		// ====================================
		
		/**
		 * @param activate
		 */		
		internal function expand( activate:Boolean ):void
		{
			var type:String;
			expanded = activate;
			
			if ( expanded )
			{
				label = "Expand";
				type = CommunicationPanelEvent.COLLAPSE;
			}
			else
			{
				label = "Collapse";
				type = CommunicationPanelEvent.EXPAND;
			}
			
			var evt:CommunicationPanelEvent = new CommunicationPanelEvent( type );
			dispatchEvent( evt );
		}
		
	}
}