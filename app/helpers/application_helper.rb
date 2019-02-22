module ApplicationHelper
  def admin_layout_template
    "admin"
  end

  def current_class?(frt_path, snd_path)
    return 'active' if request.path == frt_path or request.path == snd_path
    ''
  end
end
