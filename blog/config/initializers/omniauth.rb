require 'omniauth-github'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, 'd9847bfd661eac3893de', '0b3fcab931872897abee4dcbd1720ee657dd1a46'
  #provider :github, 'd78181e1ec709f32d844', '7fd79b37dd8a4423c5989b6ae6d4fe358af11dc'
end
