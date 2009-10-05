ActionController::Routing::Routes.draw do |map|
  map.convert_all_bookmarks '/bookmark_imports/convert_all', :controller => 'bookmark_imports', :action => 'convert_all'
  map.convert_bookmark '/bookmark_imports/:id/convert', :controller => 'bookmark_imports', :action => 'convert'
  map.import_bookmarks '/bookmarks/import', :controller => 'bookmark_imports', :action => 'import'
  map.do_bookmark_import '/bookmark_imports/do_import', :controller => 'bookmark_imports', :action => 'do_import'
  map.resources :bookmark_imports

  map.resources :codes

  map.settings '/settings', :controller => 'users', :action => 'settings'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users

  map.resource :session

  map.resources :comments
  
  map.bookmarks_by_tag '/bookmarks/tags/:tag', :controller => 'bookmarks', :action => 'tags'
  map.bookmark_tag_cloud '/bookmarks/tags', :controller => 'bookmarks', :action => 'tags'
  #map.bookmark_tag_cloud '/bookmarks/tagcloud', :controller => 'bookmarks', :action => 'tag_cloud'
  map.connect '/bookmarks/inc_content_length', :controller => 'bookmarks', :action => 'inc_content_length'
  map.connect '/bookmarks/dec_content_length', :controller => 'bookmarks', :action => 'dec_content_length'
  map.resources :bookmarks, :except => :show

  map.bookmarks_language '/bookmarks/:lang', :controller => 'bookmarks', :action => 'index'
  
  map.with_options :controller => "bookmarks" do |bookmarks|
   bookmarks.bookmark '/bookmarks/:lang/:bookmark_name/', :action => "show", :conditions => { :method => :get }
  end
  
  map.resources :languages

  map.resources :categories
  
  map.root :controller => 'dashboard'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
