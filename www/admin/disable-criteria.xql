<?xml version="1.0"?>
<queryset>

    <fullquery name="disable_criteria">
        <querytext>
           update recruiting_criteria
              set enabled_p = 'f'
            where criteria_id = :criteria_id
        </querytext>
    </fullquery>

</queryset>
