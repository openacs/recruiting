#
#  Copyright (C) 2002 OpenForce, Inc.
#
#  This file is part of dotLRN.
#
#  dotLRN is free software; you can redistribute it and/or modify it under the
#  terms of the GNU General Public License as published by the Free Software
#  Foundation; either version 2 of the License, or (at your option) any later
#  version.
#
#  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#  details.
#

#
# The DotLRN Recruiting system
# copyright 2002, OpenForce, Inc.
# distributed under the GNU GPL v2
#
# for PG 7.1.3 and above
#
# @author chak (chak@openforce.net)
# @creation-date 2002-07-30
# @version $Id$

namespace eval recruiting_status_type {

    ad_proc -public new {
        {-package_id ""}
        {-short_desc:required}
        {-long_desc:required}
        {-enabled_p "t"}
    } {
        create a new status type
    } {
        if {[empty_string_p $package_id]} {
            set package_id [ad_conn package_id]
        }
        
        set extra_vars [ns_set create]
        ns_set put $extra_vars package_id $package_id
        ns_set put $extra_vars short_desc $short_desc
        ns_set put $extra_vars long_desc $long_desc
        ns_set put $extra_vars enabled_p $enabled_p

        set object_type recruiting_status_type

        return [package_instantiate_object -extra_vars $extra_vars $object_type]

    }

    ad_proc -public disable {
        {-status_type_id:required}
    } {
        delete a recruiting status type
    } {
        db_dml disable_status_type {}
    }

    ad_proc -public enable {
        {-status_type_id:required}
    } {
        delete a recruiting status type
    } {
        db_dml enable_status_type {}
    }

    ad_proc -public get {
        {-status_type_id:required}
    } {
        get a status type
    } {
        db_1row get_status_type {}
        
        set status_type(status_type_id) $status_type_id
        set status_type(package_id) $package_id
        set status_type(short_desc) $short_desc
        set status_type(long_desc) $long_desc
        set status_type(enabled_p) $enabled_p

        return [array get status_type]
    }
    
    ad_proc -public update_status_type {
        {-status_type_id:required}
        {-package_id ""}
        {-short_desc:required}
        {-long_desc:required}
        {-enabled_p "t"}
    } {
        set a status type
    } {
        db_dml update_status_type {}
    }
}

namespace eval recruiting_criteria {
    
    ad_proc -public new {
        {-criteria_name:required}
        {-description:required}
        {-enabled_p:required}
        {-package_id ""}
    } {
        create a new recruiting criteria
    } {
        if {[empty_string_p $package_id]} {
            set package_id [ad_conn package_id]
        }
        
        set extra_vars [ns_set create]
        ns_set put $extra_vars package_id $package_id
        ns_set put $extra_vars criteria_name $criteria_name
        ns_set put $extra_vars description $description
        ns_set put $extra_vars enabled_p $enabled_p

        set object_type "recruiting_criteria"

        return [package_instantiate_object -extra_vars $extra_vars $object_type]
    }        

    ad_proc -public disable {
        {-criteria_id:required}
    } {
        disable a recruiting criteria
    } {
        db_dml disable_criteria {}
    }

    ad_proc -public enable {
        {-criteria_id:required}
    } {
        enable a recruiting criteria
    } {
        db_dml enable_criteria {}
    }

    ad_proc -public get {
        {-criteria_id:required}
    } {
        get a recruiting criteria
    } {
        db_1row get_criteria {}

        set recruiting_criteria(criteria_id) $criteria_id
        set recruiting_criteria(package_id) $package_id
        set recruiting_criteria(criteria_name) $criteria_name
        set recruiting_criteria(description) $description
        set recruiting_criteria(enabled_p) $enabled_p

        return [array get recruiting_criteria]
    }

    ad_proc -public update_criteria_type {
        {-criteria_id:required}
        {-criteria_name:required}
        {-description:required}
        {-enabled_p:required}
        {-package_id ""}
    } {
        update a criteria type
    } {
        db_dml update_criteria {}
    }
}

namespace eval recruiting_candidate {

