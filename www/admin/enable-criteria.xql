<?xml version="1.0"?>
<queryset>

    <fullquery name="enable_criteria">
        <querytext>
           update recruiting_criteria
              set enabled_p = 't'
            where criteria_id = :criteria_id
        </querytext>
    </fullquery>

</queryset>
