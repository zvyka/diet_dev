class Food < ActiveRecord::Base
  attr_accessible :food_id, :name, :water, :calories, :protein, :lipid_total, :ash, :carbohydrates, :fiber, :sugar_total, :calcium, :iron, :magnesium, :phosphorus, :potassium, :sodium, :zinc, :copper, :manganese, :selenium, :vit_c, :thiamin, :riboflavin, :niacin, :panto_acid, :vit_b6, :folate_total, :folic_acid, :food_folate, :folate_dfe, :choline_total, :vit_b12, :vit_a_iu, :vit_a_rae, :retinol, :alpha_carotene, :beta_carotene, :beta_crypt, :lycopene, :lut_zea, :vit_e, :vit_d_mcg, :vit_d_iu, :vit_k, :fa_sat, :fa_mono, :fa_poly, :cholesterol, :weight_1_gms, :weight_1_desc, :weight_2_gms, :weight_2_desc, :refuse_pct
  
  belongs_to :meal
  
  validates :serving_size, :presence => true,
                           :numericality => true,
                           :allow_blank => false
  validates :day, :presence => true
  validates :time_of_day, :presence => true
  validates :location, :presence => true
  validates :price, :presence => true
  
  def index
    @meals = Meal.search(params[:search])
  end
  
  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
  
end
