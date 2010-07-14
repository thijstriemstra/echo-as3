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
package com.collab.echo.model.proxy
{
	import com.collab.echo.model.vo.ResourceVO;
	import com.collab.site.v2.ApplicationSettings;
	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
    /**
	 * TODO: remove site import
	 * 
     * A proxy for the startup loading process.
     * 
     * @author Thijs Triemstra
     */
    public class StartupMonitorProxy extends Proxy implements IProxy
    {
    	// ====================================
		// CONSTANTS
		// ====================================
		
		/**
		 * Name of this <code>Proxy</code>. 
		 */		
		public static const NAME				: String = "StartupMonitorProxy";	
		
		// Notifications
		public static const LOADING_STEP		: String	= NAME + "_loadingStep";			
		public static const LOADING_COMPLETE	: String	= NAME + "_loadingComplete";		
	   
	   	// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _resourceList		: Array;														
		private var _loadedResources	: int = 0;															
		
		/**
		 * Constructor.
		 *  
		 * @param data
		 */		
		public function StartupMonitorProxy ( data:Object = null ) 
        {
            super ( NAME, data );
            
			_resourceList = new Array();
        }
		
		// ====================================
		// PUBLIC/PROTECTED METHODS
		// ====================================
		
		/**
         * Add a resource to load.
		 * 
         * @param proxyName proxy name
         * @param blockChain if the load process is stopped until this resource is loaded
         */
		public function addResource( proxyName:String, blockChain:Boolean = false ):void
		{
			_resourceList.push( new ResourceVO( proxyName, blockChain ));
		}
		
		/**
         * Start to read all resources.
         */
		public function loadResources():void
		{
			for ( var i:int = 0; i < _resourceList.length; i++)
			{
				var r:ResourceVO = _resourceList[i] as ResourceVO;
				if ( !r.loaded )
				{
					var proxy:* = facade.retrieveProxy( r.proxyName ) as Proxy;
					proxy.load();
					
					// check if the loading process must be stopped until the resource is loaded
					if ( r.blockChain )
					{
						break;
					}
				}
			}
		}
		
		/**
         * The resource has loaded, update the state and check if the loading
         * process has completed.
		 * 
         * @param proxyName proxy name
         */
		public function resourceComplete( proxyName:String ):void
		{
			for( var i:int = 0; i < _resourceList.length; i++)
			{
				var r:ResourceVO = _resourceList[i] as ResourceVO;
				if ( r.proxyName == proxyName )
				{
					r.loaded = true;
					_loadedResources++;
					
					// send the notification to update the progress bar
					var percentage:int = (_loadedResources * ApplicationSettings.DATA_LOADER_PERCENTAGE) /
										  _resourceList.length;
					sendNotification( LOADING_STEP, percentage + ApplicationSettings.CONTENT_LOADER_PERCENTAGE );
					
					// check if the process is completed
					// if it's not completed and the resources have blocked the process chain
					// continue to read the other resources
					if ( !checkResources() && r.blockChain )
					{
						loadResources();
					}
					break;
				}
			}
		}
	
		// ====================================
		// PRIVATE METHODS
		// ====================================
		
		/**
         * Check if the loading process has completed.
		 * 
         * @return boolean process is completed
         */
		private function checkResources():Boolean
		{
			for ( var i:int = 0; i < _resourceList.length; i++)
			{
				var r:ResourceVO = _resourceList[ i ] as ResourceVO;
				if ( !r.loaded )
				{
					return false;
				}
			}
			
			sendNotification( LOADING_COMPLETE );
			
			return true;
		}
		
	}
}