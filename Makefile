SRC = lib/*.js

REQUIRED = --require should --require should-http

TESTS = test/application/* \
	test/context/* \
	test/request/* \
	test/response/* \
	test/middlewares/* \
	test/experimental/index.js

lint:
	@./node_modules/.bin/eslint lib test

test:
	@NODE_ENV=test node \
		./node_modules/.bin/_mocha \
		$(REQUIRED) \
		$(TESTS) \
		--bail

test-travis: lint
	@NODE_ENV=test node \
		./node_modules/.bin/istanbul cover \
		./node_modules/.bin/_mocha \
		--report lcovonly \
		-- -u exports \
		$(REQUIRED) \
		$(TESTS) \
		--bail

bench:
	@$(MAKE) -C benchmarks

.PHONY: lint test bench
