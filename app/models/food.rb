class Food < ActiveRecord::Base
  attr_accessible :id, :name, :water, :calories, :protein, :lipid_total, :ash, :carbohydrates, :fiber, :sugar_total, :calcium, :iron, :magnesium, :phosphorus, :potassium, :sodium, :zinc, :copper, :manganese, :selenium, :vit_c, :thiamin, :riboflavin, :niacin, :panto_acid, :vit_b6, :folate_total, :folic_acid, :food_folate, :folate_dfe, :choline_total, :vit_b12, :vit_a_iu, :vit_a_rae, :retinol, :alpha_carotene, :beta_carotene, :beta_crypt, :lycopene, :lut_zea, :vit_e, :vit_d_mcg, :vit_d_iu, :vit_k, :fa_sat, :fa_mono, :fa_poly, :cholesterol, :weight_1_gms, :weight_1_desc, :weight_2_gms, :weight_2_desc, :refuse_pct
  
  has_many :ingredients
  has_many :meals, :through => :ingredients
  
  # def index
  #   @meals = Meal.search(params[:search])
  # end
  
  define_index do
    # fields
    indexes :name, :sortable => true
    
    # attributes
    has :id #, calories
    
    #fuzzy search (min 2 characters)
    set_property :min_infix_len => 2
    
    #ignore punctuation and some other characters
    set_property :ignore_chars => "U+0027"    
    set_property :charset_table => "0..9, A..Z->a..z, _, a..z, U+410..U+42F->U+430..U+44F, U+430..U+44F"
    
    #ignore common words
    set_property :stopwords => "/Users/jon/Sites/diet_app/stopwords.txt"
  end
    
  # def self.search(search)
  #   if search
  #     where('name LIKE ?', "%#{search}%")
  #   else
  #     scoped
  #   end
  # end
  
end
