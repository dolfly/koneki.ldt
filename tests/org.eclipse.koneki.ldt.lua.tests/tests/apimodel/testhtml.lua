-------------------------------------------------------------------------------
-- Copyright (c) 2012 Sierra Wireless and others.
-- All rights reserved. This program and the accompanying materials
-- are made available under the terms of the Eclipse Public License v1.0
-- which accompanies this distribution, and is available at
-- http://www.eclipse.org/legal/epl-v10.html
--
-- Contributors:
--     Sierra Wireless - initial API and implementation
-------------------------------------------------------------------------------
require 'errnode'
local domhandler      = require 'domhandler'
local tablecompare    = require 'tablecompare'
local templateengine  = require 'templateengine'
local xml = require 'xml'
local testutil = require 'testutil'

--
-- Loading template engine environment
--
for key, value in pairs(require 'template.utils') do
	templateengine.env[key] = value
end

local M = {}

function M.test(modelsourcepath, referencepath)

	--
	-- Load provided model
	--
	local inputstring = testutil.loadfile(modelsourcepath)
	
	-- Load model
	local modelfunction = loadstring(inputstring)
	local inputmodel = modelfunction()

	-- Generate html
	local inputhtml = templateengine.applytemplate(inputmodel)
	
	-- Create parser for input html
	local htmltable, errormessage = testutil.parsehtml(inputhtml, "Generated HTML")
	if not htmltable then
		return nil, errormessage
	end
	
	--
	-- Load provided reference
	--
	local referencehtml = testutil.loadfile(referencepath)
	
	-- Parse html from reference
	local htmlreferencetable, errormessage = testutil.parsehtml(referencehtml, referencepath)
	if not htmlreferencetable then
		return nil, errormessage
	end

	-- Check that they are equivalent
	return testutil.comparehtml(htmltable,htmlreferencetable, inputhtml,referencehtml)
end
return M
