class Practicedetail < ActiveRecord::Base
  establish_connection :development

  belongs_to :practices
  belongs_to :users

end
