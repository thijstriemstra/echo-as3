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
package com.collab.echo.core
{
	import com.collab.echo.net.Connection;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.emptyArray;
	
	public class ClientManagerTest
	{		
		private var cm		: ClientManager;
		
		[Before]
		public function setUp():void
		{
			cm = new ClientManager( Connection );
		}
		
		[After]
		public function tearDown():void
		{
			cm = null;
		}
		
		[Test(expects="com.collab.echo.errors.UnknownConnectionError")]
		public function test_connectionTypeFail():void
		{
			var cl:Class;
			cm = new ClientManager( cl );
		}
		
		[Test]
		public function testGet_clients():void
		{
			assertThat( cm.clients, emptyArray() );
		}
		
		[Test]
		public function testGet_rooms():void
		{
			assertThat( cm.rooms, emptyArray() );
		}
		
		[Test]
		[Ignore]
		public function testConnect():void
		{
		}
		
		[Test]
		[Ignore]
		public function testDisconnect():void
		{
		}
		
		[Test]
		[Ignore]
		public function testCreateRooms():void
		{
		}
		
		[Test]
		[Ignore]
		public function testNotifyClient():void
		{
		}
		
		[Test]
		[Ignore]
		public function testSubscribeClient():void
		{
		}
		
		[Test]
		[Ignore]
		public function testUnsubscribeClient():void
		{
		}
	}
}