# playbooks for timemap and datasheet deployment
* option to add password protected

* ideally the ability to add new timemap instances without breaking old ones.
	* this would basically require keeping one ds-s, and adding sheets, which creating new timemap frontends.


# Necessary Changes
* in .env, fill out custom variables for ansible itself
* run `eval (cat env)`
* create a vault.yml in vars. Playbook custom config can go in here (to override
    main.yml)
