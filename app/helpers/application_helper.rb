module ApplicationHelper

    TIMEZONE_COUNTRY_MAP = {
        'Asia/Kolkata' => 'India',
        'America/New_York' => 'USA',
        'Europe/London' => 'London',
        'Australia/Sydney' => 'Australia'
      }.freeze
    
      def formatted_time_for_user(user)
        timezone = user.timezone || 'UTC'
        time = Time.current.in_time_zone(timezone)
        country_name = TIMEZONE_COUNTRY_MAP[timezone] || 'Unknown'
        formatted_time = time.strftime("%Y-%m-%d %I:%M %p")
    
        "#{formatted_time} (#{country_name})"
      end


  end
  