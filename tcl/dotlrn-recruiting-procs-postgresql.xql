<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="recruiting_status_type::disable.disable_status_type">
        <querytext>
            select recruiting_status_type__disable(:status_type_id);
        </querytext>
    </fullquery>

    <fullquery name="recruiting_status_type::disable.enable_status_type">
        <querytext>
            select recruiting_status_type__enable(:status_type_id);
        </querytext>
    </fullquery>

    <fullquery name="recruiting_status_type::get.get_status_type">
        <querytext>
            select package_id,
                   short_desc,
                   long_desc,
                   enabled_p
              from recruiting_status_types
             where status_type_id = :status_type_id;
        </querytext>
    </fullquery>

    <fullquery name="recruiting_criteria::disable.disable_criteria">
        <querytext>
            select recruiting_criteria__disable(:criteria_id);
        </querytext>
    </fullquery>

    <fullquery name="recruiting_criteria::disable.enable_criteria">
        <querytext>
            select recruiting_criteria__enable(:criteria_id);
        </querytext>
    </fullquery>

    <fullquery name="recruiting_criteria::get.get_criteria">
        <querytext>
            select package_id,
                   criteria_name,
                   description,
                   enabled_p
              from recruiting_criteria
             where criteria_id = :criteria_id;
        </querytext>
    </fullquery>

    <fullquery name="recruiting_candidate::delete.delete_ratings_for_candidate">
        <querytext>
            delete from recruiting_ratings rr
                  where rr.interview_id = recruiting_interviews.interview_id
                    and recruiting_interviews.candidate_id = :candidate_id;
        </querytext>
    </fullquery>
   
    <fullquery name="recruiting_candidate::delete.delete_interviews_for_candidate">
        <querytext>
            delete from recruiting_interviews
                  where candidate_id = :candidate_id;
        </querytext>
    </fullquery>
   
    <fullquery name="recruiting_candidate::delete.delete_candidate">
        <querytext>
            delete from recruiting_candidates
                  where candidate_id = :candidate_id;
        </querytext>
    </fullquery>
   
    <fullquery name="recruiting_candidate::get.get_recruiting_candidate">
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
                   email,
                   status
              from recruiting_candidates
             where candidate_id = :candidate_id;
        </querytext>
    </fullquery>
   
    <fullquery name="recruiting_interview::delete.delete_ratings">
        <querytext>
            delete from recruiting_ratings
                  where interview_id = :interview_id;
        </querytext>
    </fullquery>
   
    <fullquery name="recruiting_interview::delete.delete_interview">
        <querytext>
            delete from recruiting_interviews 
                  where interview_id = :interview_id;
        </querytext>
    </fullquery>
   
   <fullquery name="recruiting_interview::get.get_interview">
        <querytext>
            select package_id,
                   interviewer_id,
                   candidate_id
              from recruiting_interviews
             where interview_id = :interview_id;
        </querytext>
    </fullquery>
   
   <fullquery name="recruiting_rating::delete.delete_rating">
        <querytext>
            delete from recruiting_ratings
                  where rating_id = :rating_id;
        </querytext>
    </fullquery>
   
   <fullquery name="recruiting_rating::get.get_rating">
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
