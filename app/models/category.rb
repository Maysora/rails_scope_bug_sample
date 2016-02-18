class Category < ActiveRecord::Base
  belongs_to :parent, class_name: "Category"

  has_many :children, class_name: "Category", foreign_key: "parent_id", dependent: :restrict_with_error

  scope :roots, -> { where(parent_id: nil) }

  def self.map_nested_names options = {}
    options.reverse_merge!(padding: '-', level: 0)
    all.inject([]) do |arr, a|
      puts "children sql: #{a.children.to_sql}"
      arr +
        ["#{options[:padding] * options[:level]}#{a.name}"] +
        a.children.map_nested_names(options.merge(level: options[:level] + 1))
    end
  end

  def self.map_nested_names_w options = {}
    options.reverse_merge!(padding: '-', level: 0)
    all.inject([]) do |arr, a|
      puts "children sql: #{a.children.to_sql}"
      arr +
        ["#{options[:padding] * options[:level]}#{a.name}"] +
        unscoped.where(parent: a).map_nested_names_w(options.merge(level: options[:level] + 1))
    end
  end
end
