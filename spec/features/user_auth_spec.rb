require 'spec_helper'

	feature "User Authentication" do
		scenario 'Signing in via form' do
			user = FactoryGirl.create(:user)
			visit '/'
			click_link 'Sign in'
			fill_in 'Email', with: user.email
			fill_in 'Password', with: user.password
			click_button "Sign in"
			expect(page).to have_content("Signed in successfully.")
		end

		scenario 'User log out' do
			visit '/'
			click_link 'Sign out'
			expect(page).to have_content("Logged out!")
		end

		scenario 'Not logged user is redirected to signin_url with a info message when access to protected area' do
			visit '/orders'
			expect(page.current_url).to eql(signin_url)
			expect(page).to have_content('You need to sign in or sign up before continuing')
		end

	end