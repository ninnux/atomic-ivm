cat > /mnt/$1/etc/network/interfaces <<DELIM
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
iface eth0 inet static
	address $2 
	netmask $3 
	gateway 176.62.53.1
	dns-nameservers 176.62.53.1 8.8.8.8 

auto eth1
iface eth1 inet static
	address $4 
	netmask $5 

iface eth0 inet6 static
        address $6 
        netmask $7
	gateway 2001:4c00:893b:aa::1
DELIM
