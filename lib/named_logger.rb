require 'active_support'

class NamedLogger
  # rubocop:disable MethodMissing
  def self.method_missing name, *params
    if params.nil?
      super
    else
      @loggers ||= {}
      @loggers[name] ||= build_logger name
    end
  end
  # rubocop:enable MethodMissing

  def self.respond_to_missing? _method_name, _include_private = false
    true
  end

  def self.build_logger name
    logfile = File.open("#{root_path}log/#{name}.log", 'a')
    logfile.sync = true

    logger = NamedLoggerProxy.new ActiveSupport::Logger.new(logfile)
    logger.formatter = CommonLogFormatter.new
    logger
  end

  def self.root_path
    if defined? Rails
      "#{Rails.root}/"
    elsif defined? Hanami
      "#{Hanami.root}/"
    end
  end
end

class NamedLoggerProxy < SimpleDelegator
  def info text, *params
    puts text unless Rails.env.test?
    super
  end
end

class CommonLogFormatter < Logger::Formatter
  def call severity, time, _progname, msg
    formatted_time = time.strftime '%d %b %H:%M'

    if severity == 'INFO'
      "[#{formatted_time}] #{msg2str msg}\n"
    else
      formatted_severity = format '%5s', severity
      "[#{formatted_time}] #{formatted_severity} - #{msg2str msg}\n"
    end
  end
end

# class ColouredLogFormatter < Logger::Formatter
  # SEVERITY_TO_COLOR_MAP = {
    # 'DEBUG' => '32',
    # 'INFO' => '0;37',
    # 'WARN' => '35',
    # 'ERROR' => '31',
    # 'FATAL' => '31',
    # 'UNKNOWN' => '37'
  # }

  # def call severity, time, _progname, msg
    # color = SEVERITY_TO_COLOR_MAP[severity]

    # format(
      # "\033[0;37m[%s] \033[#{color}m%5s - %s\033[0m\n",
      # time.strftime('%d %b %H:%M'),
      # severity,
      # msg2str(msg)
    # )
  # end
# end
