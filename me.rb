%w(sinatra/base pony).each { |l| require l }

class Me < Sinatra::Base
  
  set :static, true # enable/disable static file routes
  
  set :app_file, __FILE__ #used to calculate the default :root, :public, and :views options 
  
  get '/' do
    haml :index
  end
 
  post '/' do
    if params[:message]
      #Pony.mail(:to      => 'd.tangren@gmail.com', 
      #          :from    => 'curious@example.com', 
      #          :subject => 'message from lessis.me', 
      #          :body    => params[:message])
      flash[:notice] = "thanks for saying hello"
    end
    redirect '/ '
  end

  use_in_file_templates!
  
end

__END__

@@ index
!!!
%html
  %head
    %title 
      less is me
    %link{ :type=>"text/css", :rel=>"stylesheet", :href=>"/stylesheets/app.css" }
  %body
    - if flash[:notice]
      #thanks
        =flash[:notice]
    %ul#list
      %li
        %h1
          hi. my name is 
          %span{:class=>"vcard"}
            %span{:class=>"fn"}
              Doug
            %a{:href=>"/", :class=>"url hdn"}
              doug
            %span{:class=>"geo"}
              %span{:class=>"latitude", :title=>"40.438651"}
                40.438651
              %span{:class=>"longitude", :title=>"-79.929249"}
                -79.929249
            %a{:class=>"email", :href=>"mailto:soft@softprops.net", :rel=>"email"}
              %span{:class=>"type"}
                pref
                (email me)
      %li
        %h1
          i share 
          %a{:href=>"http://softprops.github.com", :rel=>"me"}
            code
      %li
        %h1
          i sometimes
          %a{:href=>"http://www.twitter.com/softprops", :rel=>"me"}
            tweet
      %li
        %h1
          not much else to 
          %a{:href=>"mailto:soft@softprops.net", :rel=>"hello"}
            say
	
        #new_message
          %form{:action=>"/", :method=>"post"}
            %dl
              %dt
                %label{:for=>"message"}
                  so say it for me.
              %dd
                %textarea{:name=>"message", :class=>"growable"}
                  Hi. My name is Curious.
            %input{:type=>"submit", :value=>"Send your hello!"} 
            %span{:class=>"not"}
              or 
              %a{:href=>"#", :rel=>"not"}
                not
    %hr
    #footer
      %span{:id=>"copy"}
        &copy; &infin;
      %br 
      %a{:href=>"http://www.last.fm/user/softprops", :rel=>"me", :class=>"url"}
        listen
      &#9679;
      %a{:href=>"http://www.twitter.com/softprops", :rel=>"me", :class=>"url"}
        follow
      %p#important
        &#150;live happily
    %script{:type=>"text/javascript", :src=>"./javascripts/app.js"}