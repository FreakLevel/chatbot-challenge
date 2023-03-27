# frozen_string_literal: true

class CurrencyService
  API_URL = 'https://mindicador.cl/api'

  class << self
    def economic_indicators
      response = RestClient.get(API_URL)
      indicators = JSON.parse(response.body)
      data = {}
      data[:dolar] = { code: 'USD', value: indicators['dolar']['valor'] }
      data[:euro] = { code: 'EUR', value: indicators['euro']['valor'] }
      data[:uf] = { code: 'UF', value: indicators['uf']['valor'] }
      data[:utm] = { code: 'UTM', value: indicators['utm']['valor'] }
      data
    end

    def eur_value
      response = RestClient.get("#{API_URL}/euro")
      data = JSON.parse(response.body)
      data['serie'][0]['valor']
    end

    def usd_value
      response = RestClient.get("#{API_URL}/dolar")
      data = JSON.parse(response.body)
      data['serie'][0]['valor']
    end

    def uf_value
      response = RestClient.get("#{API_URL}/uf")
      data = JSON.parse(response.body)
      data['serie'][0]['valor']
    end

    def utm_value
      response = RestClient.get("#{API_URL}/utm")
      data = JSON.parse(response.body)
      data['serie'][0]['valor']
    end
  end
end
