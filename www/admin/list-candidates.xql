<?xml version="1.0"?>
<queryset>

    <fullquery name="get_candidates">
        <querytext>
           select c.first_name,
                  c.last_name,
                  c.city,
                  c.state,
                  c.email,
                  s.short_desc as status
             from recruiting_candidates c,
                  recruiting_status_types s
            where c.status = s.status_type_id
         order by c.last_name                  
        </querytext>
    </fullquery>

</queryset>
