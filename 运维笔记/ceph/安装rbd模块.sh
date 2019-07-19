 rpm --import http://elrepo.org/RPM-GPG-KEY-elrepo.org
 rpm -Uvh http://elrepo.org/elrepo-release-6-5.el6.elrepo.noarch.rpm
 yum --enablerepo=elrepo-kernel install kernel-ml
 yum --enablerepo=elrepo-kernel install kernel-lt
 重启
