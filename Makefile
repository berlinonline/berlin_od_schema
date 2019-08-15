documentation: web/index.html web/berlin_od_schema.json

web/berlin_od_schema.json: temp/berlin_od_schema.json | web
	@echo "copy schema to web/ folder ..."
	@cp temp/berlin_od_schema.json web

web/index.html: temp/berlin_od_schema.json | web
	@echo "creating schema web page ..."
	@ruby bin/create_doc.rb create temp/berlin_od_schema.json > web/index.html

imperia-selection-lists: temp/berlin_od_schema.json | options
	@echo "create selection boxes for Imperia ..."
	@. bin/extract_options.sh options

# re-create the `enum` and `labels` part of the `license_id` property based on the
# list of available licenses at https://datenregister.berlin.de/licenses/berlin-od-portal.json
temp/berlin_od_schema.json: temp/berlin-od-portal.json
	@echo "re-create license_id from licenses file ..."
	@cat temp/berlin-od-portal.json templates/berlin_od_schema.json | jq -s '.[1].properties.license_id.enum = [ .[0][].id ] | .[1].properties.license_id.labels = [ .[0][].title ] | .[1]' > temp/berlin_od_schema.json

temp/berlin-od-portal.json: | temp
	@echo "getting license-list from datenregister ..."
	@curl -s https://datenregister.berlin.de/licenses/berlin-od-portal.json > temp/berlin-od-portal.json

options:
	@echo "creating options directory ..."
	@mkdir -p options

temp:
	@echo "creating temp directory ..."
	@mkdir -p temp

web:
	@echo "creating web directory ..."
	@mkdir -p web

.PHONY: clean # remove all temporary files
clean:
	@echo "removing temp files"
	@rm -rf temp
	@rm -rf web
	@rm -rf options
