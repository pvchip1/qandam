namespace :dev do

  DEFAULT_PASSWORD = 123456

  desc "Setting dev environment "
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Drop database...") { %x(bin/rails db:drop) }
      show_spinner("Create database...") { %x(bin/rails db:create) }
      show_spinner("Migrate database...") { %x(bin/rails db:migrate) }
      show_spinner("Creating Admins..."){ %x(bin/rails dev:add_default_admin) }
      show_spinner("Creating Users...") { %x(bin/rails dev:add_default_user) }
    else
      puts 'is this not developmnent enviroment!'
    end
  end
  desc "Assets build "
  task assets: :environment do
    if Rails.env.development?
      show_spinner("cleaning assets...") { %x(bin/rails assets:clean) }
      show_spinner("clobbering assets...") { %x(bin/rails assets:clobber) }
      show_spinner("precompile assets...") { %x(bin/rails assets:precompile) }
    else
      puts 'is this not developmnent enviroment!'
    end
  end

  desc 'Add default Admin'
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc 'Add default user'
  task add_default_user: :environment do
    User.create!(
      email: 'user@user.com.br',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  private

  def show_spinner(msg_start, msg_end = 'Finish')
    spinner = TTY::Spinner.new(" [:spinner] #{ msg_start }" )
    spinner.auto_spin
    yield
    spinner.success("#{msg_end}")
  end

end
