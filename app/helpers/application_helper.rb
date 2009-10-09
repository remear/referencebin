# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include TagsHelper
  
  def get_languages
    @languages = Language.all(:select => "name, permalink", :order => 'name')
  end
  
  def language_name(id)
    lang = Language.find(id)
    unless lang.nil?
      lang.name
    end
  end
  
  def highlight_lang(language)
	  case language
    when "rubyonrails"
      return "ruby"
    when "csharp"
      return "plain"
    else
	    return language
    end
	end
end
