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
package com.collab.echo.core.rooms
{
	import com.collab.cabin.util.ClassUtils;
	import com.collab.cabin.util.StringUtil;
	import com.collab.echo.net.Connection;
	
	import flash.utils.Dictionary;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.core.isA;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.nullValue;

	public class BaseRoomTest
	{		
		private var room	: BaseRoom;
		private var id		: String = "test";
		
		[Before]
		public function setUp():void
		{
			room = new BaseRoom( id );
		}
		
		[After]
		public function tearDown():void
		{
			room = null;
		}
		
		[Test]
		public function testGet_connection():void
		{
			assertThat( room.connection, nullValue() );
		}
		
		[Test]
		public function testSet_connection():void
		{
			var conn:Connection = new Connection("localhost", 80);
			room.connection = conn;
			
			assertThat( room.connection, equalTo( conn ));
		}
		
		[Test]
		public function testGet_data():void
		{
			assertThat( room.data, nullValue() );
		}
		
		[Test]
		public function testSet_data():void
		{
			var foo:Object = {test:123};
			room.data = foo;
			
			assertThat( room.data, equalTo( foo ));
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function testGetAttributeForClients():void
		{
			room.getAttributeForClients( [], null );
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function testGetClientByAttribute():void
		{
			room.getClientByAttribute( "foo", "bar" );
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function testGetClientById():void
		{
			room.getClientById( "foo" );
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function testGetClientId():void
		{
			room.getClientId();
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function testGetClientIdByUsername():void
		{
			room.getClientIdByUsername( "foo" );
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function testGetIPByUserName():void
		{
			room.getIPByUserName( "foo" );
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function testGetOccupantIDs():void
		{
			room.getOccupantIDs();
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function testGetOccupants():void
		{
			room.getOccupants();
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function testParseUser():void
		{
			room.parseUser( null );
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function testSendMessage():void
		{
			room.sendMessage( null, null );
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function testSetAttribute():void
		{
			room.setAttribute( null, null );
		}
		
		[Test]
		public function testJoin():void
		{
			room.join();
		}

		[Test]
		public function testLeave():void
		{
			room.leave();
		}
		
		[Test]
		public function testConnect():void
		{
			var conn:Connection = new Connection("localhost", 80);
			room.connect( conn );
			
			assertThat( room.connection, equalTo( conn ));
		}
		
		[Test]
		public function testDisconnect():void
		{
			var conn:Connection = new Connection("localhost", 80);
			room.connect( conn );
			room.disconnect();
			
			assertThat( room.connection, nullValue() );
		}
		
		protected function foobar():void {}
		
		[Test]
		public function testAddMessageListener():void
		{
			room.addMessageListener( "foo", foobar );
			
			assertThat( room.listeners["foo"], equalTo( foobar ));
		}
		
		[Test]
		[Ignore]
		public function testHasMessageListener():void
		{
		}
		
		[Test]
		public function testRemoveMessageListener():void
		{
			room.addMessageListener( "foo", foobar );
			assertThat( room.listeners["foo"], equalTo( foobar ));
			
			room.removeMessageListener( "foo", foobar );
			assertThat( room.listeners["foo"], nullValue() );
		}
		
		[Test]
		public function testGet_listeners():void
		{
			assertThat( room.listeners, isA( Dictionary ));
			assertThat( room.listeners, notNullValue() );
		}
		
		[Test]
		public function testGet_id():void
		{
			assertThat( room.id, equalTo( id ));
		}
		
		[Test]
		public function testGet_joined():void
		{
			assertThat( room.joined, equalTo( false ));
		}
		
		[Test]
		public function testGet_autoJoin():void
		{
			assertThat( room.autoJoin, equalTo( false ));
		}
		
		[Test]
		public function testGet_watch():void
		{
			assertThat( room.watch, equalTo( true ));
		}
		
		[Test]
		public function testGet_self():void
		{
			assertThat( room.self, nullValue() );
		}
		
		[Test]
		public function testToString():void
		{
			var msg:String = StringUtil.replace( "<BaseRoom id='%s' />", id );
			
			assertThat( room.toString(), equalTo( msg ));
		}
	}
}