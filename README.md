# Ansible Role: certbot

Ansible Role to configure Certbot (for Let's Encrypt)

## Requirements

- python [cryptography](https://pypi.org/project/cryptography/) installed the local system.

## Role Variables

### Defaults

**NOTE**: values marked as yes* should be configured for each cert or globally, both also works.

| **Variable Name**           | **Required**|**Type**| **Default Value**| **Description**|
| :---------------------------| :----------:|:------:| :---------------:| :--------------|
| certbot_certs:              | no          | array  | []               | The list of certificates that should be requested see [Certbot_certs](#certbot_certs) for more info.|
| certbot_request_method:     | no          | string | "standalone"     | The method for requesting certificates, can be one of the following `"standalone"`, `"nginx"`, `"apache"`. When `"nginx"` or `"apache"` the corresponding certbot plugin will be installed.|
| certbot_email:              | yes*        | string | ""               | The email address used for requesting the certificate.|
| certbot_agree_tos:          | yes         | bool   | false            | Set to `true` in order to agree to the Let's Encrypt Terms Of Service. You only have to agree when requesting a certificate from Let's Encrypt, this may be `false` when using a different ACME server.|
| certbot_state:              | no          | string | "present"        | When `"present"` certbot will be installed and configured, when `"absent"` certbot will be removed.|
| certbot_remove_unknown:     | no          | bool   | false            | When `true` all certificates that aren't configured with ansible will be removed.|
| certbot_key_type:           | no          | string | "ecdsa"          | The protocol used for the key, can be `"ecdsa"` or `"rsa"`.|
| certbot_key_curve:          | no          | string | secp384r1        | The curve that should be used for the key, only active when `certbot_key_type:` is `"ecdsa"`. The following curves are allowed: `"secp256r1"`, `"secp384r1"`, `"secp521r1"`. **NOTE**: that Let's Encrypt only supports `"secp384r1"`, This will be enforced when `server:` is empty.|
| certbot_key_size:           | no          | int    | 4096             | The size of the key, only active when `certbot_key_type:` is `"rsa"`. The following sizes are allowed: `2048`, `3072`, `4096`|
| certbot_pre_hook:           | no          | string | ""               | The command to be run before requesting/renewing the certificate. The command will be encapsulated in `''`.|
| certbot_post_hook:          | no          | string | ""               | The command to be run after requesting/renewing the certificate. The command will be encapsulated in `''`.|
| certbot_deploy_hook:        | no          | string | ""               | The command to be run when a certificate was successfully requested/renewed. The command will be encapsulated in `''`.|
| certbot_test:               | no          | bool   | false            | When `true` a test certificate will be requested.|
| certbot_ca:                 | no          | string | ""               | Path to the CA to use for request validation, should be used in tandem with `certbot_server:`.|
| certbot_server:             | no          | string | ""               | Url for a custom ACME server, should be used in tandem with `certbot_ca:`.|
| certbot_renew_before_expiry:| no          | int    | 0                | The number of days before certificate expiry certbot should renew the certificate. When this is `0` certbot's default value will be used.|
| certbot_allow_breaking:     | no          | bool   | false            | Whether certbot is allowed to replace valid certificates with invalid/testing certificates.|
| certbot_script:             | no          | string | "certbot"        | The command for executing certbot.|

### Certbot_certs

**NOTE**: Per cert settings take precedence over global settings.

When any of the following setting change in the global or per cert config a new certificate will be requested.

- `primary_domain:`
- `domains:`
- `key_type:`
- `key_curve:`
- `key_size:`
- `test:`

| **Variable Name**   | **Required**| **Type**| **Default Value**             | **Description**|
| :-------------------| :----------:| :------:| :----------------------------:| :--------------|
| primary_domain:     | yes         | string  | ""                            | This is the primary domain of the certificate and will be used for the file path to the certificate.|
| domains:            | no          | array   | []                            | This is for supplying additional domains.|
| email:              | yes*        | string  | `certbot_email:`              | Same as `certbot_email:`.|
| key_type:           | no          | string  | `certbot_key_type:`           | Same as `certbot_key_type:`.|
| key_curve:          | no          | string  | `certbot_key_curve:`          | Same as `certbot_key_curve:`.|
| key_size:           | no          | int     | `certbot_key_size:`           | Same as `certbot_key_size:`.|
| pre_hook:           | no          | string  | `certbot_pre_hook`            | Same as `certbot_pre_hook:`.|
| post_hook:          | no          | string  | `certbot_post_hook`           | Same as `certbot_post_hook:`.|
| deploy_hook:        | no          | string  | `certbot_deploy_hook`         | Same as `certbot_deploy_hook:`.|
| test:               | no          | bool    | `certbot_test:`               | Same as `certbot_test:`.|
| ca:                 | no          | string  | `certbot_ca:`                 | Same as `certbot_ca:`.|
| server:             | no          | string  | `certbot_server:`             | Same as `certbot_server:`.|
| renew_before_expiry:| no          | int     | `certbot_renew_before_expiry:`| Same as `certbot_renew_before_expiry:`.|
| allow_breaking:     | no          | bool    | `certbot_allow_breaking`      | Same as `certbot_allow_breaking`.|

## Dependencies

N/A

## Example Playbook

```yaml
- hosts: all
  roles:
    - role: tinyblargon.certbot
      vars:
        certbot_certs:
          - primary_domain: example.com
            domains:
              - a.example.com
              - b.example.com
            email: info@example.com
            key_type: rsa
          - primary_domain: test.example.com
            test: true
        certbot_email: admin@example.com

```

## License

MIT
