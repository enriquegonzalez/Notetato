module ApplicationHelper
  def flash_class(type)
    case type
      when "alert"
        "alert"
      when "notice"
        "success"
      else
        "warning"
    end
  end
end
