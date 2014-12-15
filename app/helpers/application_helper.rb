module ApplicationHelper
  def flash_class(type)
    case type
      when "alert"
        "message--alert"
      when "notice"
        "message--success"
      else
        "message--warning"
    end
  end
end
