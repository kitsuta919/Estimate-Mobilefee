=begin
###########gemfile#################

# frozen_string_literal: true
gem 'csv'
gem 'nokogiri'
source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# gem "rails"
##########/gemfile#################
The way to run
1.$ gem install bundler #bundler is one of gems
2.$ bundle init
3.$ vi Gemfile  #Edit gemfile
4.$ bundle install -path vendor/bundle
5.$ bundle exec ruby rubypra2.rb
=end
require 'rubygems'
require 'bundler/setup' 

require 'nokogiri'
require 'csv'
require 'open-uri'
# set up 
def setup_doc(url)
  charset = 'nil' 
  html = open(url) { |f| f.read }
  doc = Nokogiri::HTML.parse(html, nil, charset)
  doc.search('br').each { |n| n.replace(" ") } #replace br with  space
  doc
end
# scraping processing
  def scrape(url)
    doc = setup_doc(url)
    #pick out table and convert it to csv
    csv = CSV.open("phonedata.csv",'w',{:col_sep =>",", :quote_char => ' \' ',:force_quotes => true})
    doc.xpath('//table/tbody/tr').each do |row| 
      tarray = [] # make array
      theader = []
      ttest = []
      doc.search('div').each { |n| n.replace("") } #delete <div> tag
   
      doc.search('/div').each { |n| n.replace("") } #delete </div> tag
   
     # make array
      row.xpath('td').each do |cell|
        cell_value = (cell.text).delete(",") #delete (,) ex) 2,980 =>2980
       cell_values= cell_value.gsub(/\r?\n/m,'') #delete \\r\n
        tarray << (cell_values).encode("Windows-31J","UTF-8",undef: :replace, replace: '*')  # table value  encode utf-8replace if its are undefine symbol
      end
      #make header
      row.xpath('th').each do |header|
       header_name= header.text.gsub(/\r?\n/m,'') #delete \r\n
        theader << (header_name).encode("Windows-31J","UTF-8",undef: :replace, replace: '*')# table header encode utf-8&replace if its are undefine symbol
      end
      #combine theader and tarray
        ttest = theader + tarray
      #convert html to csv
      csv<<ttest
      end

      csv.close    # close csv file
 
    end
    # url,and  run scraping function
    url="https://kakaku.com/keitai/article/iphone/carrier.html"
  scrape(url)
  
