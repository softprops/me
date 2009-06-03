%w(sinatra/base haml pony pp).each { |l| require l }

class Me < Sinatra::Base
  EMAIL = ENV['EMAIL_TO']
  EMAIL_REGEX = /^[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  
  set :run, false
  set :root, File.dirname(__FILE__)
  set :app_file, __FILE__
  
  get '/' do
    haml :index
  end
 
  post '/' do
    if params[:message]
      if send_mail!
        flash[:notice] = "thanks for saying hello"
      end
    end
    
    redirect '/ '
  end

  use_in_file_templates!
  
  private 

    def send_mail!
      Pony.mail(:to      => EMAIL, 
                :from    => params[:email], 
                :subject => 'message from lessis.me', 
                :body    => params[:message]) if send_mail?
    end
    
    def send_mail?
      valid_env? && valid_form?
    end

    def valid_form?
      valid_message? && valid_email?
    end
    
    def valid_message?
      msg = params[:message]
      flash[:err] = "you might want to say a bit more than that next time <br/>" if msg.blank?
      msg
    end
    
    def valid_email?
      valid = params['email'] =~ EMAIL_REGEX
      flash[:err]= [flash[:err], "i'm not smart enough to know what “#{params['email']}” means"].join('') if !valid
      valid
    end
    
    def valid_env?
      ENV['production']
      true
    end
end

__END__

@@ mine
%ul
  %li
    sinatra.version
    = Sinatra::VERSION
  %li
    env.email
    = Me::EMAIL
  %li
    rack.env
    = ENV.inspect

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
    - if flash[:notice] || flash[:err]
      #flash
        = flash[:notice] || flash[:err]
        
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
          i type
          %a{ :href => "http://softprops.github.com", :rel => "me" }
            code
      %li
        %h1
          i hear
          %a{ :href => "http://last.fm/user/softprops", :rel => "me" }
            music
      %li
        %h1
          i sometimes
          %a{ :href => "http://www.twitter.com/softprops", :rel => "me" }
            tweet
      %li.say
        %h1
          say  
          %a{ :href => "mailto:#{Me::EMAIL}", :rel => "hello" }
            hello
        #new_message
          %form{ :action => "/", :method => "post" }
            
            %textarea{ :name => "message", :id => "message", :class => "growable" }
              Hi. My name is Curious.
            
            %label{ :for => "email" }
              my email address is
            %input{ :type => "text", :name => "email", :id => "email", :value => "..." }
              
            %input{ :class => "btn", :type => "submit", :value => "send today" } 
            
            %span{ :class => "not" }
              or
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
      %div#lost
        4 8 15 16 23 42
    %script{ :type => "text/javascript", :src => "js/app.js" }
    
    %script{ :type =>"text/javascript" }
      var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
      document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
    %script{ :type => "text/javascript" }
      var pageTracker = _gat._getTracker("UA-9140324-1");
      pageTracker._trackPageview();
    