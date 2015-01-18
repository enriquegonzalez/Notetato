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

# def active_navigation(path)
#   "navigation__item--active navigation__item__link--active" if params[:controller] == path
# end
