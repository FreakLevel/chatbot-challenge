# == Schema Information
#
# Table name: bot_paths
#
#  id             :bigint           not null, primary key
#  initial        :boolean          default(FALSE), not null
#  identifier     :string           not null
#  message        :text             default(""), not null
#  input          :string
#  options        :jsonb
#  finish         :boolean          default(FALSE), not null
#  method_name    :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  next_step_id   :bigint
#  parent_step_id :bigint
#
require 'rails_helper'

RSpec.describe BotPath, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
