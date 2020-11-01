Describe "Timezone Validation" {

    Context "Timezone Validation" {

        It "should be 'Eastern Standard Time'" {
            (Get-TimeZone).StandardName | should be 'Eastern Standard Time'
        }

    }

}