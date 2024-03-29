.PHONY: build prepare test

prepare:
	cd easy_dsl && dart pub get
	cd easy_dsl_gen && dart pub get
	cd example && flutter pub get

test:
	cd example && dart run build_runner clean
	cd example && dart run build_runner build -d

test1:
	cd example && dart run build_runner build -d --no-track-performance

watch:
	cd example && dart run build_runner watch -d