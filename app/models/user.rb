class User < ActiveRecord::Base
	has_secure_password
	validates :name, :email, presence: true
	validates :email, uniqueness: true, email: true
	validates :password, length: { minimum: 8 }

	validate :password_complexity

  def password_complexity
	  if password.present? and not password.match(/^(?=.*[a-z])(?=.*\d)(?=.*(_|[^\w])).+$/)
	    errors.add :password, "must include at least one one underscore or non-word character and one digit"
	  end
	end
end
