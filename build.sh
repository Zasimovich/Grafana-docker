#!/bin/bash
_grafana_version=$1
_grafana_tag=$2
_release_build=false

if [ -z "${_grafana_version}" ]; then
	source GRAFANA_VERSION
	_grafana_version=$GRAFANA_VERSION
	_grafana_tag=$GRAFANA_VERSION
	_release_build=true
fi

echo "GRAFANA_VERSION: ${_grafana_version}"
echo "DOCKER TAG: ${_grafana_tag}"
echo "RELEASE BUILD: ${_release_build}"

docker build --build-arg GRAFANA_VERSION=${_grafana_version} --tag "adept23/grafana:${_grafana_tag}"  --no-cache=true .

if [ $_release_build == true ]; then
	docker build --build-arg GRAFANA_VERSION=${_grafana_version} --tag "adept23/grafana:latest"  --no-cache=true .
fi
