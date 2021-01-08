ceep osd lspools 列出所有的存储池。
osd pool default pg num=100
osd pool default pgp num=100
创建存储池：
ceph osd pool create {pool-name} {pg-num}[{pgp-num}][replicated][crush-ruleset-name][expected-num-objects]
pool-name#存储池的名称
pg-num #存储池的归置总数
pgp-num #存储池的归置组总数，此数等于归置组数。
replicated/reasure #存储池类型。
crush-ruleset-name #此存储所有的crus规则集的名子。
exasure-coder-profile=profile #仅用于纠错池，指定纠删码配置框架。
expected-num-objects #为这个存储池预估的对象数。
创建：ceph osd pool create ceshi 100 100
############################################################################
创建映像：
rbd create --size 1024 ceshi/aini 在ceshi这个存储池下，创建aini的映像。
查看存储池内的映像块：
rbd ls ceshi
查看映像信息：
rbd info ceshi/aini
