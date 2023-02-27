require "pronto/standardrb/version"
require "pronto/standardrb/patch_cop"
require "pronto/standardrb/offense_line"
require "pronto"
require "rubocop"
require "standard"

module Pronto
  class Standardrb < Runner
    def run
      return [] unless @patches

      @patches
        .select { |patch| patch.additions.positive? }
        .flat_map { |patch| PatchCop.new(patch, self).messages }
    end

    def pronto_standardrb_config
      @pronto_standardrb_config ||= Pronto::ConfigFile.new.to_h['rubocop'] || {}
    end
  end
end
