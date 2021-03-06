# Copyright 2014 Square Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

class IncreaseAPITokenSize < ActiveRecord::Migration
  def change
    remove_column :projects, :api_token
    add_column    :projects, :api_token, "character(240)"
    add_index     :projects, :api_token, unique: true

    Project.all.each do |project|
      project.create_api_token
      project.save
    end

    change_column_null(:projects, :api_token, false)
  end
end
