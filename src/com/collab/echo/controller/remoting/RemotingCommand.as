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
package com.collab.echo.controller.remoting
{
	import com.collab.echo.model.business.LoadAMFDelegate;
	import com.collab.echo.model.business.events.LoadAMFEvent;
	import com.collab.echo.model.proxy.ConfigProxy;
	import com.collab.echo.util.StringUtil;
	
	import flash.utils.getQualifiedClassName;
	
	import org.osflash.thunderbolt.Logger;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.AsyncCommand;

	/**
	 * Load data using Flash Remoting (AMF).
	 * 
	 * @author Thijs Triemstra
	 */	
	public class RemotingCommand extends AsyncCommand
	{
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		protected var delegate	: LoadAMFDelegate;
		
		/**
		 * Name of the calling notification that is mapped to this command. 
		 */		
		protected var name 		: String;

		/**
		 * Payload.
		 */		
		protected var data		: Object;
		
		// ====================================
		// PUBLIC/PROTECTED METHODS
		// ====================================
		
		/** 
		 * Execute the business logic.
		 * 
		 * @private
		 * @param note
		 */
		override public function execute ( note:INotification ) : void
		{
			name = note.getName();
			data = note.getBody();
			
			createDelegate();
		}
		
		/**
		 * Cleanup vars.
		 */		
		protected function dispose():void
		{
			delegate = null;
		}
		
		/**
		 * Create delegate.
		 */		
		protected function createDelegate():void
		{
			var config:ConfigProxy = facade.retrieveProxy( ConfigProxy.NAME ) as ConfigProxy;
			var servicePath:String = StringUtil.replace( config.config.servicePath, name );
			var args:Array = [];
			
			if ( data )
			{
				args = data as Array;
			}
			
			delegate = new LoadAMFDelegate( config.config.gateway, servicePath );
			delegate.addEventListener( LoadAMFEvent.LOAD, onLoad );
			delegate.addEventListener( LoadAMFEvent.ERROR, onStatus );
			delegate.addEventListener( LoadAMFEvent.COMPLETE, onResult );
			delegate.load.apply( delegate.load, args );
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * @param event
		 */		
		public function onLoad( event:LoadAMFEvent ):void
		{
		}
		
		/**
		 * @param event
		 */		
		public function onResult( event:LoadAMFEvent ):void
		{
			var msg:String = StringUtil.replace( "%s.%s - result: %s", getQualifiedClassName( this ),
											     name, getQualifiedClassName( event.result ));
			if ( event.result is Array )
			{
				msg += "[" + event.result.length + "]";
			}
			
			Logger.debug( msg );
			dispose();
		}
		
		/**
		 * @param event
		 */		
		public function onStatus( event:LoadAMFEvent ):void
		{
			Logger.error( "====================================================================================================" );
			Logger.error( "Remoting error: " + event.error.code );
			Logger.error( StringUtil.replace( "Call: %s.%s", getQualifiedClassName( this ), name ));
			
			try
			{
				// only visible when gateway debug is True
				Logger.error( "Description: " + event.error.description );
			
				if ( event.error.details.length > 0 )
				{
					var details:String = "Details:\n";
					
					for each ( var str:String in event.error.details )
					{
						details += str;
					}
					
					Logger.error( details );
				}
			}
			catch (e:TypeError){}
			
			dispose();
		}
		
	}
}
