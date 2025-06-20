class AppSetting < ApplicationRecord
  belongs_to :thing, polymorphic: true, optional: true

  validates :var, presence: true
  validates :var, uniqueness: { scope: %i[thing_type thing_id] }

  def self.get_global(var_name)
    find_by(thing_type: nil, thing_id: nil, var: var_name)&.value
  end

  def self.set_global(var_name, value)
    setting = find_or_initialize_by(thing_type: nil, thing_id: nil, var: var_name)
    setting.value = value
    setting.save
  end

  def self.get_for(thing, var_name)
    find_by(thing_type: thing.class.base_class.name, thing_id: thing.id, var: var_name)&.value
  end

  def self.set_for(thing, var_name, value)
    setting = find_or_initialize_by(thing_type: thing.class.base_class.name, thing_id: thing.id, var: var_name)
    setting.value = value
    setting.save
  end

  def value_casted
    case value
    when 'true' then true
    when 'false' then false
    when /\A\d+\z/ then value.to_i
    when /\A\d+\.\d+\z/ then value.to_f
    when /\A\{.*\}\z/ then begin
      JSON.parse(value)
    rescue StandardError
      value
    end
    when /\A\[.*\]\z/ then begin
      JSON.parse(value)
    rescue StandardError
      value
    end
    else value
    end
  end
end
