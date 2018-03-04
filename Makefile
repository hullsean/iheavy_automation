.PHONY: all image package dist clean


# provision with terraform then configure with ansible
all: provision, configure

test: 
	terraform plan

# setup aws resources using terraform
provision: 
	terraform apply

# configure the iheavy server with ansible
configure:
	ansible-playbook iheavy_playbook.yml

clean:
	rm *~

