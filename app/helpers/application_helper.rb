module ApplicationHelper
  def has_error(obj, field)
    return "" if obj.blank? or obj.keys.blank? or field.blank? or !obj.keys.include?(field)
    return "item bad"
  end

  def print_error(obj, field)
    return "" if obj.blank? or obj.keys.blank? or field.blank? or !obj.keys.include?(field)
    return "<div class=\"alert\">#{obj[field].uniq.join(" ")}</div>".html_safe
  end

  def list_for_companies
    Company.all.map{ |cp| [cp.name, cp.id] }
  end
end
