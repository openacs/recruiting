<?xml version="1.0"?>
<queryset>

    <fullquery name="get_enabled_status_types">
        <querytext>
           select status_type_id,
                  short_desc,
                  '' as disable_url 
             from recruiting_status_types 
            where enabled_p = 't'
         order by short_desc
        </querytext>
    </fullquery>

    <fullquery name="get_disabled_status_types">
        <querytext>
           select status_type_id,
                  short_desc,
                  '' as enable_url 
             from recruiting_status_types 
            where enabled_p = 'f'
         order by short_desc
        </querytext>
    </fullquery>

</queryset>
