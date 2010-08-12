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
	import com.collab.echo.display.util.StyleDict;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * Simple transparent button with a label.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */
	public class LabelButton extends Sprite
	{
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		protected var CORNER_RADIUS			: Number;
		protected var PADDING				: Number;
		protected var ALPHA					: Number;
		
		protected var background			: Shape;
		protected var text					: TextField;
		protected var font 					: Font;
		
		private var _label					: String;
		private var _width					: Number;
		private var _height					: Number;
		private var _textColor				: uint;
		private var _backgroundColor		: uint;
		private var _fontSize				: int;
		private var _enabled				: Boolean;
		private var _bold					: Boolean;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		public function set enabled( val:Boolean ):void
		{
			if (val)
			{
				_enabled = val;
				mouseEnabled = buttonMode = _enabled;
				invalidate();
			}
		}
		
		public function get label():String
		{
			return _label;
		}
		
		public function set label( val:String ):void
		{
			if (val)
			{
				_label = val;
				invalidate();
			}
		}
		
		public function get textColor() : uint
		{
			return _textColor;
		}
		public function set textColor( val:uint ):void
		{
			if (val)
			{
				_textColor = val;
				invalidate();
			}
		}
		
		/**
		 * @param val
		 */		
		public function set backgroundColor( val:uint ):void
		{
			if (val)
			{
				_backgroundColor = val;
				invalidate();
			}
		}
		public function get backgroundColor():uint
		{
			return _backgroundColor;
		}
		
		/**
		 * @return 
		 */		
		public function get viewWidth():Number
		{
			return _width;
		}
		
		/**
		 * @return 
		 */		
		public function get viewHeight():Number
		{
			return _height;
		}
		
		/**
		 * Constructor.
		 *
		 * @param width
		 * @param fontSize
		 * @param textUpColor
		 * @param backgroundColor
		 * @param backgroundAlpha
		 * @param cornerRadius
		 * @param padding
		 * @param alpha
		 * @param bold
		 */		
		public function LabelButton( width:Number=0, fontSize:int=15,
									 textUpColor:uint=StyleDict.WHITE,
									 backgroundColor:uint=StyleDict.BLACK,
									 backgroundAlpha:Number=1,cornerRadius:Number=0,
									 padding:Number=1, alpha:Number=1,
									 bold:Boolean=false, font:Font=null )
		{
			super();
			
			this.font = font;
			this.alpha = alpha;
			this.buttonMode = true;
			this.tabEnabled = false;
			
			_label = "";
			_fontSize = fontSize;
			_textColor = textUpColor;
			_backgroundColor = backgroundColor;
			_width = width;
			_bold = bold;
			
			CORNER_RADIUS = cornerRadius;
			PADDING = padding;
			ALPHA = backgroundAlpha;
			
			// listen for events
			addEventListener( MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true );
			addEventListener( MouseEvent.ROLL_OVER, onMouseOver, false, 0, true );
			addEventListener( MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true );
			addEventListener( MouseEvent.ROLL_OUT, onMouseOut, false, 0, true );
			
			invalidate();
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * Initialize and add children to display list.
		 */		
		protected function draw() : void
		{
			// label
			drawLabel();
			
			// calculate size
			_height = text.textHeight;
			if ( _width == 0 )
			{
				_width = text.textWidth;
			}

			// background for hit area
			drawBackground();
			
			swapChildren( text, background );
		}
		
		/**
		 * Add label. 
		 */		
		protected function drawLabel():void
		{
			var debug:Boolean = false;
			
			var tf:TextFormat = new TextFormat();
			if ( font )
			{
				tf.font = font.fontName;
			}
			tf.size = _fontSize;
			tf.align = TextFormatAlign.LEFT;
			tf.color = _textColor;
			
			text = new TextField();
			text.tabEnabled = false;
			text.mouseEnabled = false;
			text.mouseWheelEnabled = false;
			text.selectable = false;
			text.border = debug;
			text.multiline = false;
			text.background = debug;
			text.backgroundColor = StyleDict.GREY1;
			text.borderColor = StyleDict.RED1;
			text.wordWrap = false;
			if ( font )
			{
				text.embedFonts = true;
			}
			text.autoSize = TextFieldAutoSize.LEFT;
			text.defaultTextFormat = tf;
			text.textColor = _textColor;
			text.htmlText = _label;
			addChild( text );
		}
		
		/**
		 * Add background. 
		 */		
		protected function drawBackground():void
		{
			background = new Shape();
			background.graphics.beginFill( _backgroundColor, ALPHA );
			background.graphics.drawRoundRect( 0, 0, _width + PADDING * 2, _height + PADDING * 2,
											   CORNER_RADIUS, CORNER_RADIUS );
			background.graphics.endFill();
			addChild( background );
		}
		
		/**
		 * Position children.
		 */		
		protected function layout() : void
		{
			// text
			text.x = background.width / 2 - text.width / 2;
			text.y = background.height / 2 - text.height / 2;
		}
		
		/**
		 * Destroy and redraw children.
		 */		
		protected function invalidate():void
		{
			// background
			if ( background && contains( background ))
			{
				removeChild( background );
				background = null;
			}
			
			// text
			if ( text && contains( text ))
			{
				removeChild( text );
				text = null;
			}
			
			draw();
			layout();
		}
		
		/**
		 * @param event
		 */		
		protected function onMouseOver( event:MouseEvent ):void
		{
		}
		
		/**
		 * @param event
		 */		
		protected function onMouseOut( event:MouseEvent ):void
		{
		}
		
	}
}