class Contract < ActiveRecord::Base
  establish_connection :development

  belongs_to :users
  belongs_to :clients

end
