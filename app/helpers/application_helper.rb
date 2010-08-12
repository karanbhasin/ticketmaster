module ApplicationHelper
  def ticket_status
     { :Open => 1, :Resolved => 2, :Reopened => 3, :Closed => 4}.freeze
  end

  def priorities
    { :low => 0, :medium => 1, :high =>2 }.freeze
  end

  def actions
    { :Resolved => 0, :Working_as_designed => 1, :Cannot_recreate =>2 }.freeze
  end
  
  def get_key(hash_to_search, value_to_search)
    hash_to_search.each do |key,value|
      return key if value == value_to_search
    end
    nil
  end

  def date_format(d)
     d.strftime("%m/%d/%Y")
  end
end
