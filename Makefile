all:
	./init_topo.sh

ns:
	sudo ip netns exec wgns bash

debug:
	./srv debug

run:
	./srv run
