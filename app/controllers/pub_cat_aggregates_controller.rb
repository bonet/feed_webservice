#
# PubCatAggregatesController
# Author: Bonet Sugiarto
#

class PubCatAggregatesController < ApplicationController
  
  DEFAULT_PUB_CAT_AGGREGATE_ID = 88
  
  def new
    
    sorted_pub_cat_id_string = self.sort_numeric_csv_string(params[:pub_cat_ids]) 

    pca = PubCatAggregate.where(:pub_cat_ids_string => sorted_pub_cat_id_string).first
      
    unless pca.present?
      pca = PubCatAggregate.new(:pub_cat_ids_string => sorted_pub_cat_id_string)
      pca.save
    end

    render :text => pca.to_json
    
  end
  
  def show
    pca = PubCatAggregate.find(params[:id])
    
    render :text => pca.to_json
  end
  
  def show_default
    pca = PubCatAggregate.find(DEFAULT_PUB_CAT_AGGREGATE_ID)
    
    render :text => pca.to_json
  end
  
  def create
    
  end
  
  def sort_numeric_csv_string(str) 
    
    #Sort ascending the numbers in pub_cat_ids string
    
    sorted_pub_cat_id_array = []
    
    pub_cat_id_array = str.split(",").each do |v|
      sorted_pub_cat_id_array << v.to_i
    end
    
    sorted_pub_cat_id_string = sorted_pub_cat_id_array.sort!.join(",")  
    
  end
end