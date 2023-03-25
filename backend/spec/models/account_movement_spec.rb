# frozen_string_literal: true

# == Schema Information
#
# Table name: account_movements
#
#  id            :bigint           not null, primary key
#  identifier    :string           not null
#  movement_type :integer          default(0), not null
#  amount        :float            default(0.0), not null
#  currency      :integer          default(0), not null
#  description   :string           default(""), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  accounts_id   :bigint           not null
#
require 'rails_helper'

RSpec.describe AccountMovement, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
