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

select define_function_args('recruiting_status_type__new','status_type_id,package_id,short_desc,long_desc,enabled_p,creation_user,creation_ip');

create function recruiting_status_type__new(integer,integer,varchar,varchar,boolean,integer,varchar)
returns integer as'
declare
  p_status_type_id              alias for $1;
  p_package_id                  alias for $2;
  p_short_desc                  alias for $3;
  p_long_desc                   alias for $4;
  p_enabled_p                   alias for $5;
  p_creation_user               alias for $6;
  p_creation_ip                 alias for $7;
  v_status_type_id              integer;
begin

  v_status_type_id := acs_object__new(
                   p_status_type_id,
                   ''recruiting_status_type'',
                   now(),
                   p_creation_user,
                   p_creation_ip,
                   p_package_id);

   insert into recruiting_status_types
              (status_type_id,
               package_id,
               short_desc,
               long_desc,
               enabled_p)
        values(v_status_type_id,
               p_package_id,
               p_short_desc,
               p_long_desc,
               p_enabled_p);

   return v_status_type_id;

end;' language 'plpgsql';

select define_function_args('recruiting_status_type__disable','status_type_id');
create function recruiting_status_type__disable(integer)
returns integer as '
declare
  p_status_type_id      alias for $1;
begin

  update recruiting_status_types set enabled_p=''f'' where status_type_id = p_status_type_id;
  
  return 1;

end;' language 'plpgsql';

select define_function_args('recruiting_status_type__enable','status_type_id');
create function recruiting_status_type__enable(integer)
returns integer as '
declare
  p_status_type_id      alias for $1;
begin

  update recruiting_status_types set enabled_p=''t'' where status_type_id = p_status_type_id;
  
  return 1;

end;' language 'plpgsql';

select define_function_args('recruiting_status_type__name','message_id');
create function recruiting_status_type__name(integer)
returns varchar as '
declare
  p_message_id          alias for $1;
begin

  return short_desc 
    from recruiting_status_types 
   where status_type_id = p_status_type_id;

end;' language 'plpgsql';


select define_function_args('recruiting_criteria__new','criteria_id,package_id,criteria_name,description,enabled_p,creation_user,creation_ip');
create function recruiting_criteria__new(integer,integer,varchar,varchar,boolean,integer,varchar)
returns integer as '
declare
  p_criteria_id         alias for $1;
  p_package_id          alias for $2;
  p_criteria_name       alias for $3;
  p_description         alias for $4;
  p_enabled_p           alias for $5;
  p_creation_user       alias for $6;
  p_creation_ip         alias for $7;
  v_criteria_id         integer;
begin

  v_criteria_id := acs_object__new(
                p_criteria_id,
                ''recruiting_criteria'',
                now(),
                p_creation_user,
                p_creation_ip,
                p_package_id);

  insert into recruiting_criteria
              (criteria_id,
               package_id,
               criteria_name,
               description,
               enabled_p)
        values(v_criteria_id,
               p_package_id,
               p_criteria_name,
               p_description,
               p_enabled_p);

  return v_criteria_id;

end;' language 'plpgsql';

select define_function_args('recruiting_criteria__disable','criteria_id');
create function recruiting_criteria__disable(integer)
returns integer as '
declare
  p_criteria_id         alias for $1;
begin

  update recruiting_criteria set enabled_p=''f'' where criteria_id = p_criteria_id;

  return 1;

end;' language 'plpgsql';

select define_function_args('recruiting_criteria__enable','criteria_id');
create function recruiting_criteria__enable(integer)
returns integer as '
declare
  p_criteria_id         alias for $1;
begin

  update recruiting_criteria set enabled_p=''t'' where criteria_id = p_criteria_id;

  return 1;

end;' language 'plpgsql';

select define_function_args('recruiting_criteria__name','criteria_id');
create function recruiting_criteria__name(integer)
returns integer as '
declare
  p_criteria_id         alias for $1;
begin

        return criteria_name 
          from recruiting_criteria
         where criteria_id = p_criteria_id;

end;' language 'plpgsql';

select define_function_args('recruiting_candidate__new','candidate_id,package_id,first_name,last_name,address1,address2,city,state,zip,zip_plus_four,country,home_phone,cell_phone,email,status,creation_user,creation_ip');
create function recruiting_candidate__new(integer,integer,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,integer,integer,varchar)
returns integer as '
declare
  p_candidate_id        alias for $1;
  p_package_id          alias for $2;
  p_first_name          alias for $3;
  p_last_name           alias for $4;
  p_address1            alias for $5;
  p_address2            alias for $6;
  p_city                alias for $7;
  p_state               alias for $8;
  p_zip                 alias for $9;
  p_zip_plus_four       alias for $10;
  p_country             alias for $11;
  p_home_phone          alias for $12;
  p_cell_phone          alias for $13;
  p_email               alias for $14;
  p_status              alias for $15;
  p_creation_user       alias for $16;
  p_creation_ip         alias for $17;
  v_candidate_id        integer;
