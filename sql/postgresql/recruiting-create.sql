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

create table recruiting_status_types (
       -- this is a full fledged acs_object
       status_type_id              integer
                                   constraint recruiting_status_type_fk
                                   references acs_objects(object_id)
                                   constraint recruiting_status_type_pk
                                   primary key,
       package_id                  integer
                                   constraint rc_status_package_id_fk
                                   references apm_packages(package_id)
                                   constraint rc_status_package_id_nn
                                   not null,

       short_desc                  varchar(2000) 
                                   constraint rc_status_short_desc_nn
                                   not null,
       long_desc                   varchar(4000),
       enabled_p                   boolean default 't'
);

select acs_object_type__create_type (
       'recruiting_status_type',
       'Recruiting Status Type',
       'Recruiting Status Types',
       'acs_object',
       'recruiting_status_types',
       'status_type_id',
       'recruiting_status_type',
       'f',
       null,
       'recruiting_status__name'
);

create table recruiting_criteria (
       -- this is a full fledged acs_object
       criteria_id                 integer
                                   constraint recruiting_criteria_fk
                                   references acs_objects(object_id)
                                   constraint recruiting_criteria_pk
                                   primary key,
       package_id                  integer
                                   constraint rc_criteria_package_id_fk
                                   references apm_packages(package_id)
                                   constraint rc_criteria_package_id_nn
                                   not null,

       criteria_name               varchar(2000)
                                   constraint rc_criteria_name_nn
                                   not null,
       description                 varchar(4000),
       enabled_p                   boolean default 't'
);

select acs_object_type__create_type (
       'recruiting_criteria',
       'Recruiting Criteria',
       'Recruiting Criteria',
       'acs_object',
       'recruiting_criteria',
       'criteria_id',
       'recruiting_criteria',
       'f',
       null,
       'recruiting_criteria__name'
);

create table recruiting_candidates_all (
       -- this is a full fledged acs_object
       candidate_id                integer
                                   constraint recruiting_candidate_id_fk
                                   references persons(person_id)
                                   constraint recruiting_candidate_pk
                                   primary key,
       package_id                  integer
                                   constraint rc_package_id_fk
                                   references apm_packages(package_id)
                                   constraint rc_package_id_nn
                                   not null,

       -- address info
       address1                    varchar(2048),
       address2                    varchar(2048),
       city                        varchar(1024),
       state                       varchar(1024),
       zip                         varchar(5),
       zip_plus_four               varchar(4),
       country                     varchar(1024),

       home_phone                  varchar(10),
       cell_phone                  varchar(10),

       email                       varchar(1024),

       status                      integer
                                   constraint recruiting_status_fk
                                   references recruiting_status_types(status_type_id)
                                   constraint recruiting_status_nn
                                   not null,
       archived_p                  boolean default 'f'
);

create view recruiting_candidates as
       select c.candidate_id,
              c.package_id,
              p.first_names as first_name,
              p.last_name,
              c.address1,
              c.address2,
              c.city, c.state,
              c.zip,
              c.zip_plus_four,
              c.country,
              c.home_phone,
              c.cell_phone,
              c.email,
              c.status              
         from recruiting_candidates_all c,
              persons p
        where c.candidate_id = p.person_id
          and c.archived_p = 'f';

create view archived_recruiting_candidates as
       select c.candidate_id,
              c.package_id,
              p.first_names as first_name,
              p.last_name,
              c.address1,
              c.address2,
              c.city, c.state,
              c.zip,
              c.zip_plus_four,
              c.country,
              c.home_phone,
              c.cell_phone,
              c.email,
              c.status              
         from recruiting_candidates_all c,
              persons p
        where c.candidate_id = p.person_id
          and c.archived_p = 't';

select acs_object_type__create_type (
       'recruiting_candidate',
       'Recruiting Candidate',
       'Recruiting Candidates',
       'person',
       'recruiting_candidates',
       'candidate_id',
       'recruiting_candidate',
       'f',
       null,
       'recruiting_candidate__name'
);

create table recruiting_interviews (
       -- this is a full fledged acs_object
       interview_id                integer
                                   constraint recruiting_interviews_id_fk
                                   references acs_objects(object_id)
                                   constraint recruiting_interviews_id_pk
                                   primary key,
       package_id                  integer
                                   constraint rc_interviews_package_id_fk
                                   references apm_packages(package_id)
                                   constraint rc_interviews_package_id_nn
                                   not null,

       interviewer_id              integer 
                                   references users(user_id),
       candidate_id                integer
                                   references recruiting_candidates_all(candidate_id),
       should_hire_p               boolean,
       comment                     varchar(8000)
);

select acs_object_type__create_type (
       'recruiting_interview',
       'Recruiting Interview',
       'Recruiting Interviews',
       'acs_object',
       'recruiting_interview',
       'interview_id',
       'recruiting_interview',
       'f',
       null,
       'recruiting_interview__name'
);

create table recruiting_ratings (
       -- this is a full fledged acs_object
       rating_id                   integer
                                   constraint recruiting_ratings_id_fk
                                   references acs_objects(object_id)
                                   constraint recruiting_ratings_id_pk
                                   primary key,
       package_id                  integer
                                   constraint rc_ratings_package_id_fk
                                   references apm_packages(package_id)
                                   constraint rc_ratings_package_id_nn
                                   not null,

       interview_id                integer
                                   constraint recruiting_rtng_interview_id_fk
                                   references recruiting_interviews(interview_id),
       criteria_id                 integer
                                   constraint recruiting_rtng_criteria_id_fk
                                   references recruiting_criteria(criteria_id),
       rating                      integer
                                   constraint recruiting_rating_range
                                   check (rating between 1 and 5),
       unique (package_id,interview_id,criteria_id)
);

select acs_object_type__create_type (
       'recruiting_rating',
       'Recruiting Rating',
       'Recruiting Ratings',
       'acs_object',
       'recruiting_ratings',
       'rating_id',
       'recruiting_rating',
       'f',
       null,
       'recruiting_rating__name'
);

\i recruiting-api-create.sql
