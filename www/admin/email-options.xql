<?xml version="1.0"?>
<queryset>

   <fullquery name="default_email_defined_p">
       <querytext>
            select count(*)
              from recruiting_assignment_emails
             where package_id = :package_id
       </querytext>
    </fullquery>

   <fullquery name="get_this_package_email">
       <querytext>
            select email_body
              from recruiting_assignment_emails
             where package_id = :package_id
       </querytext>
    </fullquery>

   <fullquery name="get_default_email">
       <querytext>
            select email_body
              from recruiting_assignment_emails
             where package_id is null
       </querytext>
    </fullquery>

   <fullquery name="set_default_email">
       <querytext>
            update recruiting_assignment_emails
               set email_body = :default_email
             where package_id = :package_id
       </querytext>
    </fullquery>

   <fullquery name="new_default_email">
       <querytext>
                insert into recruiting_assignment_emails
                           (package_id,
                            email_body)
                    values (:package_id,
                            :default_email);
       </querytext>
    </fullquery>

</queryset>
