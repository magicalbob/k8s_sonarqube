k8s_sonarqube
=============

Sonarqube in kubernetes.

`install-sonarqube.sh` sets it up. If kubectl isn't available it tries to set up a kind cluster called kind-sonarqube.

To reset the auth from default admin/admin:

	curl -u admin:admin -X POST "https://${YOUR_HOST}/api/users/change_password" -d "login=admin&password=${YOUR_NEW_PASSWORD}&previousPassword=admin"

There is a sample systemd serice file `systemd/prot9000.service` to do port forwarding.

NOTE: to get running I had to do:

	echo 'vm.max_map_count=262144' | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

on each node of the k8s cluster.
