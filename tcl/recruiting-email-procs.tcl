namespace eval recruiting {
    namespace eval email {
        
        ad_proc -public get_body {
            {-package_id:required}
        } {
            return the email body that gets sent to 
            interviewers for this package
        } {
            set default_email_defined_p [db_string default_email_defined_p {}]

            if {$default_email_defined_p} {
                set default_email [db_string get_this_package_email {}]
            } else {
                set default_email [db_string get_default_email {}]
            }

            return $default_email

        }

        ad_proc -public set_email {
            {-package_id:required}
            {-email_body:required}
        } {
            set the email that gets sent to 
            interviewers for this package
        } {
            set default_email_defined_p [db_string default_email_defined_p {}]

            if {$default_email_defined_p} {
                db_dml set_default_email {}
            } else {
                db_dml new_default_email {}
            }
        }

    }
}
