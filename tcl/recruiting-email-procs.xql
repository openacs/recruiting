<?xml version="1.0"?>
<queryset>

   <fullquery name="recruiting::email::get_body.default_email_defined_p">
       <querytext>
            select count(*)
              from recruiting_assignment_emails
             where package_id = :package_id
       </querytext>
    </fullquery>

   <fullquery name="recruiting::email::get_body.get_this_package_email">
       <querytext>
            select email_body
              from recruiting_assignment_emails
             where package_id = :package_id
       </querytext>
    </fullquery>

   <fullquery name="recruiting::email::get_body.get_default_email">
       <querytext>
            select email_body
              from recruiting_assignment_emails
             where package_id is null
       </querytext>
    </fullquery>

   <fullquery name="recruiting::email::set_email.default_email_defined_p">
       <querytext>
            select count(*)
              from recruiting_assignment_emails
             where package_id = :package_id
       </querytext>
    </fullquery>

   <fullquery name="recruiting::email::set_email.set_default_email">
       <querytext>
            update recruiting_assignment_emails
               set email_body = :email_body
             where package_id = :package_id
       </querytext>
    </fullquery>

   <fullquery name="recruiting::email::set_email.new_default_email">
       <querytext>
                insert into recruiting_assignment_emails
                           (package_id,
                            email_body)
                    values (:package_id,
                            :email_body);
       </querytext>
    </fullquery>

</queryset>
