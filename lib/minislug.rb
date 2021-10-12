# -*- coding: utf-8 -*-

require "minislug/version"

module Minislug
  SUBSTITUTIONS = {
    /[\s\/\\\(\)#\?]+/ => '-',
    /\+/ => '-plus-',
    /&/ => '-and-',
    /-+/ => '-',
  }

  TR0 = "ÀÁÂÃÄÅàáâãäåĀāĂăĄąạảÇçĆćĈĉĊċČčÐðĎďĐđÈÉÊËèéêểệễëĒēĔĕĖėĘęĚěẹĜĝĞğĠġĢģĤĥĦħÌÍÎÏìíîïĨĩĪīĬĭĮįİıịỉĴĵĶķĸĹĺĻļĽľĿŀŁłÑñŃńŅņŇňŉŊŋÒÓÔÕÖØòóôộỗổõöøŌōŎŏŐőọỏơởợỡŔŕŖŗŘřŚśŜŝŞşŠšſŢţŤťŦŧÙÚÛÜùúûüŨũŪūŬŭŮůŰűŲųụưủửữựŴŵÝýÿŶŷŸŹźŻżŽžứừửựữốồộỗổờóợỏỡếềễểệẩẫấầậỳỹýỷỵặẵẳằắ"
  TR1 = "AAAAAAaaaaaaAaAaAaaaCcCcCcCcCcDdDdDdEEEEeeeeeeEeEeEeEeEeeGgGgGgGgHhHhhIIIiiiiIiIiIiIiIiiiJjKkkLlLlLlLlLlNnNnNnNnnNnOOOOOOoooooooooOoOoOooooooooRrRrRrSsSsSsSsTtTtTttUUUUuuuuUuUuUuUuUuUuuuuuuuWwYyyYyYZzZzZzuuuuuooooooooooeeeeeaaaaayyyyyaaaaa"

  module ClassMethods
    def sluggable source
      class_attribute :slug_source
      include InstanceMethods

      self.slug_source = source

      before_validation :set_slug

      scope :by_slug, lambda { |slug| where(:slug => slug) }
    end
  end


  def self.convert_to_slug txt
    txt = txt.gsub(/ß/, "ss")
    txt = txt.tr TR0, TR1
    SUBSTITUTIONS.each do |reg, rep|
      txt = txt.gsub reg, rep
    end
    txt.gsub(/[^0-9A-Za-z-]/, '').gsub(/^-+/, '').gsub(/-+$/, '')
  end

  module InstanceMethods
    def set_slug
      proto_slug = self.send(self.slug_source) || ""
      self.slug = Minislug.convert_to_slug proto_slug
    end
  end
end

if defined?(ActiveRecord)
  ActiveRecord::Base.send :extend, Minislug::ClassMethods
end
