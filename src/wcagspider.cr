require "arachnid"
require "uri"

class WCAGSpider
  VERSION = "0.1.0"

  property site : String
  property command : String

  def initialize(
    @site = "#",
    @command = "pa11y --include-warnings --include-notices --reporter csv --runner htmlcs [URL]"
  ); end

  def filename_from(uri)
    "#{uri.host}:#{uri.path.gsub(/\//,"-")}"
  end

  def run
    agent = Arachnid::Agent.new(stop_on_empty: true)

    agent.site(@site) do
      on_html do |res|
        if @command.empty?
          puts res.uri
        else
          File.open(filename_from(res.uri), "w+") do |fh|
            specific_command = @command.gsub(/\[URL]/,res.uri)
            Process.new(shell: true, command: specific_command, output: fh)
          end
        end
      end
    end
  end

end

target = ARGV.size > 0 ? ARGV[0] : "#"
command = ARGV.size > 1 ? ARGV[1] : nil

spider = command.nil? ? WCAGSpider.new(site: target) : WCAGSpider.new(site: target, command: command)

spider.run
