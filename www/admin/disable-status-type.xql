<?xml version="1.0"?>
<queryset>

    <fullquery name="disable_status_type">
        <querytext>
           update recruiting_status_types
              set enabled_p = 'f'
            where status_type_id = :status_type_id
        </querytext>
    </fullquery>

</queryset>
