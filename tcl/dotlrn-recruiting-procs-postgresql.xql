<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="recruiting::status_type::disable.disable_status_type">
        <querytext>
            select recruiting_status_type__disable(:status_type_id)
        </querytext>
    </fullquery>

    <fullquery name="recruiting::status_type::disable.enable_status_type">
        <querytext>
            select recruiting_status_type__enable(:status_type_id)
        </querytext>
    </fullquery>

    <fullquery name="recruiting::status_type::get.get_status_type">
        <querytext>
            select package_id,
                   short_desc,
                   long_desc,
                   enabled_p
              from recruiting_status_types
             where status_type_id = :status_type_id
        </querytext>
    </fullquery>

    <fullquery name="recruiting::status_type::update_status_type.update_status_type">
        <querytext>
            update recruiting_status_types
               set short_desc = :short_desc,
                   long_desc = :long_desc,
                   enabled_p = :enabled_p,
                   package_id = :package_id
             where status_type_id = :status_type_id
        </querytext>
    </fullquery>

    <fullquery name="recruiting::criteria::disable.disable_criteria">
        <querytext>
            select recruiting_criteria__disable(:criteria_id)
        </querytext>
    </fullquery>

    <fullquery name="recruiting::criteria::disable.enable_criteria">
        <querytext>
            select recruiting_criteria__enable(:criteria_id)
        </querytext>
    </fullquery>

    <fullquery name="recruiting::criteria::get.get_criteria">
        <querytext>
            select package_id,
                   criteria_name,
                   description,
                   enabled_p
              from recruiting_criteria
             where criteria_id = :criteria_id
        </querytext>
    </fullquery>

    <fullquery name="recruiting::criteria::update_criteria_type.update_criteria">
        <querytext>
            update recruiting_criteria
               set package_id = :package_id,
                   criteria_name = :criteria_name,
                   description = :description
             where criteria_id = :criteria_id
        </querytext>
    </fullquery>

    <fullquery name="recruiting::candidate::delete.delete_ratings_for_candidate">
        <querytext>
            delete from recruiting_ratings
                  where interview_id = recruiting_interviews.interview_id
                    and recruiting_interviews.candidate_id = :candidate_id
        </querytext>
    </fullquery>
   
    <fullquery name="recruiting::candidate::delete.delete_interviews_for_candidate">
        <querytext>
            delete from recruiting_interviews
                  where candidate_id = :candidate_id
        </querytext>
    </fullquery>
   
    <fullquery name="recruiting::candidate::delete.delete_candidate">
        <querytext>
            delete from recruiting_candidates_all
                  where candidate_id = :candidate_id
        </querytext>
    </fullquery>
   
    <fullquery name="recruiting::candidate::archive.archive_candidate">
        <querytext>
           update recruiting_candidates_all
              set archived_p = 't'
                  where candidate_id = :candidate_id
        </querytext>
    </fullquery>
   
    <fullquery name="recruiting::candidate::unarchive.unarchive_candidate">
        <querytext>
           update recruiting_candidates_all
              set archived_p = 'f'
                  where candidate_id = :candidate_id
        </querytext>
    </fullquery>
   
    <fullquery name="recruiting::candidate::get.get_recruiting_candidate">
        <querytext>
            select package_id,
                   first_name,
                   last_name,
                   address1,
                   address2,
                   city,
                   state,
                   zip,
                   zip_plus_four,
                   city,
                   state,
                   country,
                   home_phone,
                   cell_phone,
                   email,
                   status
              from recruiting_candidates
             where candidate_id = :candidate_id
        </querytext>
    </fullquery>
   
    <fullquery name="recruiting::candidate::update_candidate.update_candidate">
        <querytext>
            update recruiting_candidates_all
               set address1 = :address1,
                   address2 = :address2,
                   city = :city,
                   state = :state,
                   zip = :zip,
                   zip_plus_four = :zip_plus_four,
                   country = :country,
                   home_phone = :home_phone,
                   cell_phone = :cell_phone,
                   email = :email,
                   status = :status
             where candidate_id = :candidate_id
        </querytext>
    </fullquery>

    <fullquery name="recruiting::interview::delete.delete_ratings">
        <querytext>
            delete from recruiting_ratings
                  where interview_id = :interview_id
        </querytext>
    </fullquery>
   
    <fullquery name="recruiting::interview::delete.delete_interview">
        <querytext>
            delete from recruiting_interviews 
                  where interview_id = :interview_id
        </querytext>
    </fullquery>
   
   <fullquery name="recruiting::interview::get.get_interview">
        <querytext>
            select package_id,
                   interviewer_id,
                   candidate_id,
                   should_hire_p,
                   comment
              from recruiting_interviews
             where interview_id = :interview_id
        </querytext>
    </fullquery>
   
   <fullquery name="recruiting::rating::delete.delete_rating">
        <querytext>
            delete from recruiting_ratings
                  where rating_id = :rating_id
        </querytext>
    </fullquery>
   
   <fullquery name="recruiting::rating::get.get_rating">
        <querytext>
            select package_id,
                   interview_id,
                   criteria_id,
                   rating
              from recruiting_ratings
             where rating_id = :rating_id;
        </querytext>
    </fullquery>

</queryset>
