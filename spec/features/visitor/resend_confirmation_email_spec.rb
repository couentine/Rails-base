require "rails_helper"

feature "Resend Confirmation Email" do
  let(:user) { create :user, :not_confirmed }

  scenario "Visitor resends email confirmation instructions" do
    visit new_user_confirmation_path

    fill_in "Enter your email address", with: user.email
    click_button "Resend confirmation instructions"

    open_email(user.email)

    expect(current_email.header("Subject")).to eq("Confirmation instructions")
    expect(current_email).to have_content(user.full_name)
  end
end
