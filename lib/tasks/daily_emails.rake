namespace :emails do
  desc "Send thank-you email to everyone who visited the site today"
  task send_daily_thank_you: :environment do
    users = User.where(last_visited_at: Date.current.all_day)

    users.find_each do |user|
      VisitMailer.daily_thank_you(user).deliver_later
      puts "Queued thank-you email for #{user.email}"
    end

    puts "Done. #{users.count} email(s) queued."
  end
end
