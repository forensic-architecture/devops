# playbooks for timemap and datasheet deployment

* saturate all variables from a .env, so that maintenance of separate repo not required.
* more flexibly separate 'deploy_develop.yml' into roles
* template in values in timemap src/store/initial.js to color categories, etc.
* option to add password protected

* ideally the ability to add new timemap instances without breaking old ones.
	* this would basically require keeping one ds-s, and adding sheets, which creating new timemap frontends.



# Necessary Changes
* in ansible.cfg, add path to your private key
* create a vault.yml in vars. All custom config can go in here (to override
    main.yml)
