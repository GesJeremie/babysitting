#--------------------------------------------------------------------------
# Config
#--------------------------------------------------------------------------
#
# Sometimes you need to put some configuration variables for your project,
# here it's the right place for that !
#
# Config = require 'config'
# console.log Config.app.name
##

module.exports =

    # Example
    app:
        name: 'My Gotham Application'
        version: 0.1

    keenio:
        dev:
            projectId: '57aeaf313831444167e1fa35'
            readKey: '410e0b58f9d6c3371cd296341701dc9758bd8b47d9def44aff868ba6cfd54dfe394b8eb113a55c8dc4df2042975da73e7bcc9e397e1e8ca48f75607fd2caa712359db81d2cc304029fc6b20cc34795344551caf82419a8744bc650f9a8b910ac'

    env: () =>

        $selector = $('#app-config[data-environment]')

        if $selector.length
            return $selector.data('environment')
