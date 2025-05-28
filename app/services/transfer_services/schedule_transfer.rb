module TransferServices
  class ScheduleTransfer
    def self.call(current_user, params)
      return OpenStruct.new(success?: false, error: 'Data inválida') unless params[:executar_em].present? && Time.parse(params[:executar_em]) > Time.current
      TransferJob.perform_at(Time.parse(params[:executar_em]), current_user.id, params)
      OpenStruct.new(success?: true)
    rescue ArgumentError
      OpenStruct.new(success?: false, error: 'Formato de data inválido')
    end
  end
end