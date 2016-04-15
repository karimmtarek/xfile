require 'json'

class Generator
  # PATH = '/Users/karim/code/talks/xfile/data/xfile.json'
  attr_reader :raw_data

  def initialize(file_pwd)
    @raw_data = JSON.parse(File.read(file_pwd))

    raw_data.keys.each do |key|
      k = key.gsub('-', '_')
      instance_variable_set("@#{k}", raw_data[key])
      self.class.my_attr_reader(k.to_sym)
    end

    self.class.gen raw_data
  end

  private

  # Spell: Dynamic Dispatch
  def self.gen(raw_data)
    raw_data.keys.each do |key|
      k = key.gsub('-', '_')
      send(:define_method, "#{k}?") do
        !raw_data[key].empty?
      end
    end
  end

  # Spell: Ghost Method
  def method_missing(_method_name, *arguments)
    puts 'Available methods are:'
    self
      .class
      .instance_methods(false)
      .reject { |m| m == :method_missing }
      .map { |method| "##{method}" }
      .sort
  end
end
