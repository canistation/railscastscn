OmniAuth.config.on_failure do |env|
  [302, {'Location' => "/auth/#{env['omniauth.error.strategy'].name}/failure?message=#{env['omniauth.error.type']}"},["Redirecting..."]]
end
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, 'd9847bfd661eac3893de', '0b3fcab931872897abee4dcbd1720ee657dd1a46'
  provider :identity, :fields => [:nickname, :email]#, on_failed_registration: UsersController.action(:new)
end