    ad_proc -public format_phone {
        {-phone_number:required}
    } {
        this proc takes a 10 digit phone number (which should
        have only digits, no ()-. characters, and formats it
        like this: "(123) 456-7890"

        if the input is not a string of ten digits, an empty
        string is returned
    } {
        if {[string length $phone_number] != 10} {
            return ""
        } else {
            return "\([string range $phone_number 0 2]\) [string range $phone_number 3 5]-[string range $phone_number 6 end]"
        }
    }

    ad_proc -public strip_phone {
        {-phone_number:required}
    } {
        this proc takes a 10 digit phone number of arbitrary format
        and strips away ()-., or any other characters
    } {
        regsub -all {[^0-9]} $phone_number "" stripped_number
        return $stripped_number
    }

    ad_proc -public new {
        {-first_name:required}
        {-last_name:required}
        {-address1:required}
        {-address2:required}
        {-city:required}
        {-state:required}
        {-zip:required}
        {-zip_plus_four:required}
        {-country:required}
        {-email:required}
        {-home_phone:required}
        {-cell_phone:required}
        {-status:required}
        {-package_id ""}
    } {
        add a new recruiting candidate
    } {
        
        if {[empty_string_p $package_id]} {
            set package_id [ad_conn package_id]
        }

        set extra_vars [ns_set create]
        ns_set put $extra_vars package_id $package_id
        ns_set put $extra_vars first_name $first_name
        ns_set put $extra_vars last_name $last_name
        ns_set put $extra_vars address1 $address1
        ns_set put $extra_vars address2 $address2
        ns_set put $extra_vars city $city
        ns_set put $extra_vars state $state
        ns_set put $extra_vars zip $zip
        ns_set put $extra_vars zip_plus_four $zip_plus_four
        ns_set put $extra_vars country $country
        ns_set put $extra_vars home_phone $home_phone
        ns_set put $extra_vars cell_phone $cell_phone
        ns_set put $extra_vars email $email
        ns_set put $extra_vars status $status
        
        set object_type "recruiting_candidate"

        return [package_instantiate_object -extra_vars $extra_vars $object_type]
    }

    ad_proc -public delete {
        {-candidate_id:required}
    } {
        delete a recruiting candidate
    } {
        db_dml delete_ratings_for_candidate {}
        db_dml delete_interviews_for_candidate {}
        db_dml delete_candidate {}
    }

    ad_proc -public get {
        {-candidate_id:required}
    } {
        get a candidate 
    } {
        db_1row get_recruiting_candidate {}

        array set the_status [recruiting_status_type::get -status_type_id $status]

        set recruiting_candidate(candidate_id) $candidate_id
        set recruiting_candidate(package_id) $package_id
        set recruiting_candidate(first_name) $first_name
        set recruiting_candidate(last_name) $last_name
        set recruiting_candidate(address1) $address1
        set recruiting_candidate(address2) $address2
        set recruiting_candidate(city) $city
        set recruiting_candidate(state) $state
        set recruiting_candidate(zip) $zip
        set recruiting_candidate(zip_plus_four) $zip_plus_four
        set recruiting_candidate(country) $country
        set recruiting_candidate(home_phone) $home_phone
        set recruiting_candidate(cell_phone) $cell_phone
        set recruiting_candidate(email) $email
        set recruiting_candidate(status) $the_status(short_desc)
        
        return [array get recruiting_candidate]
    }
    
    ad_proc -public update_candidate {
        {-candidate_id:required}
        {-first_name:required}
        {-last_name:required}
        {-address1:required}
        {-address2:required}
        {-city:required}
        {-state:required}
        {-zip:required}
        {-zip_plus_four:required}
        {-country:required}
        {-home_phone:required}
        {-cell_phone:required}
        {-email:required}
        {-status:required}
        {-package_id:required}
    } {
        update a candidate
    } {
        db_dml update_candidate {}
    }

}

namespace eval recruiting_interview {

    ad_proc -public new {
        {-interviewer_id:required}
        {-candidate_id:required}
        {-package_id ""}
    } {
        assign an interviewer to interview a candidate
    } {
        if {[empty_string_p $package_id]} {
            set package_id [ad_conn package_id]
        }
        
        set extra_vars [ns_set create]
        ns_set put $extra_vars package_id $package_id
        ns_set put $extra_vars interviewer_id $interviewer_id
        ns_set put $extra_vars candidate_id $candidate_id

        set object_type "recruiting_interview"


        return [package_instantiate_object -extra_vars $extra_vars $object_type]
    }

    ad_proc -public delete {
        {-interview_id:required}
    } {
        delete an interview
    } {
        db_dml delete_ratings {}
        db_dml delete_interview {}
    }

    ad_proc -public get {
        {-interview_id:required}
    } {
        get an interview
    } {
        db_1row get_interview {}

        set interview(interview_id) $interview_id
        set interview(package_id) $package_id
        set interview(interviewer_id) $interviewer_id
        set interview(candidate_id) $candidate_id
        set interview(should_hire_p) $should_hire_p
        set interview(comment) $comment

        return [array get interview]
    }
}

namespace eval recruiting_rating {
    
    ad_proc -public new {
        {-interview_id:required}
        {-criteria_id:required}
        {-rating:required}
        {-package_id ""}
    } {
        rate a candidate on a particular criteria
    } {
        if {[empty_string_p $package_id]} {
            set package_id [ad_conn package_id]
        }
        
        set extra_vars [ns_set create]
        ns_set put $extra_vars package_id $package_id
        ns_set put $extra_vars interview_id $interview_id
        ns_set put $extra_vars criteria_id $criteria_id
        ns_set put $extra_vars rating $rating

        set object_type "recruiting_rating"
        return [package_instantiate_object -extra_vars $extra_vars $object_type]
    }
    
    ad_proc -public delete {
        {-rating_id:required}
    } {
        delete a rating
    } {
        db_dml delete_rating {}
    }

    ad_proc -public get {
        {-rating_id:required}
    } {
        get a rating
    } {
        db_1row get_rating {}
        set rating(package_id) $package_id
        set rating(interview_id) $interview_id
        set rating(criteria_id) $criteria_id
        set rating(rating) $criteria
    }
}
