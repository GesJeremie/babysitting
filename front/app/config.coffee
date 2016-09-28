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

    keenio:
        dev:
            projectId: "57aeaf313831444167e1fa35"
            writeKey: "b90d7934bb1d121351a8cad5ec0b4687a81f86e47186d2812cf531f3e7bb62025622b50482fa18d03565d7815f0eaebab74a444af9b7dbfa94fc7621eec1e8ef786da80339a9b642402c893a52b8967a5b7241df69783d2c782ed66f82f1cc47"
            readKey: "410e0b58f9d6c3371cd296341701dc9758bd8b47d9def44aff868ba6cfd54dfe394b8eb113a55c8dc4df2042975da73e7bcc9e397e1e8ca48f75607fd2caa712359db81d2cc304029fc6b20cc34795344551caf82419a8744bc650f9a8b910ac"

    env: () =>

        $selector = $('#app-config[data-environment]')

        if $selector.length
            return $selector.data('environment')
        else
            console.log("[WARNING] Environment not specified, fallback to prod")
            return 'prod'
