<?xml version="1.0"?>
<queryset>

   <fullquery name="update_status">
       <querytext>
           update recruiting_candidates
              set status = :status
            where candidate_id = :candidate_id
       </querytext>
   </fullquery>

</queryset>
