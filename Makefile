AIRFLOW_VERSION ?= 1.8.0.0
KUBECTL_VERSION ?= 1.6.6
KUBE_AIRFLOW_VERSION ?= 0.2.2

REPOSITORY ?= kuberlab/kube-airflow
TAG ?= $(AIRFLOW_VERSION)-$(KUBECTL_VERSION)-$(KUBE_AIRFLOW_VERSION)
IMAGE ?= $(REPOSITORY):$(TAG)
ALIAS ?= $(REPOSITORY):$(AIRFLOW_VERSION)-$(KUBECTL_VERSION)

BUILD_ROOT ?= build/$(TAG)
DOCKERFILE ?= $(BUILD_ROOT)/Dockerfile
AIRFLOW_CONF ?= $(BUILD_ROOT)/config/airflow.cfg
ENTRYPOINT_SH ?= $(BUILD_ROOT)/script/entrypoint.sh

.PHONY: build clean

clean:
	rm -Rf build

build: $(DOCKERFILE) $(AIRFLOW_CONF) $(ENTRYPOINT_SH)
	cd $(BUILD_ROOT) && docker build -t $(IMAGE) . && docker tag $(IMAGE) $(ALIAS)

publish:
	docker push $(IMAGE) && docker push $(ALIAS)

$(DOCKERFILE): $(BUILD_ROOT)
	sed -e 's/%%KUBECTL_VERSION%%/'"$(KUBECTL_VERSION)"'/g;' -e 's/%%AIRFLOW_VERSION%%/'"$(AIRFLOW_VERSION)"'/g;' Dockerfile.template > $(DOCKERFILE)

$(AIRFLOW_CONF): $(BUILD_ROOT)
	mkdir -p $(shell dirname $(AIRFLOW_CONF))
	cp config/airflow.cfg $(AIRFLOW_CONF)

$(ENTRYPOINT_SH): $(BUILD_ROOT)
	mkdir -p $(shell dirname $(ENTRYPOINT_SH))
	cp script/entrypoint.sh $(ENTRYPOINT_SH)

$(BUILD_ROOT):
	mkdir -p $(BUILD_ROOT)
