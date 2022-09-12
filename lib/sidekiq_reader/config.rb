module SidekiqReader
  class Config
    PARAMS = %i[config_file sidekiq_url basic_username basic_password]
    attr_reader *PARAMS

    def initialize(options = {})
      PARAMS.each do |param|
        instance_variable_set("@#{param}", options.fetch(param, from_config(param)))
      end
    end

    private

    def from_config(param)
      if param == :config_file
        ENV[param.to_s.upcase] || File.join(Dir.home, '.sqrrc')
      else
        ENV[param.to_s.upcase] || rc_config(param)
      end
    end

    def rc_config(param)
      load_rc.fetch(param, nil)
    end

    def load_rc
      return @load_rc if @load_rc
      raise "Can't load config" unless File.exists?(config_file)

      @load_rc = File.read(config_file).lines.map { |l| l.chomp.split("=", 2) }.to_h.transform_keys(&:to_sym)
    end
  end
end
