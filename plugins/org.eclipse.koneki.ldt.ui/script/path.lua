--------------------------------------------------------------------------------
-- Copyright (c) 2011 Sierra Wireless and others.
-- All rights reserved. This program and the accompanying materials
-- are made available under the terms of the Eclipse Public License v1.0
-- which accompanies this distribution, and is available at
-- http://www.eclipse.org/legal/epl-v10.html
--
-- Contributors:
--     Sierra Wireless - initial API and implementation
--------------------------------------------------------------------------------

local path = package.path
local parse = true
while parse do
	local last = string.find(path, ";")
	if last == nil then
		parse = false
		last = string.find(path, '?')
		if last == nil then
			print( 'DLTK:' .. path )
		else
			print( 'DLTK:' .. string.sub(path, 1, last - 1) )
		end
	else
		print( 'DLTK:' .. string.sub(path, 1, string.find(path, '?') - 1) )
		path = string.sub(path, last + 1);
	end
end

