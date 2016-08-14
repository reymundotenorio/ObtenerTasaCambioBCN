class HomeController < ApplicationController


  def index
  end

  def getMonthBCN (mes, ano)

  end

  def getDayBCN (day, month, year)
    require 'savon'
    client = Savon.client wsdl: 'https://servicios.bcn.gob.ni/Tc_Servicio/ServicioTC.asmx?WSDL', convert_request_keys_to: :camelcase

    message = { Ano: year , Mes: month, Dia: day }

    response = client.call(:recupera_tc_dia, message: message)

    result = response.body
    
    tasa = result[:recupera_tc_dia_response] [:recupera_tc_dia_result]

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Tasa de cambio: '+tasa.to_s }
    end

  end

  def getBCN

    opcion = params[:opcion] rescue nil

    ano = params["fecha(1i)"].to_i
    mes = params["fecha(2i)"].to_i
    dia = params["fecha(3i)"].to_i

    getDayBCN(dia, mes, ano)
  end

end
