# coding: UTF-8

require 'json'
require 'thor'
require 'pp'

class DocCreator < Thor

    no_commands do

        def parse_header(data, config)
            content = []

            content << "<h1>#{data['title']}</h1>"
            content << "<p class='lead'>#{data['description']}</p>"
            # content << "<p>#{config['extended_description']}</p>"
            content << "<dl>"
            content << "<dt>Schema Source</dt>"
            content << "<dd><a href='#{config['schema_path']}'>#{File.basename(config['schema_path'])}</a></dd>"
            content << "<dt>Project Source</dt>"
            content << "<dd><a href='#{config['source']}'>#{config['source']}</a></dd>"
            content << "<dt>JSON Schema Version</dt>"
            content << "<dd><a href='#{data['$schema']}'>#{data['$schema'].strip}</a></dd>"
            content << "</dl>"

            content << "<p><span style='color: red'>*</span> bezeichnet Pflichtfelder.</p>"

            return content
        end

        def parse_properties(properties, required_properties)
            content = []

            content << %{
              <div class='row doc-properties'>
                <div class='col-md-12'>
      
                  <div class="row doc-header">
                    <div class="col-md-1 doc-label">
                      Title
                    </div>
                    <div class="col-md-1 doc-label">
                      Type
                    </div>
                    <div class="col-md-2 doc-label">
                      Description
                    </div>
                    <div class='col-md-8 doc-label'>
                      Definition
                    </div>
                  </div>    
            }

            counter = 1
            properties.each_with_index do |(title, item), index|
                required = required_properties.include?(title) ? true : false
                last = (index == properties.size - 1)
                type = item["type"]
                description = item['description']
                if (type.eql?("array"))
                    cardinality = "+"
                    item = item['items']
                    type = item['type']
                end

                cardinality = type.eql?("array") ? "+" : "1"

                content << "<div class='row doc-property #{counter.even? ? "doc-even" : "doc-odd"}#{required ? " doc-required" : ""}#{last ? " doc-footer" : ""}'>"

                content << "<div class='col-md-1 doc-property_title'>#{title}</div>"
                content << "<div class='col-md-1 doc-property_type'>#{item['type']} (#{cardinality})</div>"
                content << "<div class='col-md-2 doc-property_type'>#{description}</div>"


                content << "<div class='col-md-8'>"
                case type
                when "object"
                    # content << "properties"
                    content << parse_properties(item['properties'], item['required'])
                when "string"
                    # content << "string"
                    content << parse_definition(item)
                end
                content << "</div>"
                content << "</div> <!-- property '#{title}' -->"
                counter += 1
            end

            content << %{
                </div> <!-- end col (doc-properties) -->
              </div> <!-- end row (doc-properties) -->
            }

            return content
        end

        def parse_definition(item)
            content = []

            content << "<div class='col-md-8'>"

            definition_properties = [ 
                "format",
                "enum",
                "pattern",
            ]

            definition_properties.each do |property|
                if value = item[property]
                    content << output_definition(property, value)
                end
            end

            content << "</div>"

            return content
        end

        def output_definition(key, value)
            content = []

            content << "<dl>"
            content << "<dt>#{key}</dt>"
            content << "<dd>"
            value = [ value ].flatten
            items = []
            value.each do |item|
                items << "<code>#{item}</code>"
            end
            content << items.join(", ")
            content << "</dd>"
            content << "</dl>"

            return content


        end

    end

    desc "create PATH", "create documentation for schema at PATH"
    option :output_path, :aliases => [ :o]
    option :config_path, :aliases => [ :c], :default => "config.json"
    def create(json_path)
        data = JSON.load(File.open(json_path))
        config = JSON.load(File.open(options[:config_path]))

        template = File.read(File.join("templates", "index.html"))
        template.gsub!("$TITLE$", "Berlin Metadata Schema")

        content = []

        content << "<div class='content'>"

        content << parse_header(data, config)

        content << "<div class='container-fluid doc-schema_content'>"
        content << parse_properties(data['properties'], data['required'])
        content << "</div> <!-- end container -->"

        content << "</div>"

        content.flatten!
        content = content.join("\n")

        template.gsub!("$CONTENT$", content)

        puts template
    end

end

DocCreator.start(ARGV)