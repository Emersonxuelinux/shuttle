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

require 'rails_helper'

RSpec.describe Comment do
  context "[email notifications]" do
    context "after_create" do
      it "subscribes the commenter to the issue emails; and sends an email to the subscription list when a new comment is created" do
        issue = FactoryBot.create(:issue, subscribed_emails: ["test@example.com"])
        comment = FactoryBot.build(:comment, issue: issue)
        ActionMailer::Base.deliveries.clear

        comment.save!
        expect(ActionMailer::Base.deliveries.size).to eql(1)
        email = ActionMailer::Base.deliveries.first

        expect(email.to).to eql(["test@example.com"])
        expect(email.subject).to include("[Shuttle] Sancho Sample wrote a new comment to an issue")
      end
    end
  end
end
