<?xml version="1.0"?>
<queryset>

    <fullquery name="enable_status_type">
        <querytext>
           update recruiting_status_types
              set enabled_p = 't'
            where status_type_id = :status_type_id
        </querytext>
    </fullquery>

</queryset>
