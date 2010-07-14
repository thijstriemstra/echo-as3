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
package com.collab.echo.controller
{
    import com.collab.echo.model.proxy.ConfigProxy;
    import com.collab.echo.model.proxy.LocaleProxy;
    import com.collab.echo.model.proxy.StartupMonitorProxy;
    
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
    
    /**
     * Create and register <code>Proxy</code>s with the <code>Model</code>.
     *  
     * @author Thijs Triemstra
     */    
    public class ModelPrepCommand extends SimpleCommand
    {
        override public function execute( note:INotification ) :void    
		{
            facade.registerProxy( new StartupMonitorProxy() );
            facade.registerProxy( new ConfigProxy() );
            facade.registerProxy( new LocaleProxy() );
        }
		
    }
}