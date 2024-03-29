--
--  Copyright (C) 2002 OpenForce, Inc.
--
--  This file is part of dotLRN.
--
--  dotLRN is free software; you can redistribute it and/or modify it under the
--  terms of the GNU General Public License as published by the Free Software
--  Foundation; either version 2 of the License, or (at your option) any later
--  version.
--
--  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
--  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
--  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
--  details.
--

--
-- The DotLRN Recruiting system
-- copyright 2002, OpenForce, Inc.
-- distributed under the GNU GPL v2
--
-- for PG 7.1.3 and above
--
-- @author chak (chak@openforce.net)
-- @creation-date 2002-07-27
-- @version $Id$

select drop_package('recruiting_rating');
select drop_package('recruiting_interview');
select drop_package('recruiting_candidate');
select drop_package('recruiting_criteria');
select drop_package('recruiting_status_type');


