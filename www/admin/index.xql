<?xml version="1.0"?>
<queryset>

    <fullquery name="status_types_defined_p">
        <querytext>
            select count(*) as status_types_defined_p
              from recruiting_status_types
             where enabled_p = 't';
        </querytext>
    </fullquery>

    <fullquery name="criteria_defined_p">
        <querytext>
            select count(*) as criteria_defined_p
              from recruiting_criteria
             where enabled_p = 't';
        </querytext>
    </fullquery>

    <fullquery name="get_num_candidates">
        <querytext>
             select count(*) as num_candidates
               from recruiting_candidates
        </querytext>
    </fullquery>

    <fullquery name="get_pending_interviews">
        <querytext>
             select count(*) as pending_interviews
               from recruiting_interviews i
              where (select count(*) 
                       from recruiting_ratings r
                      where r.interview_id = i.interview_id) = 0
        </querytext>
    </fullquery>

    <fullquery name="get_num_archived_candidates">
        <querytext>
             select count(*) as num_archived_candidates
               from archived_recruiting_candidates
        </querytext>
    </fullquery>

</queryset>
