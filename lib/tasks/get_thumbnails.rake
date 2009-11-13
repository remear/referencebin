namespace :thumbs do
  desc "Retreive missing thumbnails for bookmarks"
  task(:get => :environment) do
    bookmarks = Bookmark.find(:all, :conditions => "thumb_file_name is NULL")
    
    for bookmark in bookmarks
      puts bookmark.title
      
      #@bookmark = Bookmark.find(bookmark_id)
      require 'page_glimpse'
      require 'ftools'

      PageGlimpse.developer_key = '85fd3e91a4874a31c048797113c9bf8e'

      if PageGlimpse.exist?(bookmark.url)
        image = PageGlimpse.get(bookmark.url, :size => "large")

        fileext = File.extname(image.filename)
        filename = image.filename[0, image.filename.length - 12] + fileext
        
        # Save the transmitted binary (image.content) as a local file
        File.open("#{RAILS_ROOT}/public/assets/thumbs/large_#{filename}", File::CREAT|File::WRONLY|File::TRUNC) do |file|
          file.write image.content
        end

        attrs = {"thumb_file_name" => filename, "thumb_content_type" => image.content_type, "thumb_file_size" => image.content_length, "thumb_updated_at" => Time.now.to_s(:db)}

        bookmark.update_attributes(attrs)
        image = PageGlimpse.get(bookmark.url, :size => "medium")

        # Save the transmitted binary (image.content) as a local file
        File.open("#{RAILS_ROOT}/public/assets/thumbs/medium_#{filename}", File::CREAT|File::WRONLY|File::TRUNC) do |file|
          file.write image.content
        end

        image = PageGlimpse.get(bookmark.url)

        # Save the transmitted binary (image.content) as a local file
        File.open("#{RAILS_ROOT}/public/assets/thumbs/small_#{filename}", File::CREAT|File::WRONLY|File::TRUNC) do |file|
          file.write image.content
        end

      else
        PageGlimpse.queue(bookmark.url)
        #raise "failed to get screenshot for bookmark##{@bookmark.id} url: #{@bookmark.url}"
        # and then try back later ...
      end
    end
  end
end