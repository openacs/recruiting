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

\i recruiting-api-drop.sql

select acs_object_type__drop_type('recruiting_rating', 't');
select acs_object_type__drop_type('recruiting_interview', 't');
select acs_object_type__drop_type('recruiting_candidate', 't');
select acs_object_type__drop_type('recruiting_criteria', 't');
select acs_object_type__drop_type('recruiting_status_type', 't');


drop table recruiting_ratings;
drop table recruiting_interviews;
drop table recruiting_candidates;
drop table recruiting_criteria;
drop table recruiting_status_types;
