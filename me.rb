%w(sinatra/base haml pony).each { |l| require l }

class Me < Sinatra::Base
  EMAIL = ENV['EMAIL_TO'] || 'd.tangren@gmail.com'
  EMAIL_REGEX = /^[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  
  configure do
    set :run, false
    set :root, File.dirname(__FILE__)
    set :app_file, __FILE__
    set :static, true
    set :site, ENV['SITE_NAME'] || 'lessis.me'
  end
  
  get '/' do
    haml :index
  end
 
  post '/' do
    if params[:message]
      if valid?
        begin
          send_mail!
          flash[:notice] = "thanks for saying hello"
        rescue Exception => e
          puts e
          flash[:err] = "Opps, some thing is missing"
        end
      end
    end
    redirect '/ '
  end

  not_found do
    haml :not_found
  end
  
  use_in_file_templates!
  
  private 

    def send_mail!
      puts "#sent_mail params => #{params.inspect} valid? => #{valid?}"
      Pony.mail({
        :to      => EMAIL, 
        :from    => params[:email], 
        :subject => "new message from %s" % options.site, 
        :body    => params[:message]}) if valid?
    end
  
    def valid?
      validate_message
      validate_email
      flash[:err].nil?
    end
    
    def validate_message
      msg = params[:message]
      flash[:err] = "&gt; There&apos;s more to say than that<br/>" if msg.blank?
    end
    
    def validate_email
      valid = params['email'] =~ EMAIL_REGEX
      flash[:err] = [flash[:err], "&gt; That email won&apos;t fly"].join('') if !valid
    end
end

__END__

@@ layout
!!!
%html{html_attrs}
  %head
    %meta{ "http-equiv" => "Content-Type", :content => "text/html;charset=utf-8" }
    %meta{ :name => "keywords", :content => "doug tangren,less,lessisme,simple,code,ruby,java" } 
    %meta{ :name => "description", :content => "less more and more doug" } 
    %meta{ :name => "author", :content => "Doug Tangren" } 
    %title 
      lessis (me)
    %link{ :type => "text/css", :rel => "stylesheet", :href => "/css/app.css" }
  %body
    = yield
    #footer
      %span{ :id => "copy" }
        &copy; little
      %p#important
        &#150;live happily 
        %span.color 
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
      
@@ not_found
%a{ :href => '/' }
  %h1.not-found
    !_.found?

@@ index
- if flash[:notice] || flash[:err]
  #flash
    = flash[:notice] || flash[:err]
    
%ul#things
  %li
    %h1
      hi. i&apos;m
      %a{ :href=> "/" }
        doug
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
      i sometimes
      %a{ :href => "http://www.twitter.com/softprops", :rel => "me" }
        tweet

  %li.say
    %h1
      say  
      %a{ :href => "mailto:#{Me::EMAIL}", :rel => "hello" }
        hello
    #new-message
      %form{ :action => "/", :method => "post" }
        
        %textarea{ :rows => 3, :cols => 10, :name => "message", :id => "message", :class => "growable" }
          Hi. My name is Curious.
        
        %label{ :for => "email" }
          your email address is
        %input{ :type => "text", :name => "email", :id => "email", :value => "..." }
          
        %input{ :class => "btn", :type => "submit", :value => "send it" } 
        
        %span{ :class => "not" }
          or
          %a{ :href => "#", :rel => "not" }
            not