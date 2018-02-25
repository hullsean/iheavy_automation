.PHONY: all image package dist clean

all: provision, configure

test: 
	terraform plan

provision: 
	terraform apply

configure:
	ansible-playbook iheavy_playbook.yml

clean:
	rm *~

