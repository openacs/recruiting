<?xml version="1.0"?>
<queryset>

    <fullquery name="get_criteria">
        <querytext>
                select criteria_id,
                       criteria_name,
                       description
                  from recruiting_criteria
                 where package_id = :package_id
                   and enabled_p = 't'        
        </querytext>
    </fullquery>

    <fullquery name="set_should_hire_and_comment">
        <querytext>
             update recruiting_interviews
                set should_hire_p = :should_hire_p,
                    comment = :comment
              where interview_id = :interview_id
        </querytext>
    </fullquery>

    <fullquery name="get_rating">
        <querytext>
            select r.rating
              from recruiting_ratings r
             where criteria_id = :criteria_id
               and interview_id = :interview_id
        </querytext>
    </fullquery>

    <fullquery name="remove_old_ratings">
        <querytext>
            delete 
              from recruiting_ratings
             where interview_id = :interview_id
        </querytext>
    </fullquery>

</queryset>
