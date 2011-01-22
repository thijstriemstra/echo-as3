/*
Echo project.

Copyright (C) 2011 Collab

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
package com.collab.echo.net
{
	import com.collab.echo.core.rooms.BaseRoom;
	import com.collab.echo.events.BaseConnectionEvent;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;
	
	public class ConnectionTest
	{	
		private var host	: String = "localhost";
		private var port	: int = 80;
		private var conn	: Connection;
		
		[Before]
		public function setUp():void
		{
			conn = new Connection( host, port );
		}
		
		[After]
		public function tearDown():void
		{
			conn = null;
		}
		
		[Test( async )]
		public function testConnect():void
		{
			conn.addEventListener( BaseConnectionEvent.CONNECTING, 
				Async.asyncHandler( this, null, 100, null,
									handleEventNeverOccurred ), 
									false, 0, true );
			conn.connect();
		}
		
		protected function handleEventNeverOccurred( passThroughData:Object ):void
		{
			Assert.fail( 'Pending Event Never Occurred' );
		}
		
		[Test(expects="TypeError")]
		public function testConnection_host():void
		{
			conn = new Connection( null, port );
		}
		
		[Test(expects="TypeError")]
		public function testConnection_port():void
		{
			conn = new Connection( host, 0 );
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function testParseUser():void
		{
			conn.parseUser( null );
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function testAddServerMessageListener():void
		{
			conn.addServerMessageListener( null, null );
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function testRemoveServerMessageListener():void
		{
			conn.removeServerMessageListener( null, null );
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function testSendServerMessage():void
		{
			conn.sendServerMessage( null );
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function testCreateRoom():void
		{
			conn.createRoom( null, null, null, null );
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function testCreateRooms():void
		{
			conn.createRooms( new Vector.<BaseRoom>() );
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function testGetAttributeForClients():void
		{
			conn.getAttributeForClients( null, null, null );
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function testGetClientByAttribute():void
		{
			conn.getClientByAttribute( null, null );
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function testGetClientById():void
		{
			conn.getClientById( null );
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function testGetIPByUserName():void
		{
			conn.getIPByUserName( null );
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function testWatchRooms():void
		{
			conn.watchRooms();
		}
		
		[Test]
		public function testGet_logging():void
		{
			assertThat( conn.logging, equalTo( true ));
		}
		
		[Test]
		public function testGet_logLevel():void
		{
			assertThat( conn.logLevel, equalTo( "info" ));
		}
		
		[Test]
		public function testGet_port():void
		{
			assertThat( conn.port, equalTo( port ));
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function testGet_self():void
		{
			assertThat( conn.self, nullValue() );
		}
		
		[Test]
		public function testGet_connected():void
		{
			assertThat( conn.connected, equalTo( false ));
		}
		
		[Test]
		public function testGet_url():void
		{
			assertThat( conn.url, equalTo( host ));
		}
		
	}
}