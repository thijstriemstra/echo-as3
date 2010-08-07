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
	import com.collab.echo.controls.buttons.LabelButton;
	import com.collab.echo.display.BaseView;
	import com.collab.echo.display.util.StyleDict;
	import com.collab.echo.events.ChatEvent;
	
	import fl.controls.TextInput;
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	// ====================================
	// EVENTS
	// ====================================
	
	/**
	 * @eventType com.collab.echo.events.ChatEvent.HISTORY_DOWN
	 */
	[Event(name="historyDown", type="com.collab.echo.events.ChatEvent")]

	/**
	 * @eventType com.collab.echo.events.ChatEvent.HISTORY_UP
	 */
	[Event(name="historyUp", type="com.collab.echo.events.ChatEvent")]
	
	/**
	 * @eventType com.collab.echo.events.ChatEvent.SUBMIT
	 */
	[Event(name="submit", type="com.collab.echo.events.ChatEvent")]
	
	/**
	 * Component with a text input field and send button.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class ChatInputField extends BaseView
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		private static const BUTTON_WIDTH	: int = 50;
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _textInput			: TextInput;
		private var _submitButton		: LabelButton;
		private var _inputMessage		: String;
		private var _buttonLabel		: String;
		private var _event				: ChatEvent;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		/**
		 * @return 
		 */		
		public function get text():String
		{
			return _textInput.text;
		}
		public function set text( val:String ):void
		{
			if ( val )
			{
				_inputMessage = val;
				invalidate();
			}
		}
		
		/**
		 * @return 
		 */		
		public function get buttonLabel():String
		{
			return _submitButton.label;
		}
		public function set buttonLabel( val:String ):void
		{
			if ( val )
			{
				_buttonLabel = val;
				invalidate();
			}
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
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * Instantiate and add child(ren) to display list.
		 * 
		 * @private
		 */	
		override protected function draw() : void
		{
			// textInput
			_textInput = new TextInput();
			if ( _inputMessage )
			{
				_textInput.text = _inputMessage;
			}
			_textInput.width = viewWidth - BUTTON_WIDTH;
			_textInput.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown,
										 false, 0, true );
			addChild( _textInput );
			
			// submit btn
			_submitButton = new LabelButton( BUTTON_WIDTH, 13, StyleDict.BLACK,
											 StyleDict.WHITE );
			_submitButton.width = BUTTON_WIDTH;
			if ( _buttonLabel )
			{
				_submitButton.label = _buttonLabel;
			}
			_submitButton.addEventListener( MouseEvent.CLICK, onSubmitClick,
											false, 0, true );
			addChild( _submitButton );
		}
		
		/**
		 * Position child(ren) on display list.
		 * 
		 * @private
		 */
		override protected function layout():void
		{
			// textInput
			_textInput.x = 0;
			_textInput.y = 0;
			
			// submit btn
			_submitButton.x = _textInput.width;
			_submitButton.y = 3;
		}
		
		/**
		 * Remove and redraw child(ren).
		 * 
		 * @private
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( _textInput );
			removeChildFromDisplayList( _submitButton );
			
			super.invalidate();
		}
		
		/**
		 * @return 
		 */		
		protected function submitMessage():ChatEvent
		{
			var event:ChatEvent;
			
			// the message typed by the user
			var msg:String = _textInput.text;
			
			// only send the message if there's text
			if ( msg.length > 0 )
			{
				event = new ChatEvent( ChatEvent.SUBMIT );
				event.data = msg;
				
				// clear the user input text field
				_textInput.text = "";
			}
			
			return event;
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * @param event
		 */		
		protected function onSubmitClick( event:MouseEvent ):void
		{
			event.stopPropagation();
			
			_event = submitMessage();
			
			if ( _event )
			{
				dispatchEvent( _event );
				_event = null;
			}
		}
		
		/**
		 * @param event
		 */		
		protected function onKeyDown( event:KeyboardEvent ):void
		{
			event.stopPropagation();
			
			switch ( event.keyCode )
			{
				case Keyboard.ENTER:
					_event = submitMessage();
					break;
				
				case Keyboard.UP:
					if ( event.altKey )
					{
						_event = new ChatEvent( ChatEvent.HISTORY_UP );
					}
					break;
				
				case Keyboard.DOWN:
					if ( event.altKey )
					{
						_event = new ChatEvent( ChatEvent.HISTORY_DOWN );
					}
					break;
			}
			
			if ( _event )
			{
				dispatchEvent( _event );
				_event = null;
			}
		}
		
	}
}