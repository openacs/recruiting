<?xml version="1.0"?>
<queryset>

    <fullquery name="get_status_types">
        <querytext>
            select short_desc,
                   long_desc
              from recruiting_status_types
             where enabled_p = 't'
          order by short_desc
        </querytext>
    </fullquery>

</queryset>
