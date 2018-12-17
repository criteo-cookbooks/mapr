#############################
#  Generating the keytabs on the machines and setting the appropriate realms is outside of the scopde of
# the cookbooks.
#
# Setting the right config
default['mapr']['security']['kerberos']['keytab_name'] = 'mapr.keytab'
# Setting the CLDB key
default['mapr']['security']['cldb.key']['content'] = 'KEY_CONTENT'

# Setting the MAPSERVERTICKET
default['mapr']['security']['maprserverticket']['content'] = 'KEY_CONTENT'

# Setting the ssl_config
default['mapr']['security']['ssl'] = {
    'ssl_keystore' => {
        'checksum' => '35e1b49e94efee98d929d141dc391a8ed60acfc394e3da347c4d7a82432e7ecc',
        'content' => 'KEY_CONTENT',
    },
    'ssl_keystore.p12' => {
        'checksum' => '35e1b49e94efee98d929d141dc391a8ed60acfc394e3da347c4d7a82432e7ecc',
        'content' => 'KEY_CONTENT',
    },
    'ssl_keystore.pem' => {
        'checksum' => '35e1b49e94efee98d929d141dc391a8ed60acfc394e3da347c4d7a82432e7ecc',
        'content' => 'KEY_CONTENT',
    },
    'ssl_truststore' => {
        'checksum' => '35e1b49e94efee98d929d141dc391a8ed60acfc394e3da347c4d7a82432e7ecc',
        'content' => 'KEY_CONTENT',
    },
    'ssl_truststore.p12' => {
        'checksum' => '35e1b49e94efee98d929d141dc391a8ed60acfc394e3da347c4d7a82432e7ecc',
        'content' => 'KEY_CONTENT',
    },
    'ssl_truststore.pem' => {
        'checksum' => '35e1b49e94efee98d929d141dc391a8ed60acfc394e3da347c4d7a82432e7ecc',
        'content' => 'KEY_CONTENT',
    },
}

default['mapr']['security']['jmx']['config'] = {
    'access' => {
        'mapr' => 'readonly',
    },
    'password' => {
        'mapr' => 'mapr',
        'root' => 'root'
    }
}
