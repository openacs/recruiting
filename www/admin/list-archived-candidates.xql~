<?xml version="1.0"?>
<queryset>

    <fullquery name="get_candidates">
        <querytext>
           select c.candidate_id,
                  c.first_name,
                  c.last_name,
                  c.city,
                  c.state,
                  c.email,
                  s.short_desc as status,
                  (select count(*) 
                     from recruiting_interviews i
                    where i.candidate_id = c.candidate_id) as num_interviews,
                  (select count(*) from recruiting_interviews i
                    where i.candidate_id = c.candidate_id
                      and (select count(*) 
                             from recruiting_ratings r
                            where r.interview_id = i.interview_id) != 0) as num_completed_interviews
             from recruiting_candidates c,
                  recruiting_status_types s
            where c.status = s.status_type_id
         order by c.last_name                  
        </querytext>
    </fullquery>

</queryset>
