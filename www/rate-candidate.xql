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

    <fullquery name="set_should_hire">
        <querytext>
             update recruiting_interviews
                set should_hire_p = :should_hire_p
              where interview_id = :interview_id
        </querytext>
    </fullquery>

</queryset>
