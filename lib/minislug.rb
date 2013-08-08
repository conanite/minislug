require "minislug/version"

module Minislug
  module ClassMethods
    def sluggable source
      class_attribute :slug_source
      include InstanceMethods

      self.slug_source = source

      before_validation :set_slug

      scope :by_slug, lambda { |slug| where(:slug => slug) }
    end
  end

  module InstanceMethods
    def set_slug
      proto_slug = self.send(self.slug_source) || ""
      self.slug = proto_slug.strip.mb_chars.normalize(:kd).to_s.gsub(/\s/, '-').gsub(/[^0-9A-Za-z-]/, '')
    end
  end
end

if defined?(ActiveRecord)
  ActiveRecord::Base.send :extend, Minislug::ClassMethods
end
