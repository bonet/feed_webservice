#
# PubCatsController
# Author: Bonet Sugiarto
#

class PubCatsController < ApplicationController
  
  def new
    
    @pub_cat = PubCat.new
    
    @publisher_array = [["", nil]]
    
    Publisher.all.each do |p|
      @publisher_array <<  [ p.name, p._id ]
    end
    
    @category_array = [["", nil]]
    
    Category.all.each do |c|
      @category_array <<  [ c.name, c._id ]
    end
    
    @pub_cat_array = []
    
    PubCat.all.each do |pc|
      h = {}
      
      p = Publisher.find(pc.publisher_id)
      c = Category.find(pc.category_id)
      
      h['_id'] = pc._id.to_s
      h['publisher'] = { p._id.to_s => p.name }
      h['category'] = { c._id.to_s => c.name }
      
      @pub_cat_array.push h
    end
    
  end
  
  def create
    @pub_cat = PubCat.new(params[:pub_cat])
    @pub_cat.save
    
    redirect_to :action => 'new'
  end
  
  # This is to update available PubCats, i.e. admin might have added one or more PubCats; running this update will sync PubCatNamelist with all existing PubCats
  def cron_update_pub_cat_namelist
    
     # Password check
    if params[:cron_pass] != ENV['CRON_PASS']
      return render :nothing => true
    end
    
    n = {}
    
    PubCatNamelist.delete_all

    Publisher.all.each do |pub|
      PubCat.where(:publisher_id => pub._id).each do |pubcat|
        n[pub._id]  = {:publisher_id => pub._id, :publisher_name => pub.name, :categories => []} if n[pub._id] .nil?
        n[pub._id][:categories] << {:pub_cat_id => pubcat._id, :category_id => pubcat.category_id, :category_name => Category.find(pubcat.category_id).name}
      end
      
    end

    PubCatNamelist.create(:namelist => n)

    render :nothing => true
  end
  
  def get_pub_cat_namelist
    render :text => PubCatNamelist.first.namelist.to_json
  end
  
  def get_personalized_pub_cat_namelist
    
    if params[:pub_cat_aggregate_id].nil?
      render :nothing => true
    else
      pca = PubCatAggregate.find(params[:pub_cat_aggregate_id])
      pc_ids_array = pca['pub_cat_ids_string'].split(",")
       
      
      result = {}
      PubCatNamelist.first.namelist.each do |k,v|
        
        v['categories'].each_with_index do |n,m|
          
          if pc_ids_array.include? n['pub_cat_id'].to_s
            v['categories'][m.to_i]['owned'] = "true"
          else
            v['categories'][m.to_i]['owned'] = "false"
          end
          
        end
        
        result[k] = v
      end
      
      render :text => result.to_json
    end
    
  end
  
end