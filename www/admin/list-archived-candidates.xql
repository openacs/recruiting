<?xml version="1.0"?>
<queryset>

    <fullquery name="get_archived_candidates">
        <querytext>
           select c.candidate_id,
                  c.last_name||', '||c.first_name as candidate_name,
                  c.city,
                  c.state,
                  c.email,
                  s.short_desc as status
             from archived_recruiting_candidates c,
                  recruiting_status_types s
            where c.status = s.status_type_id
         order by c.last_name
        </querytext>
    </fullquery>

</queryset>
