ad_page_contract {
    recruiting admin interface
    new candidate page

    @author chak (chak@openforce.net)
    @creation-date 2002-07-30
    @version $Id$
}

set package_id [ad_conn package_id]
set user_id [ad_verify_and_get_user_id]

# check if there are status types defined.  if not,
# don't let any candidates be created (what would their
# status type be)?

set status_type_count [db_string get_status_type_count {}]

form create new_candidate
element create new_candidate first_name \
        -label "First Name:" \
        -datatype text \
        -widget text \
        -html {size 30}

element create new_candidate last_name \
        -label "Last Name:" \
        -datatype text \
        -widget text \
        -html {size 30}

element create new_candidate address1 \
        -label "Address 1:" \
        -datatype text \
        -widget text \
        -html {size 30}

element create new_candidate address2 \
        -label "Address 2:" \
        -datatype text \
        -widget text \
        -html {size 30} \
        -optional

element create new_candidate city \
        -label "City:" \
        -datatype text \
        -widget text \
        -html {size 30}

element create new_candidate state \
        -label "State:" \
        -datatype text \
        -widget text \
        -html {size 2}

element create new_candidate zip \
        -label "Zip:" \
        -datatype text \
        -widget text \
        -html {size 5} \
        -optional

element create new_candidate zip_plus_four \
        -label {Zip Plus 4:} \
        -datatype text \
        -widget text \
        -html {size 4} \
        -optional

element create new_candidate country \
        -label "Country:" \
        -datatype text \
        -widget text \
        -html {size 30}

element create new_candidate email \
        -label "Email:" \
        -datatype text \
        -widget text \
        -html {size 30}

element create new_candidate status \
        -label "Status:" \
        -datatype integer \
        -widget select \
        -options [db_list_of_lists get_status_types "select short_desc,status_type_id from recruiting_status_types where enabled_p='t' order by short_desc"] \

if {[form is_valid new_candidate]} {
    form get_values new_candidate \
            first_name last_name \
            address1 address2 city state zip zip_plus_four country \
            email status    
    
    recruiting_candidate::new \
            -first_name $first_name \
            -last_name $last_name \
            -address1 $address1 \
            -address2 $address2 \
            -city $city \
            -state $state \
            -zip $zip \
            -zip_plus_four $zip_plus_four \
            -country $country \
            -email $email \
            -status $status
    
    ad_returnredirect list-candidates
    ad_script_abort
}

ad_return_template
