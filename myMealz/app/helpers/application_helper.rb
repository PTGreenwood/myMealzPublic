# -*- encoding : utf-8 -*-
module ApplicationHelper

  #helper_method :resource_name, :resource, :devise_mapping, :resource_class

  #def practiceID_options
  #  practiceid_array = Array.new()

  #  Practice.find_each do |element|
  #    practiceid_array.push(element.name)
  #  end

  #  return practiceid_array
  #end

  def resource_name
   :user
  end

  def resource_class
    User
  end

  def resource
   @resource ||= User.new
  end

  def devise_mapping
   @devise_mapping ||= Devise.mappings[:user]
  end

end
