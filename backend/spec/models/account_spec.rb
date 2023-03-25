# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id             :bigint           not null, primary key
#  account_number :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  clients_id     :bigint           not null
#
require 'rails_helper'

RSpec.describe Account, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