begin

  v_candidate_id := acs_object__new(
                 p_candidate_id,
                 ''recruiting_candidate'',
                 now(),
                 p_creation_user,
                 p_creation_ip,
                 p_package_id);

   insert into recruiting_candidates
              (candidate_id,
               package_id,
               first_name,
               last_name,
               address1,
               address2,
               city,
               state,
               zip,
               zip_plus_four,
               country,
               home_phone,
               cell_phone,
               email,
               status)
        values(v_candidate_id,
               p_package_id,
               p_first_name,
               p_last_name,
               p_address1,
               p_address2,
               p_city,
               p_state,
               p_zip,
               p_zip_plus_four,
               p_country,
               p_home_phone,
               p_cell_phone,
               p_email,
               p_status);

  return v_candidate_id;

end;' language 'plpgsql';

select define_function_args('recruiting_candidate__delete','candidate_id');
create function recruiting_candidate__delete(integer)
returns integer as '
declare 
  p_candidate_id        alias for $1;
begin

  delete from recruiting_candidates where candidate_id = p_candidate_id;

  perform acs_object__delete(p_candidate_id);

  return 1;

end;' language 'plpgsql';

select define_function_args('recruiting_candidate__name','candidate_id');
create function recruiting_candidate__name(integer)
returns varchar as '
declare
  p_candidate_id        alias for $1;
  v_desc                varchar;
begin

  v_desc := select last_name||'', ''||first_name from recruiting_candidates 
             where candidate_id = p_candidate_id;

  return v_desc

end;' language 'plpgsql';

select define_function_args('recruiting_interview__new','interview_id,package_id,interviewer_id,candidate_id,creation_user,creation_ip');
create function recruiting_interview__new(integer,integer,integer,integer,integer,varchar)
returns integer as '
declare
  p_interview_id        alias for $1;
  p_package_id          alias for $2;
  p_interviewer_id      alias for $3;
  p_candidate_id        alias for $4;
  p_creation_user       alias for $5;
  p_creation_ip         alias for $6;
  v_interview_id        integer;

begin

  v_interview_id := acs_object__new(
                 p_interview_id,
                 ''recruiting_interview'',
                 now(),
                 p_creation_user,
                 p_creation_ip,
                 p_package_id);

  insert into recruiting_interviews
             (interview_id,
              package_id,
              interviewer_id,   
              candidate_id)
       values(v_interview_id,
              p_package_id,
              p_interviewer_id,
              p_candidate_id);

  return v_interview_id;

end;' language 'plpgsql';

select define_function_args('recruiting_interview__delete','interview_id');
create function recruiting_interview__delete(integer)
returns integer as '
declare
  p_interview_id        alias for $1;
begin

  delete from recruiting_interviews where interview_id = p_interview_id;

  perform acs_object__delete(p_interview_id);

  return 1;

end;' language 'plpgsql';

select define_function_args('recruiting_interview_name','interview_id');
create function recruiting_interview__name(integer)
returns varchar as '
declare
  p_interview_id        alias for $1;
  v_desc                varchar;
begin

  v_desc := select u.last_name||'', ''||u.first_name||''''''s interview of ''||c.last_name||'', ''||c.first_name
              from users u,
                   recruiting_candidates c
             where recruiting_interviews.interview_id = p_interview_id
               and recruiting_interviews.interviewer_id = u.user_id
               and recruiting_interviews.candidate_id = c.candidate_id;

  return v_desc;

end;' language 'plpgsql';

select define_function_args('recruiting_rating__new','rating_id,package_id,interview_id,criteria_id,rating,creation_user,creation_ip');
create function recruiting_rating__new(integer,integer,integer,integer,integer,integer,varchar)
returns integer as '
declare
  p_rating_id           alias for $1;
  p_package_id          alias for $2;
  p_interview_id        alias for $3;
  p_criteria_id         alias for $4;
  p_rating              alias for $5;
  p_creation_user       alias for $6;
  p_creation_ip         alias for $7;
  v_rating_id           integer;
begin

  v_rating_id := acs_object__new(
              p_rating_id,
              ''recruiting_rating'',
              now(),
              p_creation_user,
              p_creation_ip,
              p_package_id);

  insert into recruiting_ratings
             (rating_id,
              package_id,
              interview_id,
              criteria_id,      
              rating)
       values(v_rating_id,
              p_package_id,
              p_interview_id,
              p_criteria_id,
              p_rating);

  return v_rating_id;

end;' language 'plpgsql';

select define_function_args('recruiting_rating__delete','rating_id');
create function recruiting_rating__delete(integer)
returns integer as '
declare
  p_rating_id           alias for $1;
begin

  delete from recruiting_ratings where rating_id = p_rating_id;

  perform acs_object__delete(p_rating_id);

  return 1;

end;' language 'plpgsql';

select define_function_args('recruiting_rating__name','rating_id');
create function recruiting_rating__name(integer)
returns varchar as '
declare
  p_rating_id   alias for $1;
  v_desc        varchar
begin

  v_desc := select u.last_name||'', ''||u.first_name||''''''s ''||rc.criteria_name||'' rating of ''||c.last_name||'', ''||c.first_name
              from users u,
                   recruiting_candidates c,
                   recruiting_criteria rc,
             where recruiting_ratings.rating_id = p_rating_id
               and recruiting_ratings.interview_id = recruiting_interviews.interview_id
               and recruiting_interviews.interviewer_id = u.user_id
               and recruiting_interviews.candidate_id = c.candidate_id;

  return v_desc;

end;' language 'plpgsql';
