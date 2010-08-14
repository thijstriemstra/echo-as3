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
package com.collab.echo.controls.preloaders
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * Circular, Apple-style, preloader animation.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class CirclePreloader extends Sprite
	{
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var timer		: Timer;
		private var slices		: int;
		private var radius		: int;
		
		/**
		 * Constructor.
		 * 
		 * @param slices
		 * @param radius
		 */		
		public function CirclePreloader( slices:int = 12, radius:int = 6 )
		{
			super();
			
			this.slices = slices;
			this.radius = radius;
			draw();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			timer = new Timer(65);
			timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
			timer.start();
		}
		
		private function onRemovedFromStage(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			timer.reset();
			timer.removeEventListener(TimerEvent.TIMER, onTimer);
			timer = null;
		}
		
		private function onTimer(event:TimerEvent):void
		{
			rotation = (rotation + (360 / slices)) % 360;
		}
		
		// ====================================
		// PRIVATE METHODS
		// ====================================
		
		private function draw():void
		{
			var i:int = slices;
			var degrees:int = 360 / slices;
			while (i--)
			{
				var slice:Shape = getSlice();
				slice.alpha = Math.max(0.2, 1 - (0.1 * i));
				var radianAngle:Number = (degrees * i) * Math.PI / 180;
				slice.rotation = -degrees * i;
				slice.x = Math.sin(radianAngle) * radius;
				slice.y = Math.cos(radianAngle) * radius;
				addChild(slice);
			}
		}
		
		private function getSlice():Shape
		{
			var slice:Shape = new Shape();
			slice.graphics.beginFill(0x666666);
			slice.graphics.drawRoundRect(-1, 0, 2, 6, 12, 12);
			slice.graphics.endFill();
			return slice;
		}
		
	}
}