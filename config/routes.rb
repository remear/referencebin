ActionController::Routing::Routes.draw do |map|
  map.resources :user_sessions

  map.resources :users

  #jots
  map.resources :jots

  #questions  
  
  #users & sessions
  map.resources :users
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.register "register", :controller => "users", :action => "new"
  map.activate "activate/:id", :controller => 'user_sessions', :action => 'verify'
  map.resources :user_sessions
  
  #administration
  #map.namespace :administration do |admin|
    # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
    #admin.resources :users, :member => { :suspend => :put, :unsuspend => :put, :purge => :delete }
  #end
  #map.resources :users, :member => { :suspend => :put, :unsuspend => :put, :purge => :delete }

  #bookmark imports
  map.convert_all_bookmarks '/bookmark_imports/convert_all', :controller => 'bookmark_imports', :action => 'convert_all'
  map.convert_bookmark '/bookmark_imports/:id/convert', :controller => 'bookmark_imports', :action => 'convert'
  map.import_bookmarks '/bookmarks/import', :controller => 'bookmark_imports', :action => 'import'
  map.do_bookmark_import '/bookmark_imports/do_import', :controller => 'bookmark_imports', :action => 'do_import'
  map.resources :bookmark_imports

  #users & sessions
  map.resources :users, :path_prefix => '/administration'
  
  #search
  map.search '/search', :controller => 'search', :action => 'index'
  #map.search '/search/:query', :controller => 'search', :action => 'query'
  
  #settings
  map.settings '/settings', :controller => 'users', :action => 'edit'
  
  #comments
  map.resources :comments
  
  #bookmarks
  map.bookmark_post_question '/bookmarks/:id/postquestion', :controller => 'bookmarks', :action => 'post_question'
  map.bookmarks_by_tag '/bookmarks/tags/:tag', :controller => 'bookmarks', :action => 'tags'
  map.bookmark_tag_cloud '/bookmarks/tags', :controller => 'bookmarks', :action => 'tags'
  map.connect '/bookmarks/inc_content_length', :controller => 'bookmarks', :action => 'inc_content_length'
  map.connect '/bookmarks/dec_content_length', :controller => 'bookmarks', :action => 'dec_content_length'
  map.resources :bookmarks, :except => :show
  map.bookmarks_language '/bookmarks/:lang', :controller => 'bookmarks', :action => 'index'
  map.with_options :controller => "bookmarks" do |bookmarks|
   bookmarks.bookmark '/bookmarks/:lang/:bookmark_name/', :action => "show", :conditions => { :method => :get }
  end
  
  #languages
  map.resources :languages
  
  #administration
  ##users are mapped with path_prefix of /administration
  map.administration '/administration', :controller => 'administration', :action => 'index'
  map.administration_tools '/administration/tools', :controller => 'administration', :action => 'tools'
  map.administration_databases '/administration/databases', :controller => 'administration', :action => 'databases'
  map.namespace :administration do |admin|
    # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
    admin.resources :reports
  end
  
  
  #pages
  map.credits '/credits', :controller => 'pages', :action => 'credits'
  map.termsofuse '/termsofuse', :controller => 'pages', :action => 'termsofuse'
  map.privacypolicy '/privacypolicy', :controller => 'pages', :action => 'privacypolicy'
  
  #root
  map.root :controller => 'bookmarks'
  
  #derault routes
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
