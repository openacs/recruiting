<?xml version="1.0"?>
<queryset>

    <fullquery name="get_enabled_criteria_types">
        <querytext>
            select criteria_id,
                   criteria_name,
                   '' as disable_url 
              from recruiting_criteria
             where enabled_p = 't'
          order by criteria_name
        </querytext>
    </fullquery>

    <fullquery name="get_disabled_criteria_types">
        <querytext>
            select criteria_id,
                   criteria_name,
                   '' as enable_url 
              from recruiting_criteria
             where enabled_p = 'f'
          order by criteria_name
        </querytext>
    </fullquery>

    <fullquery name="enable_criteria">
        <querytext>
           update recruiting_criteria
              set enabled_p = 't'
            where criteria_id = :criteria_id
        </querytext>
    </fullquery>

    <fullquery name="disable_criteria">
        <querytext>
           update recruiting_criteria
              set enabled_p = 'f'
            where criteria_id = :criteria_id
        </querytext>
    </fullquery>

</queryset>
