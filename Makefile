ci: mod-update test cover

mod-update:
	go get -u
	go mod tidy

mod-tidy:
	go mod tidy

fmt:
	go fmt -w $(go list ./... | grep -v generated)

.PHONY: mod-update mod-tidy fmt

test:
	go test $(go list ./... | grep -v generated)
.PHONY: test

COVER_TEST_PKGS:=$(shell find . -type f -name '*_test.go' | rev | cut -d "/" -f 2- | rev | grep -v generated | sort -u)
$(COVER_TEST_PKGS:=-cover): %-cover: all-cover.txt
	@CGO_ENABLED=0 go test -v -coverprofile=$@.out -covermode=atomic ./$*
	@if [ -f $@.out ]; then \
		grep -v "mode: atomic" < $@.out >> all-cover.txt; \
		rm $@.out; \
	fi

all-cover.txt:
	echo "mode: atomic" > all-cover.txt

cover: all-cover.txt $(COVER_TEST_PKGS:=-cover)
.PHONY: cover all-cover.txt
