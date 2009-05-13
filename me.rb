%w(sinatra/base haml pony).each { |l| require l }

class Me < Sinatra::Base
  EMAIL = ENV['email']
  
  set :root, File.dirname(__FILE__)
  set :app_file, __FILE__
  
  get '/' do
    haml :index
  end
 
  post '/' do
    if params[:message]
      send_mail
      flash[:notice] = "thanks for saying hello"
    end
    
    redirect '/ '
  end

  use_in_file_templates!
  
  private 
    def send_mail
      Pony.mail(:to      => EMAIL, 
                :from    => 'curious@example.com', 
                :subject => 'message from lessis.me', 
                :body    => params[:message]) if ENV['production']
    end
end

__END__

@@ index
!!!
%html
  %head
    %meta{ :name => "keywords", :content => "doug tangren,less,lessisme,simple,code,ruby,java,blog" } 
    %meta{ :name => "description", :content => "less more and more doug" } 
    %meta{ :name => "author", :content => "Doug Tangren" } 
    %title 
      less is me
    %link{ :type => "text/css", :rel => "stylesheet", :href => "css/app.css" }
  %body
    - if flash[:notice]
      #flash
        =flash[:notice]
    %ul#things
      %li
        %h1
          hi. my name is 
          %span{ :class => "vcard" }
            %span{ :class => "fn" }
              Doug
            %a{ :href=>"/", :class => "url hdn" }
              doug
            %span{ :class => "geo" }
              %span{ :class => "latitude", :title => "40.438651" }
                40.777705 
              %span{ :class => "longitude", :title => "-79.929249" }
                -73.947958
            %a{ :class => "email", :href => "mailto:#{Me::EMAIL}", :rel => "email" }
              %span{ :class => "type" }
                pref
                (email me)
      %li
        %h1
          i share 
          %a{ :href => "http://softprops.github.com", :rel => "me" }
            code
      %li
        %h1
          i sometimes
          %a{ :href => "http://www.twitter.com/softprops", :rel => "me" }
            tweet
      %li
        %h1
          not much else to 
          %a{ :href => "mailto:soft@softprops.net", :rel => "hello" }
            say
	
        #new_message
          %form{ :action => "/", :method => "post" }
            %dl
              %dt
                %label{ :for => "message" }
                  so say it for me.
              %dd
                %textarea{ :name => "message", :class => "growable" }
                  Hi. My name is Curious.
            %input{ :type => "submit", :value => "say hello" } 
            %span{ :class => "not" }
              or maybe 
              %a{ :href => "#", :rel => "not" }
                tomorrow
    %hr
    #footer
      %span{ :id => "copy" }
        &copy; &infin;
      %p#important
        &#150;live happily 
        %span.blue 
          &#x2764;
    %script{ :type => "text/javascript", :src => "js/app.js" }