module Wisper
  module Activerecord
    module Publisher
      extend ActiveSupport::Concern
      included do

        include Wisper::Publisher

        after_create    :publish_create
        after_update    :publish_update
        after_destroy   :publish_destroy
        after_rollback  :publish_rollback

      end

      private

      %w(create update destroy rollback).each do |event|
        define_method("publish_#{event}") do
          broadcast("on_#{event}".to_sym, self)
        end
      end
    end
  end
end
