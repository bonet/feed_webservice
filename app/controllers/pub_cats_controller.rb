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
    
    #@pub_cat_array.sort { |x,y| y.keys[0] <=> x.keys[0] }
    
    
  end
  
  def create
    @pub_cat = PubCat.new(params[:pub_cat])
    @pub_cat.save
    
    redirect_to :action => 'new'
  end
  
  
  def update_pub_cat_namelist
    n = {}
    Publisher.all.each do |pub|
      PubCat.where(:publisher_id => pub._id).each do |pubcat|
        n[pub._id]  = {:publisher_id => pub._id, :publisher_name => pub.name, :categories => []} if n[pub._id] .nil?
        n[pub._id][:categories] << {:category_id => pubcat.category_id, :category_name => Category.find(pubcat.category_id).name}
      end
      
    end
    
    PubCatNamelist.create(:namelist => n)
    render :text => n.inspect.to_s
  end
  
  def get_pub_cat_namelist
    render :text => PubCatNamelist.first.namelist.to_json
  end
  
end