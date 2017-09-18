class HomeController < ApplicationController
  def index; end

  def getMonthBCN(month, year)
    require 'savon'

    client = Savon.client wsdl: 'https://servicios.bcn.gob.ni/Tc_Servicio/ServicioTC.asmx?WSDL', convert_request_keys_to: :camelcase

    message = { Ano: year, Mes: month }

    response = client.call(:recupera_tc_mes, message: message)

    result = response.body

    tasa = result[:recupera_tc_mes_response] [:recupera_tc_mes_result]

    tasa_info = tasa[:detalle_tc][:tc]

    $tasa_mes = tasa_info

    $tasa_dia = nil

    redirect_to root_path

    # respond_to do |format|
    #   format.html { redirect_to root_path, notice: 'Tasa de cambio (mes): ' + tasa_info }
    # end
  end

  def getDayBCN(day, month, year)
    require 'savon'

    client = Savon.client wsdl: 'https://servicios.bcn.gob.ni/Tc_Servicio/ServicioTC.asmx?WSDL', convert_request_keys_to: :camelcase

    message = { Ano: year, Mes: month, Dia: day }

    response = client.call(:recupera_tc_dia, message: message)

    result = response.body

    tasa = result[:recupera_tc_dia_response] [:recupera_tc_dia_result]

    $tasa_dia = tasa

    $tasa_mes = nil

    redirect_to root_path

    # respond_to do |format|
    #   format.html { redirect_to root_path, notice: 'Tasa de cambio: ' + tasa.to_s }
    # end
  end

  def getBCN
    opcion = begin
               params[:opcion]
             rescue
               nil
             end

    ano = params['fecha(1i)'].to_i
    mes = params['fecha(2i)'].to_i
    dia = params['fecha(3i)'].to_i

    if opcion == '0'
      getDayBCN(dia, mes, ano)

    else
      getMonthBCN(mes, ano)

  end
end
end
