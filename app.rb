require "sinatra"
require "sinatra/reloader" if development?
require 'open-uri'
require 'json'
require 'csv'

require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

get '/ex-rate' do
  result = sorting_data("http://apiservice.mol.gov.tw/OdService/download/A17030000J-000049-ljY")

  erb :exchangerate, locals: { result: result }
end

get '/mask' do
  result = sorting_csv_data("http://data.nhi.gov.tw/Datasets/Download.ashx?rid=A21030000I-D50001-001&l=https://data.nhi.gov.tw/resource/mask/maskdata.csv")
  p result[0]["醫事機構代碼"]
  erb :mask , locals: { result: result[0]["醫事機構代碼"] }
end

def sorting_json_data(url)
  data = open(url).read
  JSON.parse(data)
end

def sorting_csv_data(url)
  data = open(url).read
  CSV.parse(data, headers: true)
end