require "rails_helper"
require "active_record"

class Test < ActiveRecord::Base
  scope :red, -> { where(color: :red) }
  scope :green, -> { where(color: :green) }

  def self.ransackable_scopes(a = nil)
    [:red, :green]
  end
end

RSpec.describe Test do
  context "when conditions are two scopes" do
    let(:ransack) { Test.ransack(red: true, green: true, m: :or) }

    it "supports :or combinator" do
      expect(ransack.base.combinator).to eq :or
    end

    it "generates SQL containing OR" do
      expect(ransack.result.to_sql).to include "OR"
    end
  end

  context "when conditions are a scope and an attribute" do
    let(:ransack) { Test.ransack(red: true, color_cont: "green", m: :or) }

    it "supports :or combinator" do
      expect(ransack.base.combinator).to eq :or
    end

    it "generates SQL containing OR" do
      expect(ransack.result.to_sql).to include "OR"
    end
  end
end
