require 'js-routes'

namespace :js_routes do
  desc 'Generate js routes for webpack'
  task generate: :environment do
    routes_dir = File.join('app', 'javascript', 'routes')
    FileUtils.mkdir_p(Rails.root.join(routes_dir))
    file_name = File.join('routes', 'ApiRoutes.js')
    JsRoutes.generate!(file_name, camel_case: true)
  end
end
