module ApplicationHelper
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    return markdown.render(text)
  end
  def soundcloud(username)
    sc = Soundcloud.new(:client_id => "27bbad2a1812c45ba7e8e3a4a8bc1715")
    url = "https://soundcloud.com/#{username}"
    tracks = sc.get('/oembed', :url => url, :show_comments => "false" )
    return tracks['html']
  end
end
