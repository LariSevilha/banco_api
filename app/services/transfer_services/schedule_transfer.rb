module TransferServices
  class ScheduleTransfer
    def self.call(current_user, params)
      scheduled_at_string = params[:executar_em]

      unless scheduled_at_string.present?
        return OpenStruct.new(success?: false, error: 'Data de agendamento é obrigatória')
      end

      begin
        scheduled_time = Time.zone.parse(scheduled_at_string)
 
        if scheduled_time.nil?
          return OpenStruct.new(success?: false, error: 'Formato de data inválido ou data não reconhecida.')
        elsif scheduled_time > Time.current 
          TransferJob.set(wait_until: scheduled_time).perform_later(current_user.id, params.except(:executar_em))  
          return OpenStruct.new(success?: true)
        else
          return OpenStruct.new(success?: false, error: 'A data/hora agendada deve estar no futuro.')
        end
      rescue ArgumentError => e
        return OpenStruct.new(success?: false, error: "Formato de data inválido: #{e.message}")
      end
    end
  end
end