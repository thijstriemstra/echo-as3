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
package com.collab.echo.view.hub.chat.display
{
	import com.collab.echo.view.display.BaseView;
	
	import fl.controls.Button;
	import fl.controls.TextInput;
	
	/**
	 * @author Thijs Triemstra
	 */	
	public class ChatInputField extends BaseView
	{
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		internal var textInput		: TextInput;
		internal var submitButton	: Button;
		
		public function get text():String
		{
			return textInput.text;
		}
		public function set text( val:String ):void
		{
			textInput.text = val;
		}
		
		public function get htmlText():String
		{
			return textInput.htmlText;
		}
		public function set htmlText( val:String ):void
		{
			textInput.htmlText = val;
		}
		
		/**
		 * Constructor. 
		 *  
		 * @param width
		 * @param height
		 */		
		public function ChatInputField( width:int, height:int=50 )
		{
			super( width, height );
			show();
		}
		
		// ====================================
		// PUBLIC/PROTECTED METHODS
		// ====================================
		
		/**
		 * Instantiate and add child(ren) to display list.
		 */	
		override protected function draw() : void
		{
			// textInput
			textInput = new TextInput();
			textInput.text = "Hello!";
			textInput.width = viewWidth - 50;
			addChild( textInput );
			
			// submit btn
			submitButton = new Button();
			submitButton.width = 50;
			submitButton.label = "Submit";
			addChild( submitButton );
		}
		
		/**
		 * Position child(ren) on display list.
		 */
		override protected function layout():void
		{
			// textInput
			textInput.x = 0;
			textInput.y = 0;
			
			// submit btn
			submitButton.x = textInput.width;
			submitButton.y = 0;
		}
		
		/**
		 * Remove and redraw child(ren).
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( textInput );
			removeChildFromDisplayList( submitButton );
			
			super.invalidate();
		}
		
	}
}