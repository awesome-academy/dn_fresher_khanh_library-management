Rails.application.config.content_security_policy do |policy|
  # These are some sane defaults
  policy.default_src :self, :https
  policy.font_src    :self, :https, :data
  policy.img_src     :self, :https, :data
  policy.object_src  :none
  policy.script_src  :self, :https
  policy.style_src   :self, :https

  # This fixes rack mini profiler
  policy.script_src_elem :self, :unsafe_inline if Rails.env.development?
  policy.style_src_elem  :self, :unsafe_inline if Rails.env.development?
  policy.connect_src *policy.connect_src, :self if Rails.env.development?
end
