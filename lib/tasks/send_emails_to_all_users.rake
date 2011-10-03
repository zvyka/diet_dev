desc "Lets us send emails to all users"

task :send_welcome_emails => :environment do  
    require 'pony'
    f = File.new('/Users/jon/Sites/mail_pass.txt')
    pass= f.gets
    User.all.each do |user|
        Pony.mail(:from => 'teamdietumd@gmail.com', :to => user.email, :subject => 'Team DIET Welcomes You!', 
                :html_body => "<p>Dear #{user.name}</p> <p> Welcome to our online diet-tracking tool! Your account is now active and ready for you to begin tracking your meals. You may log in at any time using your UID and password at <a href='http://diettracker.umd.edu'>http://diettracker.umd.edu</a>. Please refer to our Help section on our website to familiarize yourself with our tool.</p> <p>Please be on the lookout for a quick survey we will be emailing out in a few days to confirm your entry to the <b>Ipod Touch Raffle</b></p> <p> We thank you for participating in our research study.  </p> <p>Sincerely,</p> <p>Team DIET</p> <p>Gemstone Program,  UMD Honors Program</p> <p>*By virtue of logging into and using this diet tracker, you agree to the terms and conditions as listed at http://diettracker.umd.edu/terms *</p>",
                :body => "Dear #{user.name},

                Welcome to our online diet-tracking tool! Your account is now active and ready for you to begin tracking your meals. You may log in at any time using your UID and password at http://diettracker.umd.edu. Please refer to our Help section on our website to familiarize yourself with our tool. 
            
                Please be on the lookout for a quick survey we will be emailing out in a few days to confirm your entry to the **Ipod Touch Raffle.**

                We thank you for participating in our research study. 

                Sincerely, 
                	Team DIET
                	Gemstone Program, A. James Clark School of Engineering 

                	*By virtue of logging into and using this diet tracker, you agree to the terms and conditions as listed at http://diettracker.umd.edu/terms *" ,:via => :smtp, :via_options => {
          :address              => 'smtp.gmail.com',
          :port                 => '587',
          :enable_starttls_auto => true,
          :user_name            => 'teamdietumd@gmail.com',
          :password             => pass,
          :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
          :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
        })
  end
end

task :send_survey_emails => :environment do  
    require 'pony'
    f = File.new('/Users/jon/Sites/mail_pass.txt')
    pass= f.gets
    count = 0
    User.all.each do |user|
      count = count +1
      if count % 50 == 0
        puts "****** Sleeping for a minute...zzzzzzzzzzzz******"
        sleep 60 #sleep for 60 seconds after every 50 emails sent
        puts"******* Done sleeping! Let's get to it! **********"
      end
        Pony.mail(:from => 'teamdietumd@gmail.com', :to => user.email, :subject => 'Deadline extended on Team DIET Survey', 
                :html_body => "<p>Dear #{user.name}</p> <p>If you have already taken the preliminary survey you may disregard this email. Thank you so much for choosing to participate in our study.</p> <p><b>We have recently corrected some technical problems, so if you were previously unable to complete the survey you will now have access to it. If you have not yet found time to complete the survey, now is an excellent time to do so!</b></p> <p>To fill out the survey, please click the link below or copy and paste the following link to your internet browser:</p> <p><a href=' https://docs.google.com/a/terpmail.umd.edu/spreadsheet/viewform?hl=en_US&formkey=dFZvUXc5Z0dHaGFSZ01wNHZQS0FldFE6MQ#gid=0'>https://docs.google.com/a/terpmail.umd.edu/spreadsheet/viewform?hl=en_US&formkey=dFZvUXc5Z0dHaGFSZ01wNHZQS0FldFE6MQ#gid=0</a></p> <p>The survey will take less than ten minutes, and you will be officially entered in the raffle to win the iPod touch. Due to this technical problem, the deadline for submitting the survey has been extended to <b>Friday, October 7, 2011 at noon.</b></p> <p>Sincerely,</br>Team DIET</br><a href='mailto:teamdietumd@gmail.com'>teamdietumd@gmail.com</a></p> <br/><p>This research has been approved by the Institutional Review Board (IRB) at the University of Maryland (IRB #11-0312).</p>  <p>Thank you for your time and participation.  Please feel free to contact us with any questions, comments, or suggestions.</p>",
                :body => "Dear #{user.name},

                If you have already taken the preliminary survey you may disregard this email. Thank you so much for choosing to participate in our study. 
            
                We have recently corrected some technical problems, so if you were previously unable to complete the survey you will now have access to it. If you have not yet found time to complete the survey, now is an excellent time to do so!
                
                To fill out the survey, please click the link below or copy and paste the following link to your internet browser:
                
                https://docs.google.com/a/terpmail.umd.edu/spreadsheet/viewform?hl=en_US&formkey=dFZvUXc5Z0dHaGFSZ01wNHZQS0FldFE6MQ#gid=0
                
                The survey will take less than ten minutes, and you will be officially entered in the raffle to win the iPod touch. Due to this technical problem, the deadline for submitting the survey has been extended to Friday, October 7, 2011 at noon.

                Sincerely, 
                Team DIET
                teamdietumd@gmail.com
                
                This research has been approved by the Institutional Review Board (IRB) at the University of Maryland (IRB #11-0312).
                                              
                Thank you for your time and participation.  Please feel free to contact us with any questions, comments, or suggestions." ,:via => :smtp, :via_options => {
          :address              => 'smtp.gmail.com',
          :port                 => '587',
          :enable_starttls_auto => true,
          :user_name            => 'teamdietumd@gmail.com',
          :password             => pass,
          :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
          :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
        })
        puts "Sent mail to User #{user.id}, name: #{user.name}, email: #{user.email}"
  end
end