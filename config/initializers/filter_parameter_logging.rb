# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [:password, :email, :how_do_you_feel, :why, :what_went_well, :user_id]

