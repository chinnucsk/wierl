
REBAR=$(shell which rebar || echo ./rebar)

all: dirs deps compile

./rebar:
	erl -noshell -s inets start \
		-eval 'httpc:request(get, {"https://github.com/downloads/basho/rebar/rebar", []}, [], [{stream, "./rebar"}])' \
		-s inets stop -s init stop
	chmod +x ./rebar

dirs:
	@mkdir -p priv/tmp

compile: $(REBAR)
	@$(REBAR) compile

clean: $(REBAR)
	@$(REBAR) clean

deps: $(REBAR)
	@$(REBAR) check-deps || $(REBAR) get-deps

