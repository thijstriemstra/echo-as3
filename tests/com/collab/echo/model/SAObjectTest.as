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
package com.collab.echo.model
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.nullValue;
	
	public class SAObjectTest
	{	
		private var dummy	: SAObject;
		
		[Before]
		public function setUp():void
		{
			dummy = new SAObject();
		}
		
		[After]
		public function tearDown():void
		{
			dummy = null;
		}
		
		[Test]
		public function testSAObject():void
		{
			assertThat( dummy.sa_key, nullValue() );
			assertThat( dummy.sa_lazy, nullValue() );
		}
	}
}