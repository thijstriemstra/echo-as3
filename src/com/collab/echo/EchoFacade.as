/*
Collab.nl application

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
package com.collab.echo
{
    import flash.net.SharedObject;
    
    import org.puremvc.as3.multicore.patterns.facade.Facade;

    /**
     * A concrete <code>Facade</code> for the <code>Echo</code> framework.
     * 
     * @author Thijs Triemstra
     */
    public class EchoFacade extends Facade
    {
    	// ====================================
		// CONSTANTS
		// ====================================

		/**
		 * Application name.
		 */    	
		public static const NAME									: String = "Echo";
				
        // general
        public static const STARTUP									: String = "startup";
	 	public static const LOG_OUTPUT								: String = "logOutput";
		
		/**
		 * Local shared object.
		 * 
		 * XXX: refactor with LocalData
		 */		
		public static var userCookie								: SharedObject = SharedObject.getLocal( NAME );
		
		/**
		 * Constructor.
		 *  
		 * @param key
		 */		
		public function EchoFacade( key:String )
        {
            super( key );    
        }
		
		// ====================================
		// PUBLIC/PROTECTED METHODS
		// ====================================
		
		/**
		 * Singleton <code>ApplicationFacade</code> Factory method.
		 *  
		 * @param key
		 * @return Instance of <code>ApplicationFacade</code>
		 */		
        public static function getInstance( key:String ) : EchoFacade
        {
            if ( instanceMap[ key ] == null )
            {
            	instanceMap[ key ]  = new EchoFacade( key );
            }
            
            return instanceMap[ key ] as EchoFacade;
        }

    }
}