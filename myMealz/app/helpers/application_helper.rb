module ApplicationHelper


  def country_options
    [
      ['Afganistan'],
      ['Australia'],
      ['Another one']
    ]
  end

  def practiceID_options
    practiceid_array = Array.new()



    Practice.find_each do |element|
      practiceid_array.push(element.name)
    end

    return practiceid_array
  end
end
