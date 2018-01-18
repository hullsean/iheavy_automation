.PHONY: all image package dist clean

all: package


package: 
	./build_iheavy.sh

clean:
	rm *~

