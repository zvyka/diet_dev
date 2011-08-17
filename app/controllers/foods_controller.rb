class FoodsController < ApplicationController
  before_filter :authenticate
  
  def index
    @foods = Food.search('"^' + params[:term] + '"|"' + params[:term] + '"|(' + params[:term] + ')', :match_mode => :extended2, :excerpts => false, :per_page => 100)
    respond_to do |format|
      format.html
      format.json do 
             # make an array
             @foods.map! do |u| 
               {
                 :food_id => u.id,
                 :value => u.name,
                 :grams => u.weight_1_gms,
                 :serving => u.weight_1_desc,
                 :umd => u.umd
               }
             end
             render :json => @foods 
           end
    end
  end

  def show
    @food = Food.find(params[:id])
     # @fs_foods = fs_search("cheese")
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(params[:food])
    if @food.save
      redirect_to @food, :notice => "Successfully created food."
    else
      render :action => 'new'
    end
  end

  def edit
    @food = Food.find(params[:id])
  end

  def update
    @food = Food.find(params[:id])
    if @food.update_attributes(params[:food])
      redirect_to @food, :notice  => "Successfully updated food."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_url, :notice => "Successfully destroyed food."
  end
  
  # SECRET = Credentials.first.shared_secret 
  # KEY = Credentials.first.consumer_key
  # SHA1 = "HMAC-SHA1" 
  # SITE = "http://platform.fatsecret.com/rest/server.api" 
  
  # class String 
  #   def esc 
  #       CGI.escape(self).gsub("%7E", "~").gsub("+", "%20") 
  #   end 
  # end
   
  # def fs_search(expression) 
  #    creds = Credentials.first
  #    params = { 
  #      :oauth_consumer_key => Credentials.first.consumer_key, 
  #      :oauth_nonce => "1234", 
  #      :oauth_signature_method => "HMAC-SHA1", 
  #      :oauth_timestamp => Time.now.to_i, 
  #      :oauth_version => "1.0", 
  #      :method => 'foods.search', 
  #      :search_expression => expression 
  #    } 
  #    sorted_params = params.sort {|a, b| a.first.to_s <=> b.first.to_s} 
  #    base = base_string("GET", sorted_params) 
  #    http_params = http_params("GET", params) 
  #    sig = sign(base).gsub("%7E", "~").gsub("+", "%20") 
  #    uri = uri_for(http_params, sig) 
  #    results = Net::HTTP.get(uri) 
  #  end
  #  
  #  def base_string(http_method, param_pairs) 
  #    param_str = param_pairs.collect{|pair| "#{pair.first}=#{pair.last}"}.join('&') 
  #    list = [http_method.gsub("%7E", "~").gsub("+", "%20"), "http://platform.fatsecret.com/rest/server.api".gsub("%7E", "~").gsub("+", "%20"), param_str.gsub("%7E", "~").gsub("+", "%20")] 
  #    list.join("&") 
  #  end 
  #  
  #  def http_params(method, args) 
  #    pairs = args.sort {|a, b| a.first.to_s <=> b.first.to_s} 
  #    list = [] 
  #    pairs.inject(list) {|arr, pair| arr << "#{pair.first.to_s}=#{pair.last}"} 
  #    list.join("&") 
  #  end 
  #    
  #  def sign(base, token='') 
  #    secret = "#{Credentials.first.shared_secret.gsub("%7E", "~").gsub("+", "%20")}&#{token.gsub("%7E", "~").gsub("+", "%20")}" 
  #    base64 = Base64.encode64(OpenSSL::HMAC.digest('sha1', base, secret)).gsub(/\n/, '') 
  #  end 
  #  
  #  def uri_for(params, signature) 
  #    parts = params.split('&') 
  #    parts << "oauth_signature=#{signature}" 
  #    URI.parse("http://platform.fatsecret.com/rest/server.api?#{parts.join('&')}") 
  #  end
end
