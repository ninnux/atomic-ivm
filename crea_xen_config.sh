get_vg_name(){
        echo jenna
}
VG_NAME=`get_vg_name`
cat > /etc/xen/$1.cfg <<DELIM
#kernel = "/boot/vmlinuz-2.6.32-5-xen-amd64"
#ramdisk="/boot/initrd.img-2.6.32-5-xen-amd64"
kernel = "/boot/vmlinuz-3.2.0-4-amd64"
ramdisk="/boot/initrd.img-3.2.0-4-amd64"
memory = $2
name = "$1"
# vlan13 pub, vlan11 priv
vif = [ 'bridge=xenbr13', 'bridge=xenbr11' ]
#disk = [ 'phy:/dev/${VG_NAME}/$1,xvda1,w','phy:/dev/${VG_NAME}/$1_swp,xvda2,w' ]
disk = [ 'phy:/dev/${VG_NAME}/$1,xvda1,w' ]
root = "/dev/xvda1 rw"
DELIM
