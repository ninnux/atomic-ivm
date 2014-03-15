alloca-dealloca-test.sh 
	script di test
alloca_storage.sh $name
	crea logical volume 
crea_net_interface.sh 
	crea /etc/network/interface
crea_xen_config.sh
	crea configurazione macchina xen
dealloca_storage.sh $name
	distrugge logical volume	
distruggi_macchina.sh
	spegne macchina
instanzia_distro.sh
	accrocco che scarica con debootsrap i pacchetti e crea l'ambiente

active_nodes.log
	lista nodi attivi con subnet
alloca_risorsa.sh
	alloca una risorsa disponibile (passata come primo argomento) e la restituisce
	il file della risorsa e' composta da piu' righe. ogni riga rappresenta una risorsa.
	es. di riga: 10.0.0.0_255.255.255.0
publicip.allocation
	file delle risorse ipv4 publica
privip.allocation
	file delle risorse ipv4
dealloca_risorsa.sh
	dealloca una risorsa
disk_space_management.sh
	contiene solo le funzioni request e release	
disk_utilization
	file che mantiene il disco occupato (in GB)
master.tar
	stage1 debootsrap
prova.sh
	prova
readme.txt
	readme
todo.txt
	todo
