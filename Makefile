.PHONY: all image package dist clean


# provision with terraform then configure with ansible
all: provision, configure

# this should actually run integration tests
test: 
	terraform plan

# setup aws resources using terraform
provision: 
	terraform apply

# configure the iheavy server with ansible
configure:
	ansible-playbook iheavy_playbook.yml

# this should cleanup backup files
clean:
	rm *~

